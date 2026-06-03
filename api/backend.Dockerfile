FROM python:3.13.5-alpine3.21

WORKDIR /app

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

COPY --chown=appuser:appgroup ./api /app/api
COPY --chown=appuser:appgroup ./elt_adt /app/dbt

RUN apk update && apk upgrade --no-cache && \
    apk add --no-cache curl

RUN pip install --upgrade pip \
    && pip install -r /app/api/requirements.txt --no-cache-dir

RUN chown -R appuser:appgroup /app

HEALTHCHECK --interval=30s --timeout=5s CMD curl -o /dev/null -s -w "%{http_code}\n" localhost:5000/healthcheck || exit 1

USER appuser

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "api.server:app"]