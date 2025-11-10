# --- build stage ---
FROM python:3.12-slim AS builder
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
COPY app/requirements.txt ./requirements.txt
RUN pip wheel --no-cache-dir --wheel-dir /wheels -r requirements.txt

# --- runtime stage ---
FROM python:3.12-slim
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN adduser --disabled-password --gecos "" appuser
COPY --from=builder /wheels /wheels
RUN pip install --no-cache /wheels/*
COPY app/ ./app
USER appuser
EXPOSE 8000
CMD ["gunicorn", "-c", "app/gunicorn_conf.py", "app.main:app"]
