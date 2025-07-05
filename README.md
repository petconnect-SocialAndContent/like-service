# Like Service

Microservicio para gestionar "likes" en PetConnect.

## Endpoints

| Método | Ruta                                         | Descripción                        |
|--------|----------------------------------------------|------------------------------------|
| GET    | `/api/v1/likes/:type/:id`                    | Listar likes de un recurso         |
| POST   | `/api/v1/likes`                              | Crear un like                      |
| DELETE | `/api/v1/likes/:type/:id/:user_id`           | Eliminar un like específico        |

## Variables de entorno

- `PORT`
- `MONGODB_URI`
- `JWT_SECRET`

## Docker

```bash
docker build -t like-service .
docker run --env-file .env -p 3020:3020 like-service
