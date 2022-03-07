FROM python:alpine

EXPOSE 8000

WORKDIR /usr/src/app

COPY poetry.lock pyproject.toml ./

RUN apk add --no-cache --virtual .pynacl_deps build-base python3-dev libffi-dev && \
    pip install poetry && poetry install

COPY . .

RUN poetry run python src/manage.py makemigrations && poetry run python src/manage.py migrate

CMD poetry run python src/manage.py runserver 0.0.0.0:8000
