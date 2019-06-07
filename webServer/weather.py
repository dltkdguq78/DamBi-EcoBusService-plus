import datetime
import requests
from bs4 import BeautifulSoup
from module import db


def get_html(url):
   _html = ""
   resp = requests.get(url)
   if resp.status_code == 200:
      _html = resp.text
   return _html

def getWeather(date):
    if date == None:
        date = datetime.datetime.now().strftime("%Y.%m.%d.%H") + ":00"
    URL = "http://www.weather.go.kr/weather/observation/currentweather.jsp?auto_man=m9&tm=%s" % (date)
    #print(URL)

    text = get_html(URL)
    soup = BeautifulSoup(text, "html.parser")

    data = []
    table = soup.find('table')
    table_body = table.find('tbody')

    rows = table_body.find_all('tr')
    for row in rows:
        cols = row.find_all('td')
        cols = [ele.text.strip() for ele in cols]
        data.append(cols)

    # 테이블 헤더 순서 정보를 알기 위한 임시 정보
    table_header = ['지점']
    table_header += table.find('tr' ,attrs={'id':'table_header2'}).get_text().split() # 데이터 순서를 알기 위한 임의로 테이블 헤더 정보 가져옴.
    table_header[:] = ["풍속m/s" if ele == '풍속writeWindSpeedUnit();' else ele for ele in table_header]

    #일부 데이터를 평준화
    iWeather = table_header.index('현재일기')
    iWindSpeed = table_header.index('풍속m/s')
    iRain = table_header.index('일강수mm')

    for row in data:
        if row[iWeather] == '':
            row[iWeather] = '맑음'
        if row[iWindSpeed].startswith('writeWindSpeed'):
            row[iWindSpeed] = row[iWindSpeed].split('\'')[1]
        if row[iRain] == '':
            row[iRain] = '0.0'
    return (table_header, data)


if __name__ == '__main__':
    # 기상정보 테이블 출력
    date = datetime.datetime.now().strftime("%Y.%m.%d.%H") + ":00"
    weather_header, weatherData = getWeather(date)
    dbc = db.Database()
    print(weather_header)
    sql = 'delete from ebm_weather'
    dbc.execute(sql)
    sql = 'INSERT INTO ebm_weather(region,weather,temperture,windvelo) VALUES(%s,%s,%s,%s)'
    for i in range(0,len(weatherData)):
        temp = []
        for j in range(0,len(weatherData[i])):
        
            if j==0:
                temp.append(weatherData[i][j])
            if j==1:
                temp.append(weatherData[i][j])
            if j==5:
                temp.append(weatherData[i][j])
            if j==11:
                temp.append(weatherData[i][j])
        dbc.execute(sql,(temp[0],temp[1],temp[2],temp[3]))
        print(temp)
    now = datetime.datetime.now()
    dbc.execute(sql,(now.year,now.month,now.day,now))
            
