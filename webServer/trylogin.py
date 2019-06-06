from flask_restful import Resource, reqparse
from module import db

class Login(Resource):
    def post(self):
        try:
            
            parser = reqparse.RequestParser()
            parser.add_argument('id', type=str)
            parser.add_argument('idpass', type=str)
            args = parser.parse_args()

            dbc = db.Database()

            uid = args['id']
            uidpass = args['idpass']

            sql = 'SELECT * from ebm_user where id=%s and pw=%s'
            row = dbc.executeAll(sql,(uid,uidpass))
            
            if row:
                temp = row[0]
                idx = temp['uidx']
                sql = 'SELECT * from ebm_token where uidx = {}'.format(idx)
                row = dbc.executeAll(sql)
                if row:
                    return {'result':'success', 'accesstoken':(row[0])['accessToken']}
                else:
                    return {'result':'fail', 'info':'accesstoken is not exist'}

            else:
                return{'result':'fail','info':'id or passward information is wrong.'}
                

        except Exception as e:
            return {'error': str(e)}


