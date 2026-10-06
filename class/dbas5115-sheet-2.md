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

## Tech Check 2 — (예정)
