# 📊 DBAS 5115 Data & PostgreSQL Practice 10~_code Sheet

Exercise 10부터 Tech Check 2까지 정리하는 시트입니다.
(1~9는 `dbas5115-sheet.md` 참고)

---

## Exercise 10 — DDL: CREATE, ALTER, & DROP

테이블 **구조**를 만드는 과제. 데이터(INSERT)는 없음 — 그릇만 만드는 날.

### ERD 5개 테이블

| 테이블 | 컬럼 (타입) |
|---|---|
| INSTRUCTOR | Employee_ID INTEGER (PK), FirstName VARCHAR(20), LastName VARCHAR(20), Office VARCHAR(10), Phone VARCHAR(20) |
| STUDENT | Student_ID INTEGER (PK), FirstName VARCHAR(20), LastName VARCHAR(20), Dorm VARCHAR(10), Phone VARCHAR(20) |
| COURSE | Course_Number CHAR(9) (PK), Title VARCHAR(15), Hours INTEGER |
| SECTION | Call_No CHAR(5) (PK), Employee_ID INTEGER (FK1), Course_Number CHAR(9) (FK2) |
| ENROLLMENT | Call_No CHAR(5) (PK,FK1), Student_ID INTEGER (PK,FK2), FinalGrade DOUBLE |

### 데이터타입 번역 (ERD → PostgreSQL)

| ERD 표기 | PostgreSQL | 비고 |
|---|---|---|
| INTEGER | INTEGER (INT도 됨) | 그대로 |
| VARCHAR(n) | VARCHAR(n) | 그대로 |
| CHAR(n) | CHAR(n) | 그대로 |
| DOUBLE | **DOUBLE PRECISION** | `DOUBLE` 단독은 에러! `(5,2)` 같은 길이 지정 불가 |

### DDL 스크립트 전체

```sql
-- ===== DROP: 맨 위에, 여러 번 돌려도 에러 없게 =====
DROP TABLE IF EXISTS ENROLLMENT CASCADE;
DROP TABLE IF EXISTS SECTION CASCADE;
DROP TABLE IF EXISTS STUDENT CASCADE;
DROP TABLE IF EXISTS INSTRUCTOR CASCADE;
DROP TABLE IF EXISTS COURSE CASCADE;

-- ===== CREATE: 5개 테이블 =====
CREATE TABLE INSTRUCTOR (
    Employee_ID INTEGER,
    FirstName   VARCHAR(20),
    LastName    VARCHAR(20),
    Office      VARCHAR(10),
    Phone       VARCHAR(20)
);

CREATE TABLE STUDENT (
    Student_ID INTEGER,
    FirstName  VARCHAR(20),
    LastName   VARCHAR(20),
    Dorm       VARCHAR(10),
    Phone      VARCHAR(20)
);

CREATE TABLE COURSE (
    Course_Number CHAR(9),
    Title         VARCHAR(15),
    Hours         INTEGER
);

CREATE TABLE SECTION (
    Call_No       CHAR(5),
    Employee_ID   INTEGER,
    Course_Number CHAR(9)
);

CREATE TABLE ENROLLMENT (
    Call_No     CHAR(5),
    Student_ID  INTEGER,
    FinalGrade  DOUBLE PRECISION   -- ERD의 DOUBLE 번역
);

-- ===== ALTER: 테이블 만든 뒤 컬럼 추가 =====
ALTER TABLE STUDENT
    ADD COLUMN Email VARCHAR(100);
```

### 실행 & 확인

```bash
# 스크립트 실행 (비번: postgres)
psql -d postgres -h localhost -U postgres -f 파일명.sql

# 테이블 5개 확인
psql -d postgres -h localhost -U postgres -c "\dt"

# 특정 테이블 구조 확인
psql -d postgres -h localhost -U postgres -c "\d enrollment"
```

### 제출 체크리스트

- [ ] `.sql` 파일이 레포 안에 저장됨
- [ ] 스크립트 에러 없이 실행됨 (CREATE TABLE × 5)
- [ ] `successful_table_creation.bmp` 스크린샷을 레포에 저장 (Win+Shift+S → 그림판 → BMP로 저장)
- [ ] commit + push

### ⚠️ 실전 트러블슈팅 (10/6 직접 겪음)

1. **password authentication failed** → 비번 오타. `postgres` 정확히 입력. 서버는 살아있는데 비번만 틀린 경우.
2. **`syntax error at or near "PRECION"`** → 오타! `PRECISION` (PRECI**S**ION, S 있음). 그리고 `DOUBLE PRECISION` 뒤에 `(5,2)` 붙이면 안 됨.
3. **테이블이 비어 있는 게 정상** → DDL 과제는 구조만 만듦. 데이터 없음이 맞음.
4. **출력에 DROP이 안 보여요** → 터미널 스크롤 때문. 전체 순서는 DROP×5 → CREATE×5 → ALTER×1. 위로 스크롤하면 있음.
5. **SQLTools 연결 안 됨** → "Search VS Code Marketplace"에서 `SQLTools PostgreSQL/Cockroach Driver` 설치. 그래도 안 되면 터미널 `psql`이 확실.

---

## Exercise 11 — (예정)

---

## Tech Check 2 — 2026-11-02 (월) 13:30, 수업 중 대면 실시

⚠️ **원격 응시 불가** — 교수가 Topics 페이지에 명시. 당일 수업에 직접 가야 함.

### 출제 범위 (교수 Topics 페이지 기준)

1. **SQL DML** — 처음 보는 관계형 DB(sakila 아님)와 ERD가 주어지고:
   - INSERT / UPDATE / DELETE 문 작성
   - SELECT 쿼리로 원하는 결과 집합 뽑기 — GROUP BY·집계함수·ORDER BY·LIMIT, JOIN이 섞일 수 있음
2. **Jupyter Notebook**:
   - 마크다운과 구조를 갖춘 노트북 작성
   - 평소 라이브러리 + SQL 연동 라이브러리 import, 필요한 pip 패키지 설치
   - SQL 쿼리 결과를 Pandas DataFrame으로 로드
   - Pandas로 기본 계산·조작 → Matplotlib 차트 작성

### DML 패턴 (테이블·컬럼명은 당일 주어지는 ERD 기준)

```sql
-- ===== INSERT: 한 행 =====
INSERT INTO 테이블 (컬럼1, 컬럼2, 컬럼3)
VALUES (값1, '문자열은 작은따옴표', '2026-11-02');

-- ===== INSERT: 여러 행 한 번에 =====
INSERT INTO 테이블 (컬럼1, 컬럼2)
VALUES (값1, 값2),
       (값3, 값4);

-- 방금 넣은 행 확인
SELECT * FROM 테이블 ORDER BY 기본키 DESC LIMIT 1;
```
💡 날짜·문자열은 작은따옴표, NULL은 따옴표 없이 그냥 `NULL`. FK가 있는 자식 테이블은 **부모 테이블 행이 먼저** 있어야 INSERT 됨.

```sql
-- ===== UPDATE =====
UPDATE 테이블
SET 컬럼 = 새값
WHERE 조건;
```
⚠️ **WHERE를 빠뜨리면 전체 행이 다 바뀐다.** 실행 전에 같은 WHERE로 `SELECT` 먼저 돌려서 대상 행만 맞는지 확인.

```sql
-- ===== DELETE =====
DELETE FROM 테이블
WHERE 조건;
```
⚠️ 다른 테이블이 FK로 참조하는 행은 바로 못 지움 — 참조하는 자식 행(연결 테이블 등)부터 지우고 부모를 지울 것.

```sql
-- ===== SELECT 심화: 그룹핑·집계·정렬·제한 =====
SELECT 그룹컬럼, COUNT(*) AS 개수, SUM(금액컬럼) AS 합계
FROM 테이블
WHERE 조건
GROUP BY 그룹컬럼
HAVING COUNT(*) > 1
ORDER BY 합계 DESC
LIMIT 5;
```

```sql
-- ===== JOIN: 두 테이블 연결 =====
SELECT a.컬럼, b.컬럼
FROM 테이블A AS a
INNER JOIN 테이블B AS b ON a.키컬럼 = b.키컬럼
WHERE 조건;
```
💡 `LEFT JOIN` = 왼쪽 테이블은 전부 나오고, 매칭이 없으면 오른쪽은 NULL.

### Jupyter 패턴 (수업 방식 그대로)

```python
# 필요한 패키지 설치 (노트북 셀에서 한 번)
%pip install sqlalchemy psycopg2-binary
```

```python
import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine

# Codespaces 기본값: 사용자 postgres / 비밀번호 postgres
engine = create_engine('postgresql://postgres:postgres@localhost:5432/postgres')

df = pd.read_sql("""
    SELECT 컬럼, COUNT(*) AS 개수
    FROM 테이블
    GROUP BY 컬럼
""", engine)

display(df.head())
```

```python
# Pandas 기본 계산·조작
df.describe()                                  # 기초 통계
df['새컬럼'] = df['기존컬럼'] * 2               # 파생 컬럼
df_sorted = df.sort_values('개수', ascending=False)

# Matplotlib 차트
plt.figure(figsize=(10, 6))
plt.bar(df_sorted['컬럼'], df_sorted['개수'])
plt.title('제목')
plt.xlabel('x축 이름')
plt.ylabel('y축 이름')
plt.show()
```

### 당일 체크리스트

- [ ] 노트북 지참 (대면만 가능 — 원격 응시 옵션 없음)
- [ ] PostgreSQL 서버 실행 + 비밀번호 `postgres` 확인
- [ ] ERD를 받으면 테이블·PK·FK부터 표시 — INSERT 순서는 부모 → 자식
- [ ] UPDATE/DELETE 전에는 같은 WHERE로 SELECT 해서 대상 행 확인
- [ ] 노트북은 제출 전 Run All로 처음부터 끝까지 에러 없이 도는지 확인
