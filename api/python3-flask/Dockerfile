# https://medium.com/faun/getting-started-with-docker-using-python-flask-application-b6dcd1a08626
# https://flask.palletsprojects.com/en/1.1.x/deploying/wsgi-standalone/#gunicorn

FROM alpine:3

RUN apk add --no-cache python3

WORKDIR /app

COPY requirements.txt .
RUN pip3 --no-cache-dir install --requirement requirements.txt

COPY . .

CMD gunicorn --bind 0.0.0.0:80 app:app

EXPOSE 80
