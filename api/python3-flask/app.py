# https://medium.com/faun/getting-started-with-docker-using-python-flask-application-b6dcd1a08626

from flask import Flask

app = Flask(__name__)

@app.route('/health-check/')
def health_check():
    return 'Health check OK'

if __name__ == '__main__':
    app.run()
