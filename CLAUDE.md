# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
./mvnw spring-boot:run                       # run the app
./mvnw clean package                         # build
./mvnw test                                  # all tests
./mvnw test -Dtest=CourseServiceTest         # one test class
./mvnw test -Dtest=CourseServiceTest#methodName   # one test method
```

Java 17, Spring Boot 3.5. The app runs under context path `/WebApp6` on port 8080, so all URLs are `http://localhost:8080/WebApp6/...`. H2 console: `/WebApp6/h2` (in-memory DB `testdb`, user `sa`, empty password). `262Compu2.postman_collection.json` holds sample REST calls.

## Architecture

Educational Spring Boot app (package `edu.co.icesi.introspringboot`) for a student/course/professor domain plus users, roles and permissions. It serves **two UIs from one codebase**, each behind its own security filter chain:

- **Server-rendered MVC** (`controller/` + Thymeleaf templates in `resources/templates/`, CSS in `static/css/`). Session + form login (`/user/login`, success redirect `/profile/me`). Everything except `/css/**` requires authentication.
- **JSON REST API** (`api/`, base path `/api/v1/**`). Stateless, CSRF off, JWT bearer auth. `/api/v1/auth/**` and `/api/v1/health` are public. `api/dto/` holds DTOs and `api/mapper/` holds MapStruct mappers (Lombok + MapStruct annotation processors are configured in `pom.xml`; keep the `lombok-mapstruct-binding` order).

### Security (`security/`)

`WebSecurityConfig` defines three ordered `SecurityFilterChain`s: (1) H2 console, open; (2) `/api/**` with `JwtAuthFilter`; (3) everything else with form login. Add new public paths in the chain that matches them.

Auth flow for the API: `POST /api/v1/auth/login` → `AuthenticationManager` → `CustomUserDetailService` → `JwtService.generateToken`. The token's `authorities` claim contains **both role names and permission names** (flattened by `CustomUserDetailService` via the nested repository queries `findByUserRoles_User_Username` / `findDistinct...RolePermissions_Role_UserRoles_User_Username`). `JwtAuthFilter` rebuilds the `Authentication` from that claim without hitting the DB. Method security is enabled (`@EnableMethodSecurity`). JWT secret and expiry come from `app.security.secretkey` / `app.security.expirationMinutes`.

Known rough edges in `JwtAuthFilter`: it assumes any `Authorization` header is `Bearer <token>` (`substring(7)`), doesn't catch invalid/expired tokens, and prints tokens to stdout.

### Data model

JPA entities in `entity/`: `Student`, `Course`, `Professor`, `Enrollment` (composite key `StudentCourseId`, table `student_course`), and the auth model `User` ↔ `UserRole` ↔ `Role` ↔ `RolePermission` ↔ `Permission` (composite keys in `entity/keys/`). Entities carry a `public_id` UUID alongside the numeric id. Schema comes from Hibernate (`ddl-auto=update`); seed data is `resources/data.sql` (relies on `defer-datasource-initialization=true` and hard-coded numeric ids, so insertion order matters). `data.sql-E` is a stray sed backup.

### Service layer convention

Each service is an interface in `service/` with a single `@Service` `XxxServiceImpl` in `service/impl/`. Controllers depend on the interface; business logic lives in the impl. Repositories (`repo/`, note: not `repository/`) are Spring Data JPA with derived query methods. Services expose separate `*Rest` methods (e.g. `CourseService.getAllRest` / `createRest`) that return DTOs for the API, next to the entity-returning methods used by MVC controllers.

`StudentServiceImpl` intentionally contains `// TODO` stubs (find by code, students by course name, delete by code, enroll/unenroll) — these are course homework exercises, not oversights. `CourseRestController` `PUT`/`PATCH`/`DELETE` likewise throw "Not implemented" on purpose.

## Testing

Tests live under `src/test/java/.../unit/services` (Mockito, mocked repositories) and `.../integration/services` (real H2). `src/test/resources/application.properties` uses `create-drop` DDL and sets `spring.sql.init.mode=never`, so integration tests must create their own data; `data.sql` is not loaded.
