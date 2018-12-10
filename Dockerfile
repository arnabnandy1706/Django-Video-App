FROM centos:latest
LABEL maintainer "Arnab Kumar Nandy <arnab.nandy1991@gmail.com>"
RUN yum install epel-release -y
RUN yum install gcc openssl-devel bzip2-devel wget curl make sqlite3-devel sqlite-devel -y
WORKDIR /tmp/
RUN wget https://www.python.org/ftp/python/3.6.6/Python-3.6.6.tgz
RUN tar xzf Python-3.6.6.tgz
WORKDIR /tmp/Python-3.6.6
RUN ./configure
RUN make
RUN make install
RUN pip3 install django
RUN mkdir /opt/django
WORKDIR /opt/django
RUN django-admin startproject Videoapp
RUN python3 Videoapp/manage.py startapp videoapp
ADD Videoapp/Videoapp/settings.py /opt/django/Videoapp/Videoapp/settings.py
ADD Videoapp/Videoapp/urls.py /opt/django/Videoapp/Videoapp/urls.py
ADD Videoapp/videoapp/urls.py /opt/django/Videoapp/videoapp/urls.py
ADD Videoapp/videoapp/views.py /opt/django/Videoapp/videoapp/views.py
ADD Videoapp/videoapp/admin.py /opt/django/Videoapp/videoapp/admin.py
ADD Videoapp/videoapp/models.py /opt/django/Videoapp/videoapp/models.py
ADD Videoapp/videoapp/templates/index.html /opt/django/Videoapp/videoapp/templates/index.html
ADD Videoapp/videoapp/static/images/desc-icon.png /opt/django/Videoapp/videoapp/static/images/desc-icon.png
ADD Videoapp/videoapp/static/images/logo.png /opt/django/Videoapp/videoapp/static/images/logo.png
ADD Videoapp/videoapp/static/images/update-icon.png /opt/django/Videoapp/videoapp/static/images/update-icon.png
RUN python3 Videoapp/manage.py makemigrations
RUN python3 Videoapp/manage.py migrate --run-syncdb
RUN echo "from django.contrib.auth.models import User;User.objects.create_superuser('admin', 'admin@example.com', 'root123')" | python3 Videoapp/manage.py shell
EXPOSE 8000
CMD ["python3", "Videoapp/manage.py", "runserver", "0.0.0.0:8000"]
