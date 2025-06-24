FROM migrate/migrate:v4.18.3

WORKDIR /migrations

COPY migrations /migrations