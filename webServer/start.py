from flask import Flask
from flask_restful import Api, Resource, reqparse
from register import RegisterUser
from trylogin import Login
from postweather import Weather
from postdust import Dust

app = Flask(__name__)
api = Api(app)

@app.route('/')
def hello():
    return 'Helasdfasgsfwaefewfq'

api.add_resource(RegisterUser,'/join')
api.add_resource(Login,'/login')
api.add_resource(Weather,'/weather')
api.add_resource(Dust,'/dust')

if __name__=='__main__':
    app.debug = True
    app.run()

