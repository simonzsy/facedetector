FROM ubuntu:latest

RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt-get clean
RUN apt-get update
RUN apt-get install -y wget 
RUN wget -O /tmp/get-pip3.py https://bootstrap.pypa.io/get-pip3.py
RUN python /tmp/get-pip3.py
RUN pip3 install
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
RUN pip3 install scikit-build
RUN pip3 install -r requirements.txt

#EXPOSE 5000

CMD [ "gunicorn", "--bind :8080", "server:app" ]
