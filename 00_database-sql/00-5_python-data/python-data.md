# 05. Python에서 SQL 사용하기

## 학습 목표

- Python DB-API의 connection, cursor 흐름을 직접 작성한다.
- `fetchall`, `fetchmany`로 결과를 가져오는 방법을 이해한다.
- Pandas `read_sql_query`와 `to_sql`을 사용해 SQL 결과를 DataFrame으로 읽고, CSV를 테이블로 저장한다.
- Jupyter에서 SQL Magic(`%sql`, `%%sql`)을 사용하는 방법을 이해한다.

## 사전 준비

**방법 A — uv 프로젝트로 시작 (권장)**

```bash
uv init                          # pyproject.toml 생성 (이미 프로젝트면 생략)
uv add pandas ipython-sql        # 의존성 추가 + 설치
```

**방법 B — 프로젝트 없이 가상환경에만 설치**

```bash
uv venv                          # .venv 생성
uv pip install pandas ipython-sql
```

> `uv add`는 `pyproject.toml`이 있어야 하므로 `uv init`이 선행되어야 합니다.
> 빠르게 설치만 하고 싶다면 방법 B를 쓰세요.

```python
import sqlite3
import pandas as pd
```

아래 `menu_data` 딕셔너리를 모든 문제에서 공통으로 사용합니다.

```python
menu_data = {
    "Item":         ["Big Mac", "McChicken", "McDouble", "Filet-O-Fish",
                     "Quarter Pounder", "McNuggets (10pc)", "Egg McMuffin",
                     "French Fries (M)", "Apple Pie", "Iced Coffee",
                     "Chocolate Shake", "Caesar Salad"],
    "Category":     ["Burgers", "Chicken", "Burgers", "Fish",
                     "Burgers", "Chicken", "Breakfast",
                     "Sides", "Desserts", "Beverages",
                     "Beverages", "Salads"],
    "Serving_Size": ["219g", "164g", "174g", "142g",
                     "198g", "162g", "135g",
                     "117g", "77g", "355mL",
                     "473mL", "225g"],
    "Calories":     [540, 400, 390, 390, 520, 440, 300,
                     340, 250, 140, 530, 90],
    "Total_Fat":    [28.0, 16.0, 19.0, 19.0, 26.0, 27.0, 13.0,
                     16.0, 11.0, 6.0, 13.0, 4.0],
    "Sodium":       [950, 700, 750, 580, 1100, 900, 760,
                     310, 170, 95, 290, 190],
    "Protein":      [25.0, 14.0, 23.0, 15.0, 30.0, 23.0, 17.0,
                     4.0, 2.0, 2.0, 12.0, 7.0]
}
```

---

## 연습 문제

### 문제 1 — SQLite 연결 및 테이블 생성

**과제:** Python에서 SQLite 인메모리 데이터베이스에 연결하고,
MENU 테이블을 생성한 뒤 `con`과 `cur`의 타입을 출력하세요.

```python
# 여기에 작성하세요
import sqlite3

con = 
cur = 

# MENU 테이블 생성 (Item, Category, Serving_Size, Calories, Total_Fat, Sodium, Protein)


```

---

### 문제 2 — CSV를 테이블로 저장 (to_sql)

**과제:** `menu_data`로 DataFrame을 만들고,
SQLite 데이터베이스에 MENU 테이블로 저장하세요.

```python
# 여기에 작성하세요
df = 

# to_sql 로 저장

```

---

### 문제 3 — DB-API로 SQL 실행: fetchall

**과제:** cursor를 사용해 MENU 테이블의 Item, Category, Calories를 조회하고,
`fetchall()`로 결과를 가져와 출력하세요.

```python
# 여기에 작성하세요
cur.execute(   )

rows = 

for row in rows:
    print(row)
```

---

### 문제 4 — fetchmany로 일부만 가져오기

**과제:** MENU 테이블에서 Item, Calories, Protein을 조회하고,
`fetchmany(5)`로 처음 5행만 가져오세요.
그 다음, SQL `LIMIT`를 사용하는 더 나은 방법도 함께 작성하세요.

```python
# 방법 1: fetchmany 사용
cur.execute(   )
first_five = 


# 방법 2: SQL LIMIT 사용 (더 나은 방식)

```

---

### 문제 5 — Pandas로 SQL 결과 읽기 (read_sql_query)

**과제:** `pd.read_sql_query`를 사용해 MENU 테이블 전체를 DataFrame으로 읽고,
`head()`와 `shape`를 출력하세요.

```python
# 여기에 작성하세요
df_menu = 

print(       )  # 처음 5행
print(       )  # (행 수, 열 수)
```

---

### 문제 6 — SQL 조건 쿼리를 DataFrame으로

**과제:** Burgers 카테고리 메뉴 중 칼로리가 400 이상인 항목을
DataFrame으로 읽어 출력하세요.

```python
# 여기에 작성하세요
query = """



"""

df_burgers = 
print(df_burgers)
```

---

### 문제 7 — 요약 통계: describe()

**과제:** MENU 테이블 전체를 DataFrame으로 읽은 뒤,
`describe()`로 숫자 컬럼의 요약 통계를 출력하세요.
그리고 아래 질문에 코드로 답하세요.

```python
df = pd.read_sql_query("SELECT * FROM MENU", con)

# 요약 통계 출력


# Q1. Calories 컬럼의 평균은?
avg_cal = 

# Q2. Sodium 컬럼의 최댓값은?
max_sodium = 

# Q3. Protein 컬럼의 최솟값은?
min_protein = 

print(f"평균 칼로리: {avg_cal:.1f}")
print(f"최대 나트륨: {max_sodium}")
print(f"최소 단백질: {min_protein}")
```

---

### 문제 8 — SQL Magic (Jupyter Notebook)

**과제:** Jupyter Notebook에서 SQL Magic을 사용해
카테고리별 평균 칼로리를 조회하세요.

> **참고:** SQL Magic은 파일 기반 DB가 필요합니다. `menu.db`로 저장 후 연결하세요.

```python
# 셀 1: 파일 DB에 데이터 저장
con_file = sqlite3.connect("menu.db")
df.to_sql("MENU", con_file, if_exists="replace", index=False)
con_file.close()

# 셀 2: SQL Magic 로드 및 연결
%load_ext sql
%sql 

# 셀 3: Line magic으로 Beverages 카테고리 조회
%sql 

# 셀 4: Cell magic으로 카테고리별 평균 칼로리 조회
%%sql



```

---

### 문제 9 — 최댓값 행 찾기

**과제:** 나트륨(Sodium) 함량이 가장 높은 메뉴 항목을 찾으세요.
SQL 서브쿼리를 사용하는 방법과 Pandas를 사용하는 방법 모두 작성하세요.

```python
# 방법 1: SQL 서브쿼리
query_sql = """



"""
df_max = pd.read_sql_query(query_sql, con)
print(df_max)

# 방법 2: Pandas
df = pd.read_sql_query("SELECT * FROM MENU", con)
max_row = 
print(max_row[['Item', 'Category', 'Sodium']])
```

---

### 문제 10 — 통합 분석 워크플로우

**과제:** 아래 분석 시나리오를 처음부터 끝까지 Python 코드로 구현하세요.

1. `menu_data`를 SQLite 인메모리 DB에 저장
2. SQL로 카테고리별 평균 칼로리와 최대 단백질 계산
3. 결과를 DataFrame으로 가져오기
4. 평균 칼로리 높은 순으로 정렬하여 출력

```python
import sqlite3
import pandas as pd

# 1. 데이터 저장


# 2. SQL 집계 쿼리 작성
query = """



"""

# 3. DataFrame으로 읽기
df_summary = 

# 4. 출력
print("=== 카테고리별 영양 정보 요약 ===")
print(               )

con.close()
```

---

## 핵심 정리

| 항목 | 코드 | 설명 |
|------|------|------|
| DB 연결 | `con = sqlite3.connect("파일.db")` | `:memory:` = 인메모리 |
| Cursor 생성 | `cur = con.cursor()` | SQL 실행 담당 |
| SQL 실행 | `cur.execute("SQL")` | |
| 전체 결과 | `cur.fetchall()` | 리스트 of 튜플 |
| 일부 결과 | `cur.fetchmany(n)` | n행씩 |
| DataFrame으로 읽기 | `pd.read_sql_query(sql, con)` | |
| DataFrame → 테이블 | `df.to_sql("TABLE", con, if_exists="replace")` | |
| SQL Magic 로드 | `%load_ext sql` | Jupyter 전용 |
| SQL Magic 연결 | `%sql sqlite:///파일.db` | |
| 한 줄 쿼리 | `%sql SELECT ...` | |
| 여러 줄 쿼리 | `%%sql` (셀 첫 줄) | |