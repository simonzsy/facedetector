FROM ubuntu:16.04

# RUN apt-get update && apt-get install -y python
RUN apt-get update && apt-get install -y python-pip
RUN apt-get update && apt-get install -y wget 
RUN apt-get update && apt-get install -y bzip2 
RUN apt-get update && apt-get install -y python-dev 
RUN apt-get update && apt-get install -y cmake
RUN apt-get update && apt-get install -y zip 
RUN apt-get update && apt-get install -y libboost-all-dev 
RUN apt-get update && apt-get install -y gunicorn
RUN apt-get update && apt-get install -y libsm6 
RUN apt-get update && apt-get install -y libxext6 
RUN apt-get update && apt-get install -y libfontconfig1 
RUN apt-get update && apt-get install -y libxrender1

COPY . /app

WORKDIR /app/face_detection/data
RUN chmod +x models.sh && ./models.sh

WORKDIR /app
RUN pip install -r requirements.txt

#EXPOSE 5000

CMD [ "gunicorn", "-bind :8080", "server:app" ]
