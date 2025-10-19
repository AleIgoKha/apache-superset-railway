FROM apache/superset:4.1.4

USER root

RUN apt-get update && apt-get install -y \
    pkg-config \
    libmariadb-dev \
    default-libmysqlclient-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient psycopg2

ENV ADMIN_USERNAME=$ADMIN_USERNAME \
    ADMIN_EMAIL=$ADMIN_EMAIL \
    ADMIN_PASSWORD=$ADMIN_PASSWORD \
    DATABASE=$DATABASE \
    SECRET_KEY=$SECRET_KEY \
    SUPERSET_CONFIG_PATH=/app/superset_config.py

COPY /config/superset_init.sh ./superset_init.sh
RUN chmod +x ./superset_init.sh

COPY /config/superset_config.py /app/

USER superset

ENTRYPOINT ["./superset_init.sh"]