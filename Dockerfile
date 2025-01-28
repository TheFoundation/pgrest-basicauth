# derive from any base image you want
FROM alpine:latest

# copy PostgREST over
COPY --from=postgrest/postgrest /bin/postgrest /bin
RUN apk add caddy bash
COPY run.sh /
COPY conf/Caddyfile /etc
ENTRYPOINT /bin/bash /run.sh
EXPOSE 8000