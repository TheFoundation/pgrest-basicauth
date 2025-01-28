# derive from any base image you want
FROM alpine:latest

# copy PostgREST over
COPY --from=postgrest/postgrest /bin/postgrest /bin
RUN apk add caddy bash curl git
RUN git clone https://gitlab.com/the-foundation/bash-logger.git /bash-logger
COPY run.sh /
COPY conf/Caddyfile /etc
ENTRYPOINT /bin/bash /run.sh
EXPOSE 8000