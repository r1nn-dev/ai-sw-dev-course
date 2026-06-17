###############################################################
# 실습 문제 1
# 1. SQLite 데이터베이스에 연결한다.
# 2. CSV를 테이블로 저장한다.
# 3. SQL로 처음 10행을 조회한다.
# 4. 특정 컬럼의 평균을 계산한다. 
# 5. Pandas로 결과를 DataFrame으로 읽는다.
###############################################################


import sqlite3
import pandas as pd

# CSV 파일을 읽는다.
df = pd.read_csv("menu.csv")

# SQLite 데이터베이스에 연결한다.
con = sqlite3.connect("menu.db")

# CSV 데이터를 MENU 테이블로 저장한다.
df.to_sql("MENU", con, if_exists="replace", index=False)

# 처음 10행을 SQL로 조회한다.
top_10 = pd.read_sql_query(
    "SELECT * FROM MENU LIMIT 10",
    con
)
print(top_10)

# 특정 컬럼의 평균을 SQL로 계산한다.
avg_calories = pd.read_sql_query(
    "SELECT AVG(Calories) AS avg_calories FROM MENU",
    con
)
print(avg_calories)

# SQL 결과를 DataFrame으로 가져와 후처리한다.
result_df = pd.read_sql_query(
    "SELECT * FROM MENU WHERE Calories >= 500",
    con
)
print(result_df.head())

con.close()