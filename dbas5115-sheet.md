# 📊 DBAS 5115 Data & PostgreSQL Practice 1~9_code Sheet

## Practice 1 — Markdown & Git 제출 (Ex1)
노트북 설명 셀과 README 작성용 문법 + 과제 제출 명령어입니다.
```markdown
# 큰 제목
## 중간 제목
### 작은 제목

**굵게** / *기울임* / `인라인 코드`

- 순서 없는 목록
- 항목 2

1. 순서 있는 목록
2. 항목 2

[링크 텍스트](https://주소.com)
![이미지 설명](이미지파일.png)
```
```bash
# VS Code 터미널(bash)에 순서대로 입력
git add .                              # 1. 변경된 파일 추가
git commit -m "작업 내용 설명 적기"      # 2. 이름표 붙이기
git push                               # 3. 깃허브로 전송
```

## Practice 2 — DataFrame 기초 & 시각화 (Ex2)
```python
import pandas as pd

# 2차원 배열로 DataFrame 만들기
data = [['홍길동', 25, '서울'],
        ['김철수', 30, '부산']]
df = pd.DataFrame(data, columns=['이름', '나이', '도시'])

# 데이터 탐색 4종 세트
display(df.head())                    # 위에서 5줄 미리보기
df.info()                             # 형식, 결측치, 개수 확인
display(df.describe(include='all'))   # 기초 통계
df['컬럼명'].value_counts()            # 항목별 개수 세기
```

💡 숫자 깨짐 방지 (과학적 표기법 1.23e+09 → 콤마 표시)
```python
pd.options.display.float_format = '{:,.2f}'.format
```

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(10, 6))  # 차트 크기

# 막대그래프 (Top 5 GDP 예시)
plt.bar(top_5['Country'], top_5['2025'], color='forestgreen')

plt.title('Top 5 Countries for GDP in 2025')
plt.xlabel('Country')
plt.ylabel('GDP ($)')

plt.xticks(rotation=45)  # X축 글자 대각선 회전 (겹침 방지)
plt.tight_layout()       # 여백 자동 최적화
plt.show()               # 출력 (필수!)
```

## Practice 3 — Pandas 조작 (Ex3)
[Pandas 10분 튜토리얼](https://pandas.pydata.org/docs/user_guide/10min.html) 실습용 핵심 코드입니다.
```python
# 결측치 처리
df.isnull().sum()   # 컬럼별 빈칸 개수
df_clean = df.dropna()    # 빈칸 있는 행 삭제
df_filled = df.fillna(0)  # 빈칸을 0으로 채우기

# 그룹별 집계
df.groupby('컬럼명')['숫자컬럼'].mean()
df.groupby('컬럼명')['숫자컬럼'].agg(['mean', 'max', 'min', 'count'])

# 정렬 및 추출 (GDP 상위 5개국 예시)
df_sorted = df_csv.sort_values(by='2025', ascending=False)
top_5 = df_sorted.head(5)

# 기초 통계
lengths = df_api['length']
print(f"최대: {lengths.max()}, 최소: {lengths.min()}, 평균: {lengths.mean():.1f}")
```

## Practice 4 — 플랫 파일 읽기 (Ex4)
```python
import pandas as pd

# CSV 기본
df = pd.read_csv('파일명.csv')

# UnicodeDecodeError 발생 시
df = pd.read_csv('파일명.csv', encoding='cp949')   # 한글 윈도우용
df = pd.read_csv('파일명.csv', encoding='latin1')   # 영문/기타

# 고정폭 플랫 파일 (컬럼 너비가 고정된 텍스트)
df = pd.read_fwf('파일명.txt')
```

## Practice 5 — 바이너리 & 이미지 읽기 (Ex5)
```python
import pandas as pd
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt

# 바이너리 데이터 파일
df = pd.read_csv('IBM.data', header=None)

# 이미지 → NumPy 배열
img = Image.open('이미지파일.png')
img_array = np.array(img)
print(img_array.shape)  # (높이, 너비, 색상채널)

plt.imshow(img_array)
plt.axis('off')
plt.show()
```

## Practice 6 — XML & JSON 파일 읽기 (Ex6)
```python
import pandas as pd

df_xml = pd.read_xml('파일명.xml')
df_json = pd.read_json('파일명.json')
```

## Practice 7 — API 데이터 (Ex7)
```python
import pandas as pd
import requests

# 기본: JSON 응답 → DataFrame
api_url = "https://api.domain.com/data?per_page=200"
response = requests.get(api_url)
df_api = pd.DataFrame(response.json())

# 페이징 처리 (데이터가 여러 페이지에 나뉜 경우)
all_data = []
page = 1
while True:
    url = f"https://api.domain.com/data?page={page}&per_page=200"
    data = requests.get(url).json()
    if not data:
        break
    all_data.extend(data)
    page += 1
df_api = pd.DataFrame(all_data)
```

## Practice 8 — 웹 스크래핑 (Ex8)

A. 표 긁어오기 (간단)
```python
import pandas as pd

tables = pd.read_html("https://www.worldometers.info/...")
df_web = tables[0]  # 첫 번째 표가 보통 메인 데이터
```

B. BeautifulSoup (정적 페이지)
```python
import requests
from bs4 import BeautifulSoup
import pandas as pd

soup = BeautifulSoup(requests.get("https://웹사이트주소.com").text, 'html.parser')
rows = soup.find_all('tr')
data = [[cell.text.strip() for cell in row.find_all(['th', 'td'])]
        for row in rows]
df_web = pd.DataFrame(data[1:], columns=data[0])
```

C. Selenium (동적 페이지)
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import pandas as pd
import time

driver = webdriver.Chrome()
driver.get("https://웹사이트주소.com")
time.sleep(3)  # 자바스크립트 로딩 대기

rows = driver.find_elements(By.TAG_NAME, "tr")
data = [[cell.text for cell in row.find_elements(By.TAG_NAME, "td")]
        for row in rows if row.find_elements(By.TAG_NAME, "td")]
df_web = pd.DataFrame(data)
driver.quit()  # 브라우저 종료 (필수!)
```

## Practice 9 — PostgreSQL (Ex9·10)

psql 터미널
```bash
psql -d postgres -h localhost -U postgres  # DB 접속
\dt   # 테이블 목록
\q    # 종료
```

SQL 조회
```sql
-- (예시 테이블 countries: country, gdp, continent)
SELECT * FROM countries;
SELECT country, gdp FROM countries;
SELECT * FROM countries WHERE gdp > 1000000000000;
SELECT * FROM countries ORDER BY gdp DESC LIMIT 5;
SELECT continent, COUNT(*), AVG(gdp) FROM countries GROUP BY continent;
SELECT * FROM countries
JOIN population ON countries.country = population.country;
```

SQL 테이블 만들기·고치기·지우기
```sql
DROP TABLE Persons;  -- 먼저 삭제 (반복 실행용)

CREATE TABLE Persons (
    ID        SERIAL    PRIMARY KEY NOT NULL,
    LastName  CHAR(32)  NOT NULL,
    FirstName CHAR(32)
);

INSERT INTO Persons (LastName, FirstName)
VALUES ('Jones', 'Tom');

ALTER TABLE Persons ADD COLUMN Age INT;  -- 컬럼 추가

SELECT * FROM Persons;
```

pandas ↔ PostgreSQL 연동
```python
import pandas as pd
from sqlalchemy import create_engine

# Codespaces 기본값: 사용자 postgres / 비밀번호 postgres
engine = create_engine('postgresql://postgres:postgres@localhost:5432/postgres')

df = pd.read_sql("SELECT * FROM 테이블명", engine)  # DB → DataFrame
df.to_sql('테이블명', engine, if_exists='replace', index=False)  # DataFrame → DB
```
