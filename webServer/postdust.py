from flask_restful import Resource, reqparse
from module import db

class Dust(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('region', type=str)
            parser.add_argument('time', type=str)
            args = parser.parse_args()

            dbc = db.Database()

            region = args['region']
            time = args['time']

            sql = 'SELECT region, datetime, PM2, PM10 from ebm_dust where region=%s and datetime=%s'
            row = dbc.executeAll(sql,(region,time))
            if row:
                return row[0]
        except Exception as e:
            return {'error': str(e)}


