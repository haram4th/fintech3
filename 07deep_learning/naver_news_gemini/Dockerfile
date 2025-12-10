# 1) Python 베이스 이미지 선택
FROM python:3.10-slim

# 2) 컨테이너 안 작업 디렉토리 설정
WORKDIR /app

# 3) 시스템 필수 패키지 (선택 사항: 빌드 툴 등)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4) requirements 먼저 복사 후 설치 (캐시 활용)
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 5) 애플리케이션 코드 복사
COPY app.py /app/app.py

# 6) Gradio가 사용할 포트 오픈
EXPOSE 7860

# 7) 컨테이너 실행 시 명령
CMD ["python", "app.py"]
