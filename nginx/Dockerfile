# Use official nginx image as the base image
FROM nginx:1.26.1

COPY default.conf /etc/nginx/conf.d/

ENV LISTEN_PORT 80

# Expose port as defined in LISTEN_PORT
EXPOSE ${LISTEN_PORT}
