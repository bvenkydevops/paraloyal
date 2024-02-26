FROM nginx:latest

WORKDIR /usr/share/nginx/html

COPY assets /usr/share/nginx/html/assets
COPY *.html /usr/share/nginx/html/
COPY Dockerfile /usr/share/nginx/html/
COPY Jenkinsfile /usr/share/nginx/html/
COPY README.md /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
