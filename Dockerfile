FROM alpine:3.15
RUN apk update && \
    apk add git yq && \
    rm -rf /var/cache/*
RUN adduser -D -s /bin/sh alpine
COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh
USER alpine
RUN mkdir -p /home/alpine/app
ENV WORK_DIR="/home/alpine/app"
WORKDIR /home/alpine/app
CMD ["/docker_entrypoint.sh"]
