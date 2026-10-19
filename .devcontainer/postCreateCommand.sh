#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing frontend dependencies..."
cd "${REPO_ROOT}/Frontend"
npm ci --ignore-scripts
./node_modules/.bin/cypress install

echo "Creating Schedule virtual environment..."
cd "${REPO_ROOT}/Schedule"
python -m venv .venv
. .venv/bin/activate
python -m pip install --only-binary :all: --upgrade pip
python -m pip install --require-hashes --only-binary :all: -r requirements.txt

echo "Creating OCR virtual environment..."
cd "${REPO_ROOT}/OCR"
uv sync --locked --no-build


echo "Warming backend Maven dependencies..."
cd "${REPO_ROOT}/Backend"
mvn -q -DskipTests dependency:go-offline || {
	echo "Maven dependency warm-up failed"
}
