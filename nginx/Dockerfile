# Use official nginx image as the base image
FROM nginx:1.26.1

ENV TZ=America/Los_Angeles

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY default.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/


COPY start.sh /

RUN chmod 777 /start.sh

CMD ["./start.sh"]
