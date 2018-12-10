from django.db import models

# Create your models here.

class Video(models.Model):
  name = models.CharField(max_length=100)
  description = models.TextField(max_length=1000)
  update = models.DateField(auto_now=True)
  videofile = models.FileField()

  def __str__(self):
    return self.name
