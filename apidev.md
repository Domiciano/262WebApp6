# Manifiesto de la API · 262WebApp6

Actualizado: 2026-10-29

## Course

- Expuesta: sí · DTO: `CourseDTO`, `CourseRequestDTO` · Mapper: `CourseMapper`
- publicId: sí
- `GET /api/v1/courses` · `READ_COURSE` · 200: lista de `CourseDTO`
- `GET /api/v1/courses/{publicId}` · `READ_COURSE` · 200: `CourseDTO`
- `POST /api/v1/courses` · `CREATE_COURSE` · 201: `CourseDTO` creado
- `PUT /api/v1/courses/{publicId}` · `UPDATE_COURSE` · 200: `CourseDTO` reemplazado
- `PATCH /api/v1/courses/{publicId}` · `UPDATE_COURSE` · 200: `CourseDTO` (solo cambia los campos enviados)
- `DELETE /api/v1/courses/{publicId}` · `DELETE_COURSE` · 204

## Enrollment

- Expuesta: sí, como subrecurso de Student · DTO: `EnrollmentDTO`, `EnrollmentRequestDTO` · Mapper: `EnrollmentMapper`
- publicId: no (llave compuesta); se identifica por `{studentPublicId}` + `{coursePublicId}`
- `GET /api/v1/students/{studentPublicId}/enrollments` · `READ_ENROLLMENT` · 200: lista de `EnrollmentDTO`
- `POST /api/v1/students/{studentPublicId}/enrollments` · `CREATE_ENROLLMENT` · 201: `EnrollmentDTO` creado
- `DELETE /api/v1/students/{studentPublicId}/enrollments/{coursePublicId}` · `DELETE_ENROLLMENT` · 204

## Permission

- Expuesta: no · publicId: sí
- No se expone por regla (modelo de seguridad), salvo pedido explícito

## Professor

- Expuesta: sí · DTO: `ProfessorDTO`, `ProfessorRequestDTO` · Mapper: `ProfessorMapper`
- publicId: sí
- `GET /api/v1/professors` · `READ_PROFESSOR` · 200: lista de `ProfessorDTO`
- `GET /api/v1/professors/{publicId}` · `READ_PROFESSOR` · 200: `ProfessorDTO`
- `POST /api/v1/professors` · `CREATE_PROFESSOR` · 201: `ProfessorDTO` creado
- `PUT /api/v1/professors/{publicId}` · `UPDATE_PROFESSOR` · 200: `ProfessorDTO`
- `DELETE /api/v1/professors/{publicId}` · `DELETE_PROFESSOR` · 204 (se rechaza si aún tiene cursos)

## Role

- Expuesta: no · publicId: sí
- No se expone por regla (modelo de seguridad), salvo pedido explícito

## RolePermission

- Expuesta: no · publicId: no (tabla puente)
- No se expone por regla (modelo de seguridad), salvo pedido explícito

## Student

- Expuesta: sí · DTO: `StudentDTO`, `StudentRequestDTO` · Mapper: `StudentMapper`
- publicId: sí
- `GET /api/v1/students` · `READ_STUDENT` · 200: lista de `StudentDTO`
- `GET /api/v1/students/{publicId}` · `READ_STUDENT` · 200: `StudentDTO`
- `POST /api/v1/students` · `CREATE_STUDENT` · 201: `StudentDTO` creado
- `PUT /api/v1/students/{publicId}` · `UPDATE_STUDENT` · 200: `StudentDTO`
- `DELETE /api/v1/students/{publicId}` · `DELETE_STUDENT` · 204 (borra también sus inscripciones)

## User

- Expuesta: no · publicId: sí
- No se expone por regla (modelo de seguridad), salvo pedido explícito

## UserRole

- Expuesta: no · publicId: no (tabla puente)
- No se expone por regla (modelo de seguridad), salvo pedido explícito

## Endpoints sin entidad

- `POST /api/v1/auth/login` · público · 200: `AuthResponse` (`accessToken`) · entrada `AuthRequest`
- `GET /api/v1/health` · público · 200: mapa `status` / `date`

## Errores

`ApiExceptionHandler` (`@RestControllerAdvice` sobre `api/`) responde en JSON `{"error", "message"}`:

- 400: JSON mal formado o campo obligatorio vacío (`@Valid` + `@NotBlank` en los `XxxRequestDTO`; el `PATCH` de cursos no valida porque admite campos parciales).
- 404: `NotFoundException` (`publicId` que no existe, inscripción que no existe).
- 409: `ConflictException` (curso con nombre repetido, inscripción repetida, profesor con cursos) y `DataIntegrityViolationException` (código de estudiante o nombre de curso repetido en `PUT`/`PATCH`).
- 401 sin token y 403 sin permiso los responde `WebSecurityConfig`.

## Pendientes

`test.sh`: 112 de 116 pasan; detalle en `testresults.md`.

- `JwtAuthFilter` (en `security/`, fuera del alcance de esta skill): un token alterado o vencido (`SignatureException`, `ExpiredJwtException`) y un encabezado `Bearer ` vacío responden 302 en vez de 401. Hay que atrapar `JwtException` en el filtro, limpiar el contexto y dejar que el `authenticationEntryPoint` de la cadena `/api/**` responda 401, y revisar que el encabezado empiece por `Bearer ` antes del `substring(7)`. Las 4 pruebas `token alterado` fallan por esto.
- Los métodos `// TODO` de `StudentServiceImpl` (tarea del curso) siguen sin implementar; la API nueva no los usa.
