FROM python:3.11-slim-bullseye
ENV PYTHONUNBUFFERED=1

WORKDIR /src

RUN pip install poetry

COPY pyproject.toml* poetry.lock* ./

RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]
