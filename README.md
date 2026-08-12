# MarioKart Tournament

Full‑stack monorepo for running and managing Mario Kart tournaments. It includes a Spring Boot API, an Ionic React frontend, Python scheduling tools, and Docker Compose for local or host deployment.

## Project Structure

- `Backend/`: Spring Boot (Java)
- `Frontend/`: Ionic React + Vite (TypeScript)
- `Schedule/`: A Flask server for match planning (Python)
- `Deployment/`: `docker-compose.yml` to run the full stack locally or on a host
- `Evalset/`: TODO: Dataset for ML evaluation

## Getting Started

### Option A: All services via Docker Compose

```bash
cd Deployment
docker compose up -d
```

- Uses the `docker-compose.yml` in `Deployment/` to start the API, frontend, DB (if configured), and helper services.
- Check the compose file for exposed ports and environment variables.
- View logs: `docker compose logs -f`.
- Stop: `docker compose down`.

### Option B: Run services individually (local dev)

Prerequisites:

- Java 21 and Maven
- Node.js 24+ and `npm`
- Python 3.13+ and `pip`

Backend (Spring Boot):

```bash
cd Backend
mvn spring-boot:run            # H2 in-memory by default

# Tests
mvn test

# Build jar
mvn package

# Production profile (uses Postgres via env)
SPRING_PROFILES_ACTIVE=prod mvn spring-boot:run
```

Frontend (Ionic React + Vite):

```bash
cd Frontend
npm install
npm run dev          # Vite dev server

# Tests
npm run test.unit    # Vitest unit tests
npm run test.e2e     # Cypress e2e tests

# Lint
npm run lint
```

Schedule tools (Python + Flask):

```bash
cd Schedule
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt

# Run the Flask server
python webserver.py
```

## Environment
See the separate repository documentation for more details.


Create a `.env` in the `Frontend/` for API URLs (see `Frontend/README.md` for details).
```
REACT_APP_BACKEND_PROTOCOL=http
REACT_APP_BACKEND_URL=localhost
REACT_APP_BACKEND_PORT=8080
REACT_APP_BACKEND_PATH=api
REACT_APP_BACKEND_WS_PROTOCOL=ws
REACT_APP_BACKEND_WS_URL=localhost
REACT_APP_BACKEND_WS_PORT=8080
REACT_APP_BACKEND_WS_PATH=api/ws
```
Create a `.env` in `Backend/` for secrets and DB config (see `Backend/README.md` for details).

```
USER_NAME=YOUR_ADMIN_USERNAME
USER_PASSWORD=YOUR_ADMIN_PASSWORD
SECRET_KEY=YOUR_SECRET_KEY
DB_USER=YOUR_DB_USER
DB_PASSWORD=YOUR_DB_PASSWORD
MATCHPLAN_PROTOCOL=http
MATCHPLAN_URL=localhost
MATCHPLAN_PORT=8000
DOMAIN=http://localhost:8100/
VAPID_PUBLIC_KEY=YOUR_VAPID_PUBLIC_KEY_FOR_PWA
VAPID_PRIVATE_KEY=YOUR_VAPID_PRIVATE_KEY_FOR_PWA
```
