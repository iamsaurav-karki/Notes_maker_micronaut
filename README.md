# Simple Notes Maker

A basic three-tier web app where users can create, view, and delete notes.

## Tech Stack
- **Frontend:** React + Axios
- **Backend:** Micronaut (Java)
- **Database:** ScyllaDB
- **DevOps:** Docker Compose

## Project Structure
```
notes-maker/
├── backend/
│   └── src/
│   └── build.gradle
│   └── Dockerfile
├── frontend/
│   └── src/
│   └── package.json
│   └── Dockerfile
├── docker-compose.yml
└── README.md
```

## Running the Project

1. **Clone the repository**
2. **Build and start all services:**
   ```sh
   docker-compose up --build
   ```
3. **Access the app:**
   - Frontend: [http://localhost:3000](http://localhost:3000)
   - Backend API: [http://localhost:8080/api/notes](http://localhost:8080/api/notes)
   - ScyllaDB: localhost:9042

## Features
- Create, view, and delete notes
- Modern three-tier architecture
- Fully containerized with Docker Compose

---

**Note:** The first startup may take a while as ScyllaDB initializes. The backend will auto-create the required table if it doesn't exist. 