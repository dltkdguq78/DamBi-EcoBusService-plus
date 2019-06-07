import requests
import datetime
import re
from module import db

URL = "https://www.airkorea.or.kr/web/data_pmRelay_search_pop"
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36",
    "Content-Type": "application/x-www-form-urlencoded"
}
district_dict = {
    "서울": "02",
    "경기": "031",
    "인천": "032",
    "강원": "033",
    "충남": "041",
    "대전": "042",
    "충북": "043",
    "부산": "051",
    "울산": "052",
    "대구": "053",
    "경북": "054",
    "경남": "055",
    "전남": "061",
    "광주": "062",
    "전북": "063",
    "제주": "064",
    "세종": "044"
}
district_set = list(district_dict.keys())

script_pattern = re.compile(r'function crtCharts.*}', re.DOTALL)
seriesi_pattern = re.compile(r'var seriesi = "(.*)";')
categories_pattern = re.compile(r'var categories = "(.*)";')


def crawlDustData(district, dateYMD: str):
    params = {
        "strDateDiv": "1",
        "searchDate": dateYMD,
        "district": district,  # "02",
        "itemCode": "10007",
        "searchDate_f": dateYMD[0:4] + dateYMD[5:7],  # "201905"
    }

    response = requests.get(URL, params=params, headers=headers)

    script_text = script_pattern.search(response.text).group()
    categories = categories_pattern.search(script_text).group(1)
    seriesi = seriesi_pattern.search(script_text).group(1)

    categories = categories.split(",")

    dustData = []
    rows = seriesi.split(",")
    for row in rows:
        cols = row.split("#")
        dustData.append(cols)

    return categories, dustData


if __name__ == '__main__':
    dbc = db.Database()
    sql = 'delete from ebm_dust'
    dbc.execute(sql)
    sql = 'ALTER TABLE ebm_dust AUTO_INCREMENT = 1'
    dbc.execute(sql)
    sql = 'INSERT INTO ebm_dust(region,datetime,PM2,PM10) VALUES(%s,%s,%s,%s)'

    for key, value in district_dict.items():
        _, dustData = crawlDustData(value, datetime.datetime.now().strftime("%Y-%m-%d"))
        district_length = len(dustData)
        now = datetime.datetime.now().strftime("%Y-%m-%d")
        oneHoursDustAvgs = [0 for i in range(24)]
        for i in range(district_length):
            for hour in range(len(oneHoursDustAvgs)):
                if dustData[i][hour] != 'null':
                    oneHoursDustAvgs[hour] += int(dustData[i][hour])
    
        for hour in range(len(oneHoursDustAvgs)):
            oneHoursDustAvgs[hour] /= district_length
            oneHoursDustAvgs[hour] = int(round(oneHoursDustAvgs[hour]))
            dbc.execute(sql,(key,now+" "+str(hour+1),oneHoursDustAvgs[hour],oneHoursDustAvgs[hour]))

        print(key+"의 1시~23시 데이터")
        print(oneHoursDustAvgs)
