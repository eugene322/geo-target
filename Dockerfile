FROM python:3.9.1-slim

ENV PYTHONUNBUFFERED=1 COLUMNS=200 \
    TZ=Asia/Almaty

ADD src/requirements.txt \
    ./src/dev_requirements.txt \
    /src/

RUN apt update \
# Set timezone
    && ln -fs /usr/share/zoneinfo/Asia/Almaty /etc/localtime \
    && echo "Asia/Almaty" > /etc/timezone \
# Upgrade pip
    && pip install --upgrade pip setuptools wheel \
# Add project dependencies
    && pip install \
    --no-cache-dir -Ur /src/requirements.txt \
    --no-cache-dir -Ur /src/dev_requirements.txt \
# Remove build dependencies
    && apt clean

COPY src /src

WORKDIR /src
CMD ["./entrypoint.sh"]
