#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing frontend dependencies..."
cd "${REPO_ROOT}/Frontend"
npm ci

echo "Creating Schedule virtual environment..."
cd "${REPO_ROOT}/Schedule"
python -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

echo "Creating OCR virtual environment..."
cd "${REPO_ROOT}/OCR"
uv sync


echo "Warming backend Maven dependencies..."
cd "${REPO_ROOT}/Backend"
mvn -q -DskipTests dependency:go-offline || {
	echo "Maven dependency warm-up failed"
}
