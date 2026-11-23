# DBAS 5115 - Tech Check 3 (MongoDB & Jupyter Notebooks)

과제 수행을 위한 초기 환경 설정 가이드 및 바로 실행 가능한 Jupyter Notebook 코드입니다.

---

## 1. 초기 환경 설정 (GitHub Codespace)

과제를 시작하기 위해 기본 GitHub Codespace에서 저장소를 열고, 터미널에서 `ipyleaflet` 실행에 필요한 패키지를 먼저 설치합니다.

```bash
sudo apt-get update
sudo apt-get install -y nodejs npm
```

Jupyter Notebook 첫 번째 셀에서 필요한 파이썬 라이브러리를 설치합니다. (VS Code에서 위젯 다운로드 팝업이 뜨면 **OK**를 클릭하세요.)

```python
!pip install pymongo ipyleaflet matplotlib
!pip install --upgrade ipywidgets ipykernel jupyter_client jupyter_core
```

---

## 2. Part A: 하와이 난파선 지도 (Shipwreck Map)

* **대상 DB / 컬렉션**: `sample_geospatial` / `shipwrecks`
* **필터 조건**: `feature_type`이 `"Wrecks - Visible"`이고, 경도(longitude) `-160.3` ~ `-154.8`, 위도(latitude) `18.8` ~ `22.3` 범위 내의 데이터 (총 14개 예상)
* **지도 설정**: 중심 좌표 `(21.1, -157.1)`, 타일 차단 오류("Access Blocked") 방지를 위해 `basemaps.Esri.WorldStreetMap` 적용

```python
from pymongo import MongoClient
from ipyleaflet import Map, Marker, basemaps

# 본인의 MongoDB Atlas 연결 문자열(Connection String)로 변경하세요.
CONNECTION_STRING = "mongodb+srv://<username>:<password>@<cluster-url>/?retryWrites=true&w=majority"
client = MongoClient(CONNECTION_STRING)

# DB 및 컬렉션 선택
db_geo = client["sample_geospatial"]
shipwrecks = db_geo["shipwrecks"]

# 쿼리 조건: Visible 난파선 & 하와이(마우이, 오아후) 좌표 범위
query = {
    "feature_type": "Wrecks - Visible",
    "londec": {"$gte": -160.3, "$lte": -154.8},
    "latdec": {"$gte": 18.8, "$lte": 22.3}
}

results = list(shipwrecks.find(query))
print(f"조회된 난파선 수: {len(results)}개")  # 14개가 출력되어야 정상

# 지도 생성 (zoom 값은 화면에 맞게 7~8 사이로 조절)
hawaii_center = (21.1, -157.1)
m = Map(center=hawaii_center, zoom=8, basemap=basemaps.Esri.WorldStreetMap)

# 마커 추가
for wreck in results:
    lat = wreck.get("latdec")
    lon = wreck.get("londec")
    if lat is not None and lon is not None:
        marker = Marker(location=(lat, lon), draggable=False)
        m.add_layer(marker)

m
```

---

## 3. Part B: 점검 결과 유형 파이 차트 (Inspection Types Chart)

* **대상 DB / 컬렉션**: `sample_training` / `inspections`
* **집계 조건**: `result` 필드로 그룹화하여 개수를 세고, 내림차순 정렬 후 상위 5개 추출
* **시각화**: `matplotlib`을 사용한 파이 차트 생성

```python
import matplotlib.pyplot as plt

# DB 및 컬렉션 선택
db_train = client["sample_training"]
inspections = db_train["inspections"]

# Aggregation Pipeline: result별 카운트 -> 내림차순 정렬 -> 상위 5개
pipeline = [
    {"$group": {"_id": "$result", "count": {"$sum": 1}}},
    {"$sort": {"count": -1}},
    {"$limit": 5}
]

top_results = list(inspections.aggregate(pipeline))

# 데이터 분리
labels = [item["_id"] for item in top_results]
counts = [item["count"] for item in top_results]

# 파이 차트 그리기
plt.figure(figsize=(8, 8))
plt.pie(
    counts,
    labels=labels,
    autopct="%1.1f%%",
    startangle=140
)
plt.title("Top 5 Inspection Results")
plt.axis("equal")  # 원형 유지
plt.show()
```

---

## 4. 제출 및 채점 기준 참고

* 작업이 끝나면 반드시 **GitHub에 Commit & Push**해야 점수를 받을 수 있습니다.

| 최종 점수 | 요구 사항 |
| :--- | :--- |
| **10/10** | 수업 시간 내 완료 및 강사 확인 (출석 필수) |
| **8/10** | 수업 종료 시점까지 진행 내용 커밋 후 12시간 유예 기간 내 완료 (출석 필수) |
| **6/10** | 수업 외 시간 또는 12시간 유예 기간 이후 완료 및 제출 |
| **0/10** | 미제출 또는 코드가 완전히 작동하지 않는 경우 |