FROM astral/uv:python3.14-trixie-slim

COPY . /opt/

WORKDIR /opt

RUN uv sync

EXPOSE 5000

CMD uv run src/app.py
