-- ============================================================
-- 05강 연습문제용 데이터
-- 테이블: MENU (맥도날드 스타일 메뉴 영양 정보)
-- 참고: Python 연습에서는 아래 SQL 대신 CSV 파일에서
--       pandas.to_sql() 로 자동 생성하는 것이 권장됩니다.
--       이 파일은 순수 SQL 환경용 참고 스크립트입니다.
-- ============================================================

DROP TABLE IF EXISTS MENU;

CREATE TABLE MENU (
    Item         VARCHAR(100),
    Category     VARCHAR(50),
    Serving_Size VARCHAR(30),
    Calories     INTEGER,
    Total_Fat    DECIMAL(5, 1),
    Sodium       INTEGER,
    Protein      DECIMAL(5, 1)
);

INSERT INTO MENU VALUES
    ('Big Mac',             'Burgers',       '219g',   540, 28.0,  950, 25.0),
    ('McChicken',           'Chicken',       '164g',   400, 16.0,  700, 14.0),
    ('McDouble',            'Burgers',       '174g',   390, 19.0,  750, 23.0),
    ('Filet-O-Fish',        'Fish',          '142g',   390, 19.0,  580, 15.0),
    ('Quarter Pounder',     'Burgers',       '198g',   520, 26.0, 1100, 30.0),
    ('McNuggets (10pc)',     'Chicken',       '162g',   440, 27.0,  900, 23.0),
    ('Egg McMuffin',        'Breakfast',     '135g',   300, 13.0,  760, 17.0),
    ('French Fries (M)',    'Sides',         '117g',   340, 16.0,  310,  4.0),
    ('Apple Pie',           'Desserts',       '77g',   250, 11.0,  170,  2.0),
    ('Iced Coffee',         'Beverages',     '355mL',  140,  6.0,   95,  2.0),
    ('Chocolate Shake',     'Beverages',     '473mL',  530, 13.0,  290, 12.0),
    ('Caesar Salad',        'Salads',        '225g',    90,  4.0,  190,  7.0);