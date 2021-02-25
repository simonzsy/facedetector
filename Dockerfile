FROM ubuntu:latest

RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt-get clean
RUN apt-get update
RUN apt-get install -y python-pip
RUN apt-get install -y wget 
RUN apt-get install -y bzip2 
RUN apt-get install -y python-dev 
RUN apt-get install -y cmake
RUN apt-get install -y zip 
RUN apt-get install -y libboost-all-dev 
RUN apt-get install -y gunicorn
RUN apt-get install -y libsm6 
RUN apt-get install -y libxext6 
RUN apt-get install -y libfontconfig1 
RUN apt-get install -y libxrender1

COPY . /app

WORKDIR /app/face_detection/data
RUN chmod +x models.sh && ./models.sh

WORKDIR /app
RUN pip install -r requirements.txt

#EXPOSE 5000

CMD [ "gunicorn", "-b 0.0.0.0:5000", "server:app" ]
