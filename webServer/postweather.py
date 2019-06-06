from flask_restful import Resource, reqparse
from module import db

class Weather(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('region', type=str)
            args = parser.parse_args()

            dbc = db.Database()

            region = args['region']

            sql = 'SELECT * from ebm_weather where region=%s'
            row = dbc.executeAll(sql,region)
            if row:
                return row[0]
        except Exception as e:
            return {'error': str(e)}

