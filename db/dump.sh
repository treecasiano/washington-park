#!/usr/bin/env bash

docker exec washington-park sh -c 'exec pg_dump -h 127.0.0.1 -U postgres dev' > ${PWD}/docker-entrypoint-initdb.d/dump.sql

