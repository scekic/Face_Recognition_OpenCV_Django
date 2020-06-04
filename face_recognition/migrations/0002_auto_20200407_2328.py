from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('face_recognition', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='records',
            options={'verbose_name_plural': 'Records'},
        ),
    ]
