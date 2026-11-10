# Resultados de las pruebas · 2026-10-29 15:48

Cobertura: 100 % (21 de 21 endpoints) · Pasaron: 112 de 116

```bash
bash test.sh
```

| Prueba | Resultado | Esperado | Llegó |
|---|---|---|---|
| GET /courses · token alterado | FALLA | 401 | 302 |
| GET /students/{studentPublicId}/enrollments · token alterado | FALLA | 401 | 302 |
| GET /professors · token alterado | FALLA | 401 | 302 |
| GET /students · token alterado | FALLA | 401 | 302 |
| POST /auth/login · credenciales válidas | OK | 200 | 200 |
| POST /auth/login · trae accessToken | OK | si | si |
| POST /auth/login · contraseña equivocada | OK | 401 | 401 |
| POST /auth/login · usuario que no existe | OK | 401 | 401 |
| POST /auth/login · JSON mal formado | OK | 400 | 400 |
| GET /health · sin token | OK | 200 | 200 |
| GET /health · trae status | OK | si | si |
| GET /courses · admin | OK | 200 | 200 |
| GET /courses · director | OK | 200 | 200 |
| GET /courses · sin token | OK | 401 | 401 |
| GET /courses · trae publicId | OK | si | si |
| GET /courses · trae professorName | OK | si | si |
| GET /courses · no trae el id | OK | no | no |
| GET /courses/{publicId} · existe | OK | 200 | 200 |
| GET /courses/{publicId} · sin token | OK | 401 | 401 |
| GET /courses/{publicId} · no existe | OK | 404 | 404 |
| POST /courses · admin | OK | 201 | 201 |
| POST /courses · trae publicId | OK | si | si |
| POST /courses · no trae el id | OK | no | no |
| POST /courses · nombre repetido | OK | 409 | 409 |
| POST /courses · sin token | OK | 401 | 401 |
| POST /courses · sin permiso | OK | 403 | 403 |
| POST /courses · JSON mal formado | OK | 400 | 400 |
| POST /courses · sin nombre | OK | 400 | 400 |
| PUT /courses/{publicId} · admin | OK | 200 | 200 |
| PUT /courses/{publicId} · sin token | OK | 401 | 401 |
| PUT /courses/{publicId} · sin permiso | OK | 403 | 403 |
| PUT /courses/{publicId} · no existe | OK | 404 | 404 |
| PUT /courses/{publicId} · JSON mal formado | OK | 400 | 400 |
| PATCH /courses/{publicId} · admin | OK | 200 | 200 |
| PATCH /courses/{publicId} · conserva el nombre | OK | si | si |
| PATCH /courses/{publicId} · sin token | OK | 401 | 401 |
| PATCH /courses/{publicId} · sin permiso | OK | 403 | 403 |
| PATCH /courses/{publicId} · no existe | OK | 404 | 404 |
| DELETE /courses/{publicId} · sin token | OK | 401 | 401 |
| DELETE /courses/{publicId} · sin permiso | OK | 403 | 403 |
| DELETE /courses/{publicId} · admin | OK | 204 | 204 |
| DELETE /courses/{publicId} · no existe | OK | 404 | 404 |
| GET /students/{studentPublicId}/enrollments · admin | OK | 200 | 200 |
| GET /students/{studentPublicId}/enrollments · director | OK | 200 | 200 |
| GET /students/{studentPublicId}/enrollments · sin token | OK | 401 | 401 |
| GET /students/{studentPublicId}/enrollments · no existe | OK | 404 | 404 |
| GET /students/{studentPublicId}/enrollments · trae coursePublicId | OK | si | si |
| GET /students/{studentPublicId}/enrollments · no trae el id | OK | no | no |
| POST /students/{studentPublicId}/enrollments · sin token | OK | 401 | 401 |
| POST /students/{studentPublicId}/enrollments · sin permiso | OK | 403 | 403 |
| POST /students/{studentPublicId}/enrollments · director | OK | 201 | 201 |
| POST /students/{studentPublicId}/enrollments · trae coursePublicId | OK | si | si |
| POST /students/{studentPublicId}/enrollments · no trae el id | OK | no | no |
| POST /students/{studentPublicId}/enrollments · inscripción repetida | OK | 409 | 409 |
| POST /students/{studentPublicId}/enrollments · curso no existe | OK | 404 | 404 |
| POST /students/{studentPublicId}/enrollments · estudiante no existe | OK | 404 | 404 |
| POST /students/{studentPublicId}/enrollments · JSON mal formado | OK | 400 | 400 |
| POST /students/{studentPublicId}/enrollments · sin curso | OK | 400 | 400 |
| DELETE /students/{studentPublicId}/enrollments/{coursePublicId} · sin token | OK | 401 | 401 |
| DELETE /students/{studentPublicId}/enrollments/{coursePublicId} · sin permiso | OK | 403 | 403 |
| DELETE /students/{studentPublicId}/enrollments/{coursePublicId} · director | OK | 204 | 204 |
| DELETE /students/{studentPublicId}/enrollments/{coursePublicId} · no existe | OK | 404 | 404 |
| GET /professors · admin | OK | 200 | 200 |
| GET /professors · director | OK | 200 | 200 |
| GET /professors · sin token | OK | 401 | 401 |
| GET /professors · trae publicId | OK | si | si |
| GET /professors · no trae el id | OK | no | no |
| GET /professors/{publicId} · existe | OK | 200 | 200 |
| GET /professors/{publicId} · sin token | OK | 401 | 401 |
| GET /professors/{publicId} · no existe | OK | 404 | 404 |
| POST /professors · admin | OK | 201 | 201 |
| POST /professors · trae publicId | OK | si | si |
| POST /professors · no trae el id | OK | no | no |
| POST /professors · sin token | OK | 401 | 401 |
| POST /professors · sin permiso | OK | 403 | 403 |
| POST /professors · JSON mal formado | OK | 400 | 400 |
| POST /professors · sin nombre | OK | 400 | 400 |
| PUT /professors/{publicId} · admin | OK | 200 | 200 |
| PUT /professors/{publicId} · sin token | OK | 401 | 401 |
| PUT /professors/{publicId} · sin permiso | OK | 403 | 403 |
| PUT /professors/{publicId} · no existe | OK | 404 | 404 |
| PUT /professors/{publicId} · JSON mal formado | OK | 400 | 400 |
| DELETE /professors/{publicId} · sin token | OK | 401 | 401 |
| DELETE /professors/{publicId} · sin permiso | OK | 403 | 403 |
| DELETE /professors/{publicId} · con cursos | OK | 409 | 409 |
| DELETE /professors/{publicId} · admin | OK | 204 | 204 |
| DELETE /professors/{publicId} · no existe | OK | 404 | 404 |
| GET /students · admin | OK | 200 | 200 |
| GET /students · director | OK | 200 | 200 |
| GET /students · sin token | OK | 401 | 401 |
| GET /students · sin permiso | OK | 403 | 403 |
| GET /students · trae publicId | OK | si | si |
| GET /students · trae code | OK | si | si |
| GET /students · no trae el id | OK | no | no |
| GET /students/{publicId} · existe | OK | 200 | 200 |
| GET /students/{publicId} · sin token | OK | 401 | 401 |
| GET /students/{publicId} · sin permiso | OK | 403 | 403 |
| GET /students/{publicId} · no existe | OK | 404 | 404 |
| POST /students · admin | OK | 201 | 201 |
| POST /students · trae publicId | OK | si | si |
| POST /students · no trae el id | OK | no | no |
| POST /students · código repetido | OK | 409 | 409 |
| POST /students · sin token | OK | 401 | 401 |
| POST /students · sin permiso | OK | 403 | 403 |
| POST /students · JSON mal formado | OK | 400 | 400 |
| POST /students · sin código | OK | 400 | 400 |
| PUT /students/{publicId} · admin | OK | 200 | 200 |
| PUT /students/{publicId} · sin token | OK | 401 | 401 |
| PUT /students/{publicId} · sin permiso | OK | 403 | 403 |
| PUT /students/{publicId} · no existe | OK | 404 | 404 |
| PUT /students/{publicId} · código de otro | OK | 409 | 409 |
| PUT /students/{publicId} · JSON mal formado | OK | 400 | 400 |
| DELETE /students/{publicId} · sin token | OK | 401 | 401 |
| DELETE /students/{publicId} · sin permiso | OK | 403 | 403 |
| DELETE /students/{publicId} · admin | OK | 204 | 204 |
| DELETE /students/{publicId} · no existe | OK | 404 | 404 |
