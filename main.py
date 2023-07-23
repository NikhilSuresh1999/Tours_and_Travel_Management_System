import json

from flask import Flask, render_template, SQLAlchemy, flash, request, redirect, url_for, session
#import mysql
import flask.globals
from flask.globals import request
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

from flask_login import login_required, logout_user, login_user, login_manager, LoginManager, current_user
from flask_mail import Mail
seat = 0


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
    return user.query.get(int(user_id))or hoteluser.query.get(int(user_id))


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



class hoteluser(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    hcode = db.Column(db.String(30), unique=True)
    email = db.Column(db.String(50))
    password = db.Column(db.String(1000))






class Hotel(UserMixin, db.Model):
    hotel_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), primary_key=True)
    email = db.Column(db.String(50), unique=True)
    password = db.Column(db.String(1000), unique=True)

    hotel_name = db.Column(db.String(50))



class hotel_details(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    hcode = db.Column(db.String(30))
    email = db.Column(db.String(50))
    hotel_name = db.Column(db.String(20))
    hotel_type = db.Column(db.String(10))
    rooms = db.Column(db.Integer)
    address = db.Column(db.String(20))

    package = db.Column(db.String(10))


class trig(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    hcode = db.Column(db.String(30))
    hotel_name = db.Column(db.String(20))
    rooms = db.Column(db.Integer)
    package = db.Column(db.String(10))
    querys = db.Column(db.String(50))
    date = db.Column(db.String(50))



class package(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(50))
    pack_type = db.Column(db.String(10), primary_key=True)
    pname = db.Column(db.String(50))
    start = db.Column(db.String(10))
    destination = db.Column(db.String(10))
    hcode = db.Column(db.String(30))
    hotel_name = db.Column(db.String(20))
    persons = db.Column(db.Integer)
    cost = db.Column(db.Integer)










class booking_package(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    srfid = db.Column(db.String(20), unique=True)
    pack_id = db.Column(db.Integer)
    pack_type = db.Column(db.String(100))
    hcode = db.Column(db.String(30))
    hotel_name = db.Column(db.String(30))
    cost = db.Column(db.Integer)
    email = db.Column(db.String(30))
    username = db.Column(db.String(100))
    phone = db.Column(db.String(10))
    address = db.Column(db.String(100))





class customer(db.Model):
    customer_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50))
    name = db.Column(db.String(30))
    country = db.Column(db.String(20))
    gender = db.Column(db.String(5))
    address = db.Column(db.String(50))
    phone = db.Column(db.String(10))
    email = db.Column(db.String(50))





class trig2(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer)
    username = db.Column(db.String(50))
    phone = db.Column(db.String(10))
    email = db.Column(db.String(50))
    querys = db.Column(db.String(50))
    date = db.Column(db.String(50))





class payments(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    upi_id = db.Column(db.Integer)
    upi_pin = db.Column(db.Integer)

    email = db.Column(db.String(30))
    phone = db.Column(db.String(10))






@app.route("/")
def hello():
    return render_template('index.html')

@app.route("/hudetails")

def hudetails():
    query = hoteluser.query.all()
    return render_template("hudetails.html", query=query)


@app.route("/trigers")
@login_required
def trigers():
    query = trig2.query.all()
    return render_template("triggers.html", query=query)

@app.route("/triger")

def triger():
    query = trig.query.all()
    return render_template("trigger.html", query=query)


@app.route("/usersignup")
def usersignup():
    return render_template('usersignup.html')


@app.route("/userlogin")
def userlogin():
    return render_template('userlogin.html')



@app.route("/confirm")
def confirm():
    flash("your payment is successfull Get ready for the Trip...", "success")
    return redirect("/bills")
    #return render_template('bills.html')



@app.route("/downloaded")
def download():
    flash("you have been successfully downloaded the bill...", "success")
    return redirect("/")




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
            return redirect('/customers')
        else:
            flash("invalid credentials", "danger")
            return render_template("userlogin.html")

    return render_template("userlogin.html")



@app.route('/hotellogin',methods=['POST','GET'])
def hotelallogin():
    if request.method == "POST":
        email = request.form.get('email')
        password=request.form.get('password')
        user=hoteluser.query.filter_by(email=email).first()
        if user and check_password_hash(user.password, password):
            login_user(user)
            flash("Login Success", "info")
            return render_template("index.html")
        else:
            flash("Invalid Credentials", "danger")
            return render_template("hotellogin.html")


    return render_template("hotellogin.html")








@app.route('/admin', methods=['POST', 'GET'])
def admin():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')
        if (username == params['user'] and password == params['password']):
            session['user'] = username
            flash("login success", "info")
            return render_template("addhoteluser.html")
        else:
            flash("Invalid Credentials", "danger")

    return render_template("admin.html")

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout Successful", "danger")
    return redirect(url_for('login'))


@app.route('/addhoteluser', methods=['POST', 'GET'])
def hoteluserUser():
    if ('user' in session and session['user'] == params['user']):

        if request.method == "POST":
            hcode = request.form.get('hcode')
            email = request.form.get('email')
            password = request.form.get('password')
            encpassword = generate_password_hash(password)
            hcode = hcode.upper()
            emailUser = hoteluser.query.filter_by(email=email).first()
            if emailUser:
                flash("Email or srif is already taken", "warning")

            db.engine.execute(f"INSERT INTO `hoteluser` (`hcode`,`email`,`password`) VALUES ('{hcode}','{email}','{encpassword}') ")

            # my mail starts from here if you not need to send mail comment the below line

            #mail.send_message('tours and travel', sender=params['gmail-user'], recipients=[email], body=f"Welcome thanks for choosing us\nYour Login Credentials Are:\n Email Address: {email}\nPassword: {password}\n\nHotel Code {hcode}\n\n Do not share your password\n\n\nThank You...")

            flash("Data Sent and Inserted Successfully", "warning")
            return render_template("addhoteluser.html")
    else:
        flash("Login and try Again", "warning")
        return render_template("addhoteluser.html")




@app.route("/addhotelinfo",methods=['POST','GET'])
def addhotelinfo():
    email = current_user.email
    posts = hoteluser.query.filter_by(email=email).first()
    code = posts.hcode
    postsdata = hotel_details.query.filter_by(hcode=code).first()

    if request.method == "POST":
        hcode = request.form.get('hcode')
        email = request.form.get('email')
        hotel_name = request.form.get('hotel_name')
        hotel_type = request.form.get('hotel_type')
        rooms = request.form.get('rooms')
        address = request.form.get('address')
        package = request.form.get('package')

        hcode = hcode.upper()
        huser = hoteluser.query.filter_by(hcode=hcode).first()
        hduser = hotel_details.query.filter_by(hcode=hcode).first()
        emailUser = hotel_details.query.filter_by(email=email).first()
        if emailUser:
            flash("email is already taken", "warning")
            return render_template("hoteldata.html", postsdata=postsdata)
        if hduser:
            flash("Data is already Present you can update it..", "primary")
            return render_template("hoteldata.html", postsdata=postsdata)
        if huser:
            db.engine.execute(f"INSERT INTO `hotel_details` (`hcode`,`email`,`hotel_name`,`hotel_type`,`rooms`,`address`,`package`) VALUES ('{hcode}','{email}','{hotel_name}','{hotel_type}','{rooms}','{address}','{package}')")
            flash("Data Is Added", "primary")
        else:
            flash("Hotel Code not Exist", "warning")

    return render_template("hoteldata.html", postsdata=postsdata)



@app.route('/paydetails')
@login_required
def paydetails():
    srfid = current_user.srfid
    posts = booking_package.query.filter_by(srfid=srfid).first()
    if request.method == "POST":
        id = request.form.get('id')
        srfid = request.form.get('srfid')
        cost = request.form.get('cost')
        email = request.form.get('email')
        username = request.form.get('username')
        phone = request.form.get('phone')
        huser = booking_package.query.filter_by(srfid=srfid).first()
        if huser:

            return render_template("payment.html", posts=posts)
        else:
            flash("please login and check again")

    return render_template("payment.html", posts=posts)




@app.route('/customerdetails')
@login_required
def cust():
    email = current_user.email
    post = customer.query.filter_by(email=email).first()
    emailuser = customer.query.filter_by(email=email).first()
    if emailuser:

        if request.method == "POST":

            eid = request.form.get('eid')
            customer_id = request.form.get('customer_id')
            username = request.form.get('username')
            name = request.form.get('name')
            country = request.form.get('country')
            gender = request.form.get('gender')
            address = request.form.get('address')
            phone = request.form.get('phone')
            email = request.form.get('email')
            huser = customer.query.filter_by(email=email).first()
            if huser:

                return render_template("customerdetails.html", post=post)
            else:
                flash("please login and check again", "danger")
        return render_template("customerdetails.html", post=post)
    else:
        flash("you are not a customer", "danger")
    return render_template("index.html", post=post)


@app.route("/hedit/<string:id>", methods=['POST', 'GET'])
@login_required
def hedit(id):
    posts = hotel_details.query.filter_by(id=id).first()
    if request.method == "POST":
        hcode = request.form.get('hcode')
        hotel_name = request.form.get('hotel_name')
        hotel_type = request.form.get('hotel_type')
        rooms = request.form.get('rooms')

        address = request.form.get('address')
        package = request.form.get('package')
        hcode = hcode.upper()
        db.engine.execute(f"UPDATE `hotel_details` SET `hcode` ='{hcode}',`hotel_name`='{hotel_name}',`hotel_type`='{hotel_type}',`rooms` ='{rooms}',`address`='{address}',`package`='{package}' WHERE `hotel_details`.`id`={id}")
        flash("Hotel Data Updated", "info")
        return redirect("/addhotelinfo")


    return render_template("hedit.html",posts=posts)


@app.route("/hdelete/<string:id>", methods=['POST', 'GET'])
@login_required
def hdelete(id):
    db.engine.execute(f"DELETE FROM `hotel_details` WHERE `hotel_details`.`id`={id}")
    flash(" Hotel Data Deleted", "danger")
    return redirect("/addhotelinfo")


@app.route("/hudelete/<string:id>", methods=['POST', 'GET'])

def hudelete(id):
    db.engine.execute(f"DELETE FROM `hoteluser` WHERE `hoteluser`.`id`={id}")
    flash("Data Deleted", "danger")
    return render_template("addhoteluser.html")




@app.route("/pdelete/<string:id>", methods=['POST', 'GET'])
@login_required
def pdelete(id):
    db.engine.execute(f"DELETE FROM `package` WHERE `package`.`id`={id}")
    flash("Data Deleted", "danger")
    return redirect("/pdetails")



@app.route("/bookingdelete/<string:id>", methods=['POST', 'GET'])
@login_required
def bookingdelete(id):
    db.engine.execute(f"DELETE FROM `booking_package` WHERE `booking_package`.`id`={id}")
    flash("Booking Cancelled...We will refund you within a week", "danger")
    return redirect("/")










@app.route('/customers', methods=['POST', 'GET'])
def customers():
    email = current_user.email
    post = customer.query.filter_by(email=email).first()
    if post:
        flash("you are a registerd customer", "success")
        return render_template("index.html")

    if request.method == "POST":

        customer_id = request.form.get('customer_id')
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


        flash(" Registration Completed Successfully..", "success")
        return render_template("index.html")


    return render_template("customers.html")









@app.route('/pay', methods=['POST', 'GET'])
def pay():
    email = current_user.email
    posts = booking_package.query.filter_by(email=email).first()
    posty = customer.query.filter_by(email=email).first()
    if request.method == "POST":

        upi_id = request.form.get('upi_id')
        upi_pin = request.form.get('upi_pin')

        email = request.form.get('email')
        phone = request.form.get('phone')
        db.engine.execute(f"INSERT INTO `payments` (`upi_id`,`upi_pin`,`email`,`phone`)VALUES ('{upi_id}','{upi_pin}','{email}','{phone}') ")

        flash("you are last step away from confirmation", "success")
        return render_template("confirm.html", posts=posts)

    return render_template("payments.html", posts=posts, posty=posty)


@app.route('/package', methods=['POST', 'GET'])
def pack():

        if request.method == "POST":
            email = request.form.get('email')
            pack_type = request.form.get('pack_type')
            pname = request.form.get('pname')
            start = request.form.get('start')
            destination = request.form.get('destination')
            hcode = request.form.get('hcode')
            hotel_name = request.form.get('hotel_name')
            persons = request.form.get('persons')
            cost = request.form.get('cost')

            emailUser = package.query.filter_by(email=email).first()
            if emailUser:
                flash("email is already taken", "warning")
                return render_template("packages.html")


            db.engine.execute(f"INSERT INTO `package` (`email`,`pack_type`,`pname`,`start`,`destination`,`hcode`,`hotel_name`,`persons`,`cost`)VALUES ('{email}','{pack_type}','{pname}','{start}','{destination}','{hcode}','{hotel_name}','{persons}','{cost}') ")


            flash("data inserted succesfully", "warning")
            return render_template("packages.html")


        return render_template("packages.html")








@app.route("/delete/<string:customer_id>", methods=['POST', 'GET'])
@login_required
def delete(customer_id):
    db.engine.execute(f"DELETE FROM `customer` WHERE `customer`.`customer_id`={customer_id}")
    flash("User Data Deleted Successfully....", "danger")
    flash("You are no longer a Registered Customer....", "warning")
    return redirect('/login')


@app.route("/edit/<string:customer_id>", methods=['POST', 'GET'])
@login_required
def edit(customer_id):
    cust = db.engine.execute("SELECT * FROM `hotel`")
    posts = customer.query.filter_by(customer_id=customer_id).first()
    if request.method == "POST":

        username = request.form.get('username')
        name = request.form.get('name')
        country = request.form.get('country')
        gender = request.form.get('gender')
        address = request.form.get('address')
        phone = request.form.get('phone')
        email = request.form.get('email')
        db.engine.execute(f"UPDATE `customer` SET `username`='{username}',`name`='{name}',`country`='{country}',`gender`='{gender}',`address`='{address}',`phone`='{phone}',`email`='{email}' WHERE `customer`.`customer_id`={customer_id}")
        flash("Details Updated", "info")
        return redirect("/customerdetails")

    return render_template("edit1.html", posts=posts, cust=cust)





@app.route("/pedit/<string:id>", methods=['POST', 'GET'])
@login_required
def pedit(id):
    #pack = db.engine.execute("SELECT * FROM `package`")
    posts = package.query.filter_by(id=id).first()


    if request.method == "POST":
        email = request.form.get('email')
        pack_type = request.form.get('pack_type')
        pname = request.form.get('pname')
        start = request.form.get('start')
        destination = request.form.get('destination')
        hcode = request.form.get('hcode')
        hotel_name = request.form.get('hotel_name')
        persons = request.form.get('persons')
        cost = request.form.get('cost')




        db.engine.execute(f"UPDATE `package` SET `email`='{email}',`pack_type`='{pack_type}',`pname` ='{pname}',`start`='{start}',`destination`='{destination}',`hcode`='{hcode}',`hotel_name`='{hotel_name}',`persons`='{persons}',`cost`='{cost}' WHERE `package`.`id`={id}")
        flash("Package Data Updated", "info")
        return redirect("/pdetails")

    return render_template("pedit.html", posts=posts, pack=pack)





@app.route("/availpack/<string:id>", methods=['POST', 'GET'])
@login_required
def availpack(id):
    email = current_user.email
    code = current_user.srfid
    print(code)
    posts = booking_package.query.filter_by(srfid=code).first()
    posty = customer.query.filter_by(email=email).first()
    post = package.query.filter_by(id=id).first()
    if request.method == "POST":
        srfid = request.form.get('srfid')
        pack_id = request.form.get('pack_id')
        pack_type = request.form.get('pack_type')
        hcode = request.form.get('hcode')
        hotel_name = request.form.get('hotel_name')
        cost = request.form.get('cost')
        email = request.form.get('email')
        username = request.form.get('username')
        phone = request.form.get('phone')
        address = request.form.get('address')

        emailUser = booking_package.query.filter_by(email=email).first()
        if emailUser:
            flash("oops...you already booked a package...Cancel it or try after completing the trip", "warning")
            return render_template("index.html", posts=posts)
        db.engine.execute(f"INSERT INTO `booking_package` (`srfid`,`pack_id`,`pack_type`,`hcode`,`hotel_name`,`cost`,`email`,`username`,`phone`,`address`)VALUES ('{srfid}','{pack_id}','{pack_type}','{hcode}','{hotel_name}','{cost}','{email}','{username}','{phone}','{address}') ")
        flash("package is booked pay the amount for confirmation", "success")
        return render_template("payments.html", posty=posty)


    return render_template("availpack.html", post=post, posty=posty)




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


@app.route("/cdetails", methods=['GET'])
@login_required
def cdetails():

    code = current_user.srfid
    email = current_user.email
    print(code)
    emailuser = booking_package.query.filter_by(email=email).first()

    if emailuser:
        posts = booking_package.query.filter_by(srfid=code).first()
        return render_template("details.html", posts=posts)
    else:
        flash("you do not make any booking", "warning")
        return render_template("index.html")
    return render_template("details.html", posts=posts)





@app.route("/bills", methods=['GET'])
@login_required
def bills():
    code = current_user.srfid
    email = current_user.email
    print(code)
    packuser = payments.query.filter_by(email=email).first()
    emailuser = booking_package.query.filter_by(email=email).first()
    if emailuser:
        posts = booking_package.query.filter_by(srfid=code).first()
        return render_template("bills.html", posts=posts)
    elif packuser:
        posts = payments.query.filter_by(email=email).first()
        return render_template("bills.html", posts=posts)
    else:
        flash("you do not make any booking", "warning")
        return render_template("index.html")
    return render_template("bills.html", posts=posts)






@app.route("/hdetails", methods=['POST', 'GET'])
def hdetails():
    code = current_user.email

    print(code)
    postsdata = hotel_details.query.filter_by(email=code).first()

    return render_template("hdetails.html", postsdata=postsdata)






@app.route("/pdetails", methods=['POST', 'GET'])
def pdetails():
    code = current_user.email

    print(code)
    postsdata = package.query.filter_by(email=code).first()

    return render_template("pdetails.html", postsdata=postsdata)





@app.route("/availablepack")
@login_required
def availablepack():
    query = package.query.all()
    return render_template("availablepack.html", query=query)












@app.route("/packbooking",methods=['POST','GET'])
@login_required
def packbooking():

    query = db.engine.execute(f"SELECT * FROM `package` ")
    if request.method == "POST":
        srfid = request.form.get('srfid')
        pack_id = request.form.get('pack_id')
        pack_type = request.form.get('pack_type')
        hcode = request.form.get('hcode')
        hotel_name = request.form.get('hotel_name')
        cost = request.form.get('cost')
        email = request.form.get('email')
        username = request.form.get('username')
        phone = request.form.get('phone')
        address = request.form.get('address')

        check2 = hotel_details.query.filter_by(hcode=hcode).first()
        if not check2:
            flash("Hotel Code not exist", "warning")

        code = hcode
        dbb = db.engine.execute(f"SELECT * FROM `hotel_details` WHERE `hotel_details`.`hcode`='{code}' ")
        if hcode!= 0:
            res = booking_package(pack_id=pack_id, srfid=srfid, pack_type=pack_type, hcode=hcode, hotel_name=hotel_name, cost=cost, email=email, username=username, phone=phone, address=address)
            db.session.add(res)
            db.session.commit()
            flash("package is booked pay the amount for confirmation", "success")
            return render_template("payments.html")
        else:
            flash("something went", "danger")






    return render_template("booking.html", query=query)








app.run(debug=True)
