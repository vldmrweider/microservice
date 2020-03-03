FROM library/python:3.7-slim

COPY requirements.txt /app/
COPY dist/microservice-*.whl /app/

WORKDIR /app

RUN pip3.7 install -r requirements.txt
RUN pip3.7 install microservice-*.whl

EXPOSE 8080