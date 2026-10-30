# Notebook Requests — 지시문 → 노트북 자동 생성

사용법:
1. 이 폴더(`notebook-requests/`)에 지시문을 적은 `.md` 파일을 올린다. (파일명 = 만들 노트북 이름, 예: `tc1_parta.md`)
2. 데이터 파일(CSV 등)이 필요하면 `notebooks/` 폴더에 같이 올린다.
3. 수가 30분 간격으로 이 폴더를 확인해, 새 지시문이 있으면 노트북을 생성·실행한 뒤 `notebooks/`에 완성본(`.ipynb`)을 넣어둔다.
4. 완성본은 GitHub에서 바로 열어볼 수 있고, Colab/Codespaces로 가져가 이어서 공부할 수 있다.

예시: `tc1_parta.md` → `notebooks/tc1_parta.ipynb` (실행 결과·차트 포함)
