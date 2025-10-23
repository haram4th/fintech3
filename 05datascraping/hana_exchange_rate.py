import re
import time
import requests
import pandas as pd
from datetime import datetime, timedelta
from bs4 import BeautifulSoup as bs
from io import StringIO
from sqlalchemy import create_engine, text
import pymysql
pymysql.install_as_MySQLdb()
from dbio import to_db, db_connect

def new_col(final_result):
    new_col = []
    for col in final_result.columns:
        if "" in col:
            new_col.append(col[0])
        elif col[0] == col[1] == col[2]:
            new_col.append(col[0].replace(" ", "_"))
        elif col[0] != col[1] != col[2] or col[0] != (col[1] == col[2]):
            new_col.append("_".join(col).replace(" ", "_"))
    return new_col


def main():
    # 오늘부터 하루 전 날짜 생성
    yesterday = datetime.today() - timedelta(days=1)
    date1 = (f"{yesterday.date()}")
    date2 = (f"{yesterday.date()}".replace("-", ""))

    # 환율 데이터 수집
    url = "https://www.kebhana.com/cms/rate/wpfxd651_01i_01.do"
    payload = dict(ajax="true", tmpInqStrDt=date1, pbldDvCd=3, inqStrDt=date2, inqKindCd=1, requestTarget="searchContentDiv")
    r = requests.post(url, data=payload)
    df = pd.read_html(StringIO(r.text))[0]
    df.insert(0, '날짜', date1)
    df.columns = new_col(df)

    # DB에 있는지 확인
    conn = db_connect("exchage_rate")
    try:
        conn.execute(text(f"select * from exchage_rate where `날짜` = {date1}"))
        print(f"{date1} 환율 정보가 이미 DB에 있습니다.")
        conn.close()
    except:
        # DB에 저장
        print(f"{date1} 환율 정보가 DB에 없으므로 수집합니다.")
        to_db("exchage_rate", "exchage_rate", df)
    
    
if __name__ == "__main__":
    main()