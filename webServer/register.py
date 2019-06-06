from flask_restful import Resource, reqparse
import secrets
from module import db

class RegisterUser(Resource):
    def checkid(self, dbc, uid, cid):
        try:
            sql = 'SELECT * from ebm_user where id=%s'
            row = dbc.executeAll(sql,uid)
            if(row):
                return {'result' : 'failed', 'info': 'already exist id'}
            sql = 'SELECT * from ebm_card where cid=%s'
            row = dbc.executeAll(sql,cid)
            if(row):
                return {'result' : 'failed', 'info': 'already exist card id'}
        except Exception as e:
            return {'error': str(e)}

    def post(self):
        try:
            
            parser = reqparse.RequestParser()
            parser.add_argument('id', type=str)
            parser.add_argument('idpass', type=str)
            parser.add_argument('Tid', type=str)
            parser.add_argument('Tpass', type=str)
            args = parser.parse_args()

            dbc = db.Database()
            check = self.checkid(dbc, args['id'], args['Tid'])
            if(check):
                return check

            uid = args['id']
            uidpass = args['idpass']
            tid = args['Tid']
            tidpass = args['Tpass']

            sql = 'INSERT INTO ebm_user(id,pw) VALUES(%s,%s)'
            dbc.execute(sql,(uid,uidpass))

            sql = 'SELECT * from ebm_user where id=%s'
            row = dbc.executeAll(sql,uid)
            temp = row[0]
            idx = temp['uidx']
            
            sql = 'INSERT INTO ebm_card(uidx,cid,cpw,type) VALUES(%s, %s, %s, %s)'
            dbc.execute(sql,(int(idx), tid,tidpass,'tmoney'))
            
            sql = 'INSERT INTO ebm_token(uidx,accessToken) VALUES(%s, %s)'
            dbc.execute(sql,(int(idx), secrets.token_urlsafe(32)))
            return {'result':'success'}

        except Exception as e:
            return {'error': str(e)}


