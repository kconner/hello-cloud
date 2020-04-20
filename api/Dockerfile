# https://medium.com/faun/getting-started-with-docker-using-python-flask-application-b6dcd1a08626
# https://flask.palletsprojects.com/en/1.1.x/deploying/wsgi-standalone/#gunicorn

FROM alpine:3

RUN apk add --no-cache python3 py3-gunicorn
RUN pip3 --no-cache-dir install flask

WORKDIR /app
COPY . .

CMD gunicorn --bind 0.0.0.0:80 main:app

EXPOSE 80
