# movie_rest_api_service

Mantra REST API backend application: movie_rest_api_service

A modular REST API backend application built with the **Mantra Programming Language**.

## Architecture (MVC API)
```text
movie_rest_api_service/
├── mantra.toml
├── README.md
├── .gitignore
├── src/
│   ├── main.mantra       # Server entry point & route binding
│   ├── config/           # Environment configuration
│   ├── routes/           # Endpoint definitions
│   ├── controllers/      # Request handlers & response dispatch
│   ├── models/           # Domain entities
│   ├── services/         # Core business logic
│   ├── repositories/     # Data access abstraction
│   ├── middleware/       # Auth, logging, CORS middleware
│   ├── validators/       # Request payload validators
│   └── utils/            # Shared utilities & response formatters
├── tests/
│   ├── unit/             # Service & validator unit tests
│   └── integration/      # Endpoint integration tests
└── docs/
    └── api_spec.md       # API endpoint specification
```

## Endpoints
- `GET  /health`    — Health check status
- `GET  /api/users` — Retrieve all users
- `POST /api/users` — Create a new user

## Getting Started

### Running the Server
```bash
mantra run
```

### Running Tests
```bash
mantra test
```
