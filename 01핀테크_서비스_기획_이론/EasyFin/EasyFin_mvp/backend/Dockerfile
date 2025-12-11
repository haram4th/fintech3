# EasyFin_mvp/backend/Dockerfile
FROM python:3.10-slim

# 필수 패키지 설치 (옵션: 빌드 속도/이미지 크기 위해 최소한만)
RUN pip install --no-cache-dir --upgrade pip

# 작업 디렉터리
WORKDIR /app

# 의존성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 앱 소스 복사
COPY main.py .

# UVicorn으로 FastAPI 실행
# main.py 안에 app = FastAPI(...) 가 정의되어 있음
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
