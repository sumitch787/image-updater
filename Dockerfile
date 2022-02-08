FROM alpine:3.15
RUN apk update && \
    apk add git yq && \
    rm -rf /var/cache/*
COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh && \
    mkdir /app
WORKDIR /app
CMD ["/docker_entrypoint.sh"]
