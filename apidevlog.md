## 2026-10-29 · Inventario de endpoints

- Hice: inventario de entidades y controllers; creé `apidev.md`.
- Archivos: `apidev.md` (nuevo)
- Decisiones: Auth y Health se listan aparte porque no corresponden a una entidad.
- Verificación: solo lectura, sin cambios de código
- Pendiente: corregir Course y exponer Student, Professor y Enrollment.

## 2026-10-29 · Corregir Course y completar los pendientes

- Hice: Course ajustado a las convenciones; nuevos endpoints de Student, Professor y Enrollment (subrecurso de Student).
- Cambios a endpoints existentes de Course:
  - `PUT /api/v1/courses` → `PUT /api/v1/courses/{publicId}`, implementado (antes lanzaba "Not implemented") y recibe `CourseRequestDTO`.
  - `PATCH /api/v1/courses` → `PATCH /api/v1/courses/{publicId}`, implementado, recibe `CourseRequestDTO` y solo cambia los campos enviados.
  - `DELETE /api/v1/courses/{publicId}` responde 204 sin cuerpo (antes 200 con `CourseDTO`).
  - Eliminado `DELETE /api/v1/courses` por query o cuerpo: duplicaba el anterior sin identificar el recurso en la ruta.
  - Nuevo `GET /api/v1/courses/{publicId}`.
  - `CourseRequest` renombrado a `CourseRequestDTO`; `credits` pasa a `Integer` para que el PATCH distinga "no enviado".
  - `CourseDTO` agrega `professorPublicId`.
- Archivos: `api/dto/CourseRequestDTO.java` (renombrado), `api/dto/CourseDTO.java`, `api/mapper/CourseMapper.java`, `api/CourseRestController.java`, `service/CourseService.java`, `service/impl/CourseServiceImpl.java` (editados); `api/dto/{Student,Professor,Enrollment}DTO.java`, `api/dto/{Student,Professor,Enrollment}RequestDTO.java`, `api/mapper/{Student,Professor,Enrollment}Mapper.java`, `api/{Student,Professor,Enrollment}RestController.java` (nuevos); `service/{Student,Professor,Enrollment}Service.java`, `service/impl/{Student,Professor,Enrollment}ServiceImpl.java`, `repo/{Student,Course,Enrollment}Repository.java` (editados)
- Decisiones: Enrollment no recibe `publicId`; se expone como `/students/{studentPublicId}/enrollments/{coursePublicId}` para no cambiar el esquema ni `data.sql`. `EnrollmentMapper` no tiene `toEntity` porque la entidad se arma con el estudiante y el curso que busca el service. Borrar un profesor con cursos se rechaza en vez de dejar cursos huérfanos. Los `// TODO` de `StudentServiceImpl` no se tocaron (son tarea). No hubo que agregar permisos: los CRUD de las tres entidades ya estaban en `data.sql` y asignados a ADMIN.
- Verificación: `./mvnw -q compile` sin errores; `./mvnw test` 6/6; prueba manual con la app y el usuario `nicolas`: todos los caminos felices responden 200/201/204.
- Pendiente: los errores de `/api/**` responden 302 (ver `apidev.md`).

## 2026-10-29 · Revisar el manejo de excepciones agregado por el profesor

- Hice: probé el `exceptionHandling` nuevo de la cadena `/api/**` en `WebSecurityConfig`; actualicé el pendiente en `apidev.md`.
- Archivos: `apidev.md` (editado)
- Decisiones: no toqué `security/` ni el código; solo verifiqué.
- Verificación: sin token → 401 JSON; usuario sin `CREATE_PROFESSOR` → 403 JSON; curso inexistente, profesor con cursos e inscripción duplicada → 302.
- Pendiente: `@RestControllerAdvice` para las excepciones de los services.

## 2026-10-29 · Manejo de errores y validación de la API

- Hice: los errores de `/api/**` dejan de responder 302. Nuevo `@RestControllerAdvice` con 400, 404 y 409 en JSON; validación de entrada con `@Valid` y `@NotBlank`; los services lanzan excepciones propias.
- Cambios a endpoints existentes (solo códigos de error, los caminos felices no cambian):
  - Recurso inexistente: 302 → 404 en todos los `{publicId}` de courses, professors, students y enrollments, y al crear un curso con un profesor que no existe.
  - Nombre de curso, código de estudiante o inscripción repetidos y borrar un profesor con cursos: 302 → 409.
  - JSON mal formado: 302 → 400, también en `POST /api/v1/auth/login`.
  - `POST`/`PUT` de courses, professors, students y `POST` de enrollments ahora rechazan con 400 los campos obligatorios vacíos (antes un curso o profesor sin nombre o un estudiante sin código se creaban con 201). Obligatorios: `CourseRequestDTO.name` y `professorPublicId`, `ProfessorRequestDTO.name`, `StudentRequestDTO.name` y `code`, `EnrollmentRequestDTO.coursePublicId`.
- Archivos: `api/ApiExceptionHandler.java`, `api/exception/NotFoundException.java`, `api/exception/ConflictException.java` (nuevos); `api/{Course,Student,Professor,Enrollment}RestController.java`, `api/dto/{Course,Student,Professor,Enrollment}RequestDTO.java`, `service/impl/{Course,Student,Professor,Enrollment}ServiceImpl.java`, `pom.xml` (`spring-boot-starter-validation`), `apidev.md` (editados)
- Decisiones: el advice se limita al paquete `api` para no afectar las vistas de Thymeleaf. No captura `RuntimeException` genérica, así que el `AccessDeniedException` de `@PreAuthorize` sigue llegando a la cadena de seguridad (403). Los métodos `*Rest` de Student y Course usan `saveAndFlush` para que la violación de unicidad salte dentro del service y llegue al advice como 409. Los métodos que usan las vistas MVC conservan sus excepciones.
- Verificación: `./mvnw -q compile` sin errores; `./mvnw test` 6/6; `bash test.sh` 112 de 116, cobertura 100 %.
- Pendiente: token alterado o vencido → 302 en vez de 401; se corrige en `JwtAuthFilter` (`security/`), que esta skill no toca.
