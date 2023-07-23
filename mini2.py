import json

from flask import Flask, render_template, SQLAlchemy, flash, request, redirect, url_for, session
import mysql
import flask.globals
from flask.globals import request
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

from flask_login import login_required, logout_user, login_user, login_manager, LoginManager, current_user
from flask_mail import Mail



local_server = True
app = Flask(__name__)
app.secret_key = "nikhil"


with open('config.json', 'r') as c:
    params = json.load(c)["params"]


app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)



login_manager = LoginManager(app)
login_manager.login_view = 'login'

# app.config['SQLALCHEMY_DATABASE_URI']='mysql://username:password@localhost/databasename'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/tours_and_travels'
db = SQLAlchemy(app)



@login_manager.user_loader
def load_user(user_id):
    return user.query.get(int(user_id))


class Payment(db.Model):
    id_no = db.Column(db.String(30), primary_key=True)
    ac_charge = db.Column(db.Integer)
    food_charge = db.Column(db.Integer)
    cust_id = db.Column(db.String(50))
    hotel_id = db.Column(db.String(50))


class user(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    srfid = db.Column(db.String(30), unique=True)
    email = db.Column(db.String(100))
    dob = db.Column(db.String(1000))



class hotel(UserMixin, db.Model):
    hotel_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), primary_key=True)
    email = db.Column(db.String(50), unique=True)
    password = db.Column(db.String(1000), unique=True)

    hotel_name = db.Column(db.String(50))



class hotel_details(UserMixin, db.Model):
    hid = db.Column(db.Integer, primary_key=True)
    hotel_code = db.Column(db.String(20), primary_key=True)
    hotel_name = db.Column(db.String(20))
    address = db.Column(db.String(20))

    package = db.Column(db.String(10))




class customer(UserMixin, db.Model):
    customer_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), primary_key=True)
    name = db.Column(db.String(30))
    country = db.Column(db.String(20))
    gender = db.Column(db.String(5))
    address = db.Column(db.String(50))
    phone = db.Column(db.String(10))
    email = db.Column(db.String(50))


@app.route("/")
def hello():
    return render_template('index.html')


@app.route("/usersignup")
def usersignup():
    return render_template('usersignup.html')


@app.route("/userlogin")
def userlogin():
    return render_template('userlogin.html')


@app.route('/signup', methods=['POST', 'GET'])
def signup():
    if request.method == "POST":
        srfid = request.form.get('srf')
        email = request.form.get('email')
        dob = request.form.get('dob')
        #print(srfid, email, dob)
        encpassword = generate_password_hash(dob)
        User = user.query.filter_by(srfid=srfid).first()
        emailUser = user.query.filter_by(email=email).first()
        if User or emailUser:
            flash("Email or srfid is already taken", "warning")
            return render_template("usersignup.html")
        new_user = db.engine.execute(f"INSERT INTO `user` (`srfid`,`email`,`dob`)VALUES ('{srfid}','{email}','{encpassword}') ")


        flash("Signup Successs please login", "success")
        return render_template("userlogin.html")

    return render_template("usersignup.html")


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == "POST":
        srfid = request.form.get('srf')
        dob = request.form.get('dob')
        User = user.query.filter_by(srfid=srfid).first()


        if User and check_password_hash(User.dob, dob):
            login_user(User)
            flash("Login success", "info")
            return render_template("index.html")
        else:
            flash("invalid credentials", "danger")
            return render_template("userlogin.html")

    return render_template("userlogin.html")

@app.route('/admin', methods=['POST', 'GET'])
def admin():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')
        if(username==params['user'] and password==params['password']):
            session['user'] = username
            flash("login success", "info")
            return render_template("packagedata.html")

        else:
            flash("invalid credentials", "danger")

    return render_template("admin.html")

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout Successful", "warning")
    return redirect(url_for('login'))


@app.route('/addhotelinfo', methods=['POST', 'GET'])
def addhotelinfo():

    if('user' in session and session['user']==params['user']):
        if request.method == "POST":
            hotel_code = request.form.get('hotel_code')
            hotel_name = request.form.get('hotel_name')
            address = request.form.get('address')

            package = request.form.get('package')
            hotel_code = hotel_code.upper()

            #encpassword = generate_password_hash(password)

            emailUser = hotel_details.query.filter_by(hotel_code=hotel_code).first()
            if emailUser:
                flash("hotel is already taken", "warning")
                return render_template("usersignup.html")
            db.engine.execute(f"INSERT INTO `hotel_details` (`hotel_code`,`hotel_name`,`address`,`package`)VALUES ('{hotel_code}','{hotel_name}','{address}','{package}') ")

            #mail.send_messsage('tours_and_travels', sender=params['gmail-user'], recipients=[email], body=f"Welcome thanks for choosing us\nYour login credentials are:\nEmail Address: {email}\npassword: {password}\n\n\n\nDo not share your password\n\n\nThank You..." )

            flash("data send and  inserted succesfully", "warning")
            return render_template("packagedata.html")
    else:
        flash("Login and try Again", "warning")
        return redirect('/admin')

    return render_template("packagedata.html")


@app.route("/hedit/<string:hid>", methods=['POST', 'GET'])
@login_required
def hedit(hid):
    posts = hotel_details.query.filter_by(hid=hid).first()
    if request.method == "POST":
        hotel_code = request.form.get('hotel_code')
        hotel_name = request.form.get('hotel_name')
        address = request.form.get('address')

        package = request.form.get('package')
        hotel_code = hotel_code.upper()
        db.engine.execute(f"UPDATE `hotel_details` SET `hotel_code` ='{hotel_code}',`hotel_name`='{hotel_name}',`address`='{address}',`package`='{package}' WHERE `hotel_details`.`hid`={hid}")
        flash("Slot Updated", "info")
        return redirect("/addhotelinfo")


    return render_template("hedit.html",posts=posts)


@app.route("/hdelete/<string:hid>", methods=['POST', 'GET'])
@login_required
def hdelete(hid):
    db.engine.execute(f"DELETE FROM `hotel_details` WHERE `hospitaldata`.`hid`={hid}")
    flash("Date Deleted", "danger")
    return redirect("/addhotelinfo")









@app.route('/customers', methods=['POST', 'GET'])
def cust():

        if request.method == "POST":
            username = request.form.get('username')
            name = request.form.get('name')
            country = request.form.get('country')
            gender = request.form.get('gender')
            address = request.form.get('address')
            phone = request.form.get('phone')
            email = request.form.get('email')

            #encpassword = generate_password_hash(password)

            emailUser = customer.query.filter_by(email=email).first()
            if emailUser:
                flash("email is already taken", "warning")
                return render_template("customers.html")
            db.engine.execute(f"INSERT INTO `customer` (`username`,`name`,`country`,`gender`,`address`,`phone`,`email`)VALUES ('{username}','{name}','{country}','{gender}','{address}','{phone}','{email}') ")

            #mail.send_messsage('tours_and_travels', sender=params['gmail-user'], recipients=[email], body=f"Welcome thanks for choosing us\nYour login credentials are:\nEmail Address: {email}\npassword: {password}\n\n\n\nDo not share your password\n\n\nThank You..." )

            flash("data send and  inserted succesfully", "warning")
            return render_template("index.html")


        return render_template("customers.html")















@app.route("/Payment")
def Payment():
    try:

        a = Payment
        print(a)
        return 'MY DATABASE IS CONNECTED'
    except Exception as e:
        print(e)
        return f'MY DATABASE IS NOT CONNECTED {e}'


@app.route("/logoutadmin")
def logoutadmin():
    session.pop('user')
    flash("you are logout admin", "primary")

    return redirect('/admin')
















app.run(debug=True)
