import flask
from flask import Flask, render_template

app = Flask(__name__)


@app.route('/')
def hello():
    return render_template('index.html')


@app.route("/usersignup.html")
def usersignup():
    return render_template("usersignup.html")



@app.route('/about')
def harry():
    name = 'nikhil'
    return render_template('about.html', name1=name)

@app.route('/bootstrap')
def bootstrap():

    return render_template('bootstrap.html')

app.run(debug=True)