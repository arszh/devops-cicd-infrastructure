from fastapi import FastAPI
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
from starlette.responses import Response
import time

app = FastAPI(title="DevOps Portfolio App", version="1.0.0")

REQ_COUNT = Counter("http_requests_total", "Total HTTP requests", ["method", "endpoint"])
REQ_LATENCY = Histogram("http_request_duration_seconds", "Request latency", ["endpoint"])

@app.middleware("http")
async def metrics_middleware(request, call_next):
    start = time.time()
    response = await call_next(request)
    duration = time.time() - start
    endpoint = request.url.path
    REQ_COUNT.labels(method=request.method, endpoint=endpoint).inc()
    REQ_LATENCY.labels(endpoint=endpoint).observe(duration)
    return response

@app.get("/")
async def root():
    return {"message": "Hello from DevOps portfolio!", "ok": True}

@app.get("/healthz")
async def health():
    return {"status": "ok"}

@app.get("/metrics")
async def metrics():
    data = generate_latest()
    return Response(content=data, media_type=CONTENT_TYPE_LATEST)
