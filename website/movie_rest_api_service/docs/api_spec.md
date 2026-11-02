# movie_rest_api_service REST API Specification

## Base URL
`http://127.0.0.1:8080`

## Endpoints

### 1. Health Check
* **Method:** `GET`
* **Path:** `/health`
* **Response (200 OK):**
```json
{
  "status": "UP",
  "service": "REST",
  "timestamp": "2026-10-29T00:00:00Z"
}
```

### 2. List Users
* **Method:** `GET`
* **Path:** `/api/users`
* **Response (200 OK):**
```json
{
  "success": true,
  "data": [
    { "id": "usr_1", "name": "Alice", "email": "alice@example.com" }
  ]
}
```

### 3. Create User
* **Method:** `POST`
* **Path:** `/api/users`
* **Request Body:**
```json
{
  "name": "Bob",
  "email": "bob@example.com"
}
```
* **Response (201 Created):**
```json
{
  "success": true,
  "data": {
    "id": "usr_2",
    "name": "Bob",
    "email": "bob@example.com"
  }
}
```
