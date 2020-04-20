# https://medium.com/faun/getting-started-with-docker-using-python-flask-application-b6dcd1a08626

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'This is my flask application!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
