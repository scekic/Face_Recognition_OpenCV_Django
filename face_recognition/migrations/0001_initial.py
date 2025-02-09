from __future__ import unicode_literals

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Records',
            fields=[
                ('id', models.CharField(max_length=100, primary_key=True, serialize=False)),
                ('first_name', models.CharField(max_length=50)),
                ('last_name', models.CharField(max_length=50, null=True)),
                ('residence', models.CharField(max_length=50, null=True)),
                ('country', models.CharField(max_length=50, null=True)),
                ('education', models.CharField(max_length=150, null=True)),
                ('occupation', models.CharField(max_length=150, null=True)),
                ('marital_status', models.CharField(max_length=50, null=True)),
                ('bio', models.TextField()),
                ('recorded_at', models.DateTimeField(blank=True, default=datetime.datetime.now)),
            ],
        ),
    ]
