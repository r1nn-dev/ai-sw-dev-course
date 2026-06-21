###############################################################
# 실습 문제 1
# 1. SQLite 데이터베이스에 연결한다.
# 2. CSV를 테이블로 저장한다.
# 3. SQL로 처음 5행을 조회한다.
# 4. Pandas DataFrame으로 읽는다.
# 5. `describe()`로 요약 통계를 확인한다.
# 6. 특정 컬럼의 최댓값 행을 찾는다.
###############################################################


import sqlite3
import pandas as pd

# 0. CSV 파일을 읽는다.
df = pd.read_csv("menu.csv")

# 1. SQLite 데이터베이스에 연결한다.
con = sqlite3.connect("menu.db")

# 2. DataFrame을 SQL 테이블로 저장한다.
df.to_sql("MENU", con, if_exists="replace", index=False)

# 3. SQL로 처음 5행만 조회한다.
preview = pd.read_sql_query(
    "SELECT * FROM MENU LIMIT 5",
    con
)
print(preview)

# 4. 전체 데이터를 DataFrame으로 읽는다.
menu_df = pd.read_sql_query(
    "SELECT * FROM MENU",
    con
)

# 5. 요약 통계를 확인한다.
print(menu_df.describe())

# 6. Sodium 컬럼이 가장 큰 행을 찾는다.
max_sodium_row = menu_df.loc[menu_df["Sodium"].idxmax()]
print(max_sodium_row)

# 7. 연결을 닫는다.
con.close()
