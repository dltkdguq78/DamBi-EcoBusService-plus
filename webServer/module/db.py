import pymysql

class Database():
    def __init__(self):
        self.db = pymysql.connect(
                host = 'localhost',
                user = 'server',
                password = 'rltkdcjd',
                db = 'ecoBusMileSystem',
                charset='utf8',
                autocommit = True
                )
        self.cursor = self.db.cursor(pymysql.cursors.DictCursor)

    def execute(self, query, args={}):
        self.cursor.execute(query, args)

    def executeAll(self,query, args={}):
        self.cursor.execute(query, args)
        row = self.cursor.fetchall()
        return row
    
    def executeOne(self, query, args={}):
        self.cursor.execute(query, args)
        row = self.cursor.fetchone()
        return row

    def commit():
        self.db.commit()

if __name__ == "__main__":
    db = Database()
    sql = 'SELECT * from ebm_user where id=%s'
    row = db.executeAll(sql,'a')
    idx = row[0]
    a = idx['uidx']
    print('%d',a)

