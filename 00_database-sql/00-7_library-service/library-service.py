###############################################################
# 라이브러리 서비스 SQL 분석 
# 1. SQLite 데이터베이스에 연결한다.
# 2. 분석 쿼리를 작성한다.
# 3. SQL 결과를 DataFrame으로 읽는다.
# 4. 카테고리별 대출 횟수를 Pandas로 추가 분석한다.
###############################################################


import sqlite3
import pandas as pd

# 1. SQLite 데이터베이스에 연결한다.
con = sqlite3.connect("library.db")

# 2. 분석 쿼리를 작성한다.
query = """
SELECT
    B.NAME AS borrower_name,
    BK.TITLE AS book_title,
    BK.CATEGORY AS book_category,
    L.LOAN_DATE,
    L.RETURN_DATE
FROM LOAN L
JOIN BORROWER B
  ON L.BORROWER_ID = B.BORROWER_ID
JOIN BOOK BK
  ON L.BOOK_ID = BK.BOOK_ID;
"""

# 3. SQL 결과를 DataFrame으로 읽는다.
loan_df = pd.read_sql_query(query, con)
# 결과를 확인한다.
print(loan_df)

# 4. 카테고리별 대출 횟수를 Pandas로 추가 분석한다.
category_count = loan_df.groupby("book_category").size()
print(category_count)

# 5. 연결을 닫는다.
con.close()
