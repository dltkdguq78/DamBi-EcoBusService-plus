import requests
import urllib3
from bs4 import BeautifulSoup
from datetime import datetime, timedelta

url = "https://www.t-money.co.kr/ncs/pct/mtmn/ReadTrprInqr.dev#"
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.108 Safari/537.36"}

urllib3.disable_warnings()  # https 에러 disabled.

# 사용 가능 카드 조회
headersCard = {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
    "Connection": "keep-alive",
    "Host": "www.t-money.co.kr",
    "Referer": "https://www.t-money.co.kr/ncs/pct/mtmn/ReadTrprInqr.dev",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.108 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest"
}

# 버스 이용정보 조회
headersBus = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7",
    "Cache-Control": "max-age=0",
    "Content-Type": "application/x-www-form-urlencoded",
    "Host": "www.t-money.co.kr",
    "Origin": "https://www.t-money.co.kr",
    "Referer": "https://www.t-money.co.kr/ncs/pct/mtmn/ReadTrprInqr.dev?logOut=N",
    "Upgrade-Insecure-Requests": "1",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.108 Safari/537.36"
}


def getUserBusUsageInfo(cid, cpw, StDateTime, EdDateTime):
    params = {'indlMbrsId': cid, 'mbrsPwd': cpw}
    response = requests.post(url, headers=headers, data=params, verify=False)

    # 커스텀 쿠키 생성 (로그인 세션 정보)
    cookies = {
        "WMONID": response.cookies['WMONID'],
        "_ga": "GA1.3.1282875865.1556361097",
        "tmyIndlMbrsId": "",
        "hgrnMenuSno": "3",
        "TMONEYID": response.cookies['TMONEYID']}

    response = requests.get("https://www.t-money.co.kr/ncs/pct/cmn/ReadCardNoList.ajax",
                            headers=headersCard,
                            cookies=cookies,
                            params={"codeGroup": "cardno2"})

    soup = BeautifulSoup(response.text, "html.parser")
    cards = [i['value'] for i in soup.findAll('option')]

    results = []
    table_header = ["사용일시", "교통수단", "사용처", "사용금액", "사용후잔액", "승차역", "하차역", "하차일시", "노선(호선)", "차량번호"]
    for card in cards:
        params = {
            "logOut": "N",
            "agrmYn": "Y",
            "srcPrcrNo": card,  # 여기에 카드 정보 파싱해서 바꿔야함, 일단 임의적으로 첫번째 카드만 조회
            "srcChcDiv": "1",
#            "srcSttDt": "2019-04-20",
#            "srcEdDt": "2019-04-27"}
            "srcSttDt": StDateTime,
            "srcEdDt": EdDateTime}

        response = requests.get(url, headers=headersBus, cookies=cookies, params=params)

        soup = BeautifulSoup(response.text, "html.parser")
        bus_table = soup.find("div", attrs={'class': 'tabletype04'})

        data = []
        soup = BeautifulSoup(str(bus_table), "html.parser")

        table = soup.find('table')
        table_body = table.find('tbody')

        rows = table_body.find_all('tr')
        for row in rows:
            cols = row.find_all('td')
            cols = [ele.text.strip() for ele in cols]
            data.append([ele for ele in cols])

        results.append(data)

    return (len(results), cards, table_header, results)

if __name__ == '__main__':
    username = "rhkddh9965@gmail.com"
    password = "djaakwl12#"

    current = datetime.now()
    print(getUserBusUsageInfo(username, password,
                              StDateTime=(current - timedelta(days=7)).strftime("%Y-%m-%d"), EdDateTime=current.strftime("%Y-%m-%d"))) # 지금부터 일주일 정도 데이터
