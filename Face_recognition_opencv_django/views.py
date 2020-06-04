import imutils
from imutils import paths
from imutils.video import VideoStream
from imutils.video import FPS
import time
import cv2
import numpy as np
from Face_recognition_opencv_django.settings import BASE_DIR
from django.shortcuts import render, redirect
import pickle
from sklearn.preprocessing import LabelEncoder
from sklearn.svm import SVC


def index(request):
    return render(request, 'index.html')


def create_dataset(request):
    userId = request.POST['userId']

    detector = cv2.CascadeClassifier(BASE_DIR+'/ml/haarcascade_frontalface_default.xml')
    vs = VideoStream(src=0).start()
    time.sleep(2.0)
    id = userId
    total = 0

    while True:
        frame = vs.read()
        orig = frame.copy()
        frame = imutils.resize(frame, width=400)

        rects = detector.detectMultiScale(cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY), scaleFactor=1.1,
                                          minNeighbors=5, minSize=(30, 30))

        for (x, y, w, h) in rects:
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)

        cv2.imshow('Frame', frame)
        key = cv2.waitKey(1) & 0xFF

        if key == ord('k'):
            if total == 0:
                cv2.imwrite(BASE_DIR + '/static/img/' + str(id) + '.jpg', orig)
            cv2.imwrite(BASE_DIR+'/ml/dataset/user.'+str(id)+'.'+str(total)+'.jpg', orig)
            total += 1
        elif key == ord('q'):
            break

    cv2.destroyAllWindows()
    vs.stop()

    return redirect('/')


def extract_embeddings():
    protoPath = BASE_DIR+'/ml/face_detection_model/deploy.prototxt'
    modelPath = BASE_DIR+'/ml/face_detection_model/res10_300x300_ssd_iter_140000.caffemodel'
    detector = cv2.dnn.readNetFromCaffe(protoPath, modelPath)

    embedder = cv2.dnn.readNetFromTorch(BASE_DIR+'/ml/openface_nn4.small2.v1.t7')

    imagePaths = list(paths.list_images(BASE_DIR+'/ml/dataset'))

    knownEmbeddings = []
    knownNames = []

    total = 0

    for (i, imagePath) in enumerate(imagePaths):
        name = imagePath.split('.')[-3]

        image = cv2.imread(imagePath)
        image = imutils.resize(image, width=600)
        (h, w) = image.shape[:2]

        imageBlob = cv2.dnn.blobFromImage(cv2.resize(image, (300, 300)), 1.0, (300, 300),
                                          (104.0, 177.0, 123.0), swapRB=False, crop=False)
        detector.setInput(imageBlob)
        detections = detector.forward()

        if len(detections) > 0:
            i = np.argmax(detections[0, 0, :, 2])
            confidence = detections[0, 0, i, 2]

            if confidence > 0.5:
                box = detections[0, 0, i, 3:7] * np.array([w, h, w, h])
                (startX, startY, endX, endY) = box.astype("int")

                face = image[startY:endY, startX:endX]
                (fH, fW) = face.shape[:2]

                if fW < 20 or fH < 20:
                    continue

                faceBlob = cv2.dnn.blobFromImage(face, 1.0 / 255,
                                                 (96, 96), (0, 0, 0), swapRB=True, crop=False)
                embedder.setInput(faceBlob)
                vec = embedder.forward()

                knownNames.append(name)
                knownEmbeddings.append(vec.flatten())
                total += 1

    data = {"embeddings": knownEmbeddings, "names": knownNames}
    f = open(BASE_DIR+'/ml/output/embeddings.pickle', "wb")
    f.write(pickle.dumps(data))
    f.close()


def trainer(request):

    extract_embeddings()

    data = pickle.loads(open(BASE_DIR + '/ml/output/embeddings.pickle', "rb").read())

    le = LabelEncoder()
    labels = le.fit_transform(data["names"])

    recognizer = SVC(C=1.0, kernel="linear", probability=True)
    recognizer.fit(data["embeddings"], labels)

    f = open(BASE_DIR + '/ml/output/recognizer.pickle', "wb")
    f.write(pickle.dumps(recognizer))
    f.close()

    f = open(BASE_DIR + '/ml/output/le.pickle', "wb")
    f.write(pickle.dumps(le))
    f.close()

    return redirect('/')


def detect(request):
    protoPath = BASE_DIR+'/ml/face_detection_model/deploy.prototxt'
    modelPath = BASE_DIR+'/ml/face_detection_model/res10_300x300_ssd_iter_140000.caffemodel'
    detector = cv2.dnn.readNetFromCaffe(protoPath, modelPath)

    embedder = cv2.dnn.readNetFromTorch(BASE_DIR+'/ml/openface_nn4.small2.v1.t7')

    recognizer = pickle.loads(open(BASE_DIR+'/ml/output/recognizer.pickle', "rb").read())
    le = pickle.loads(open(BASE_DIR+'/ml/output/le.pickle', "rb").read())

    vs = VideoStream(src=0).start()
    time.sleep(2.0)

    fps = FPS().start()

    userId = 0

    while True:
        frame = vs.read()

        frame = imutils.resize(frame, width=600)
        (h, w) = frame.shape[:2]

        imageBlob = cv2.dnn.blobFromImage(
            cv2.resize(frame, (300, 300)), 1.0, (300, 300),
            (104.0, 177.0, 123.0), swapRB=False, crop=False)

        detector.setInput(imageBlob)
        detections = detector.forward()

        for i in range(0, detections.shape[2]):
            confidence = detections[0, 0, i, 2]

            if confidence > 0.8:
                box = detections[0, 0, i, 3:7] * np.array([w, h, w, h])
                (startX, startY, endX, endY) = box.astype("int")

                face = frame[startY:endY, startX:endX]
                (fH, fW) = face.shape[:2]

                if fW < 20 or fH < 20:
                    continue

                faceBlob = cv2.dnn.blobFromImage(face, 1.0 / 255,
                                                 (96, 96), (0, 0, 0), swapRB=True, crop=False)
                embedder.setInput(faceBlob)
                vec = embedder.forward()

                preds = recognizer.predict_proba(vec)[0]
                j = np.argmax(preds)
                proba = preds[j]
                userId = le.classes_[j]

                text = "{}: {:.2f}%".format(userId, proba * 100)
                y = startY - 10 if startY - 10 > 10 else startY + 10
                cv2.rectangle(frame, (startX, startY), (endX, endY),
                              (0, 0, 255), 2)
                cv2.putText(frame, text, (startX, y),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.45, (0, 0, 255), 2)

        fps.update()

        cv2.imshow("Frame", frame)
        key = cv2.waitKey(1) & 0xFF

        if key == ord("q"):
            break
        elif userId != 0:
            cv2.waitKey(1000)
            vs.stop()
            cv2.destroyAllWindows()
            return redirect('/records/details/' + str(userId))

    fps.stop()

    cv2.destroyAllWindows()
    vs.stop()
    return redirect('/')
