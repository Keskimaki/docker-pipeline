FROM python

EXPOSE 8000

WORKDIR /usr/src/app

RUN pip install poetry

COPY poetry.lock pyproject.toml ./

RUN poetry install

COPY . .

RUN poetry run python src/manage.py makemigrations && poetry run python src/manage.py migrate
