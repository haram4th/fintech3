# EasyFin_mvp/frontend/Dockerfile
FROM nginx:alpine

# 기본 nginx html 폴더 비우고 우리 파일 복사
RUN rm -rf /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css

# (필요하면) 캐시 방지용 헤더 등 nginx.conf 커스터마이징도 가능
# 지금은 기본 설정 그대로 사용
