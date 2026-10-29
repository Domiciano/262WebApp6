# AGENTS.md — Contexto y Guía del Proyecto

> **Propósito**: Este documento proporciona a agentes autónomos de IA y desarrolladores el contexto técnico, arquitectónico, de dominio y operativo completo del repositorio **262WebApp4** (`IntroSpringBoot`).

---

## 1. Visión General del Proyecto

- **Nombre del Artefacto**: `IntroSpringBoot` (Curso Computación en la Red / Aplicaciones Web - Universidad Icesi).
- **Tipo de Aplicación**: Aplicación Web híbrida monolítica desarrollada con **Spring Boot**:
  1. **API RESTful** con autenticación sin estado (Stateless) basada en **JWT (JSON Web Tokens)** en rutas `/api/**`.
  2. **Vistas Web MVC** tradicionales renderizadas en servidor con **Thymeleaf**, securizadas por sesiones y formulario de login tradicional en rutas como `/user/**`, `/course/**`, `/role/**`, etc.
  3. **Sistema de Seguridad RBAC (Role-Based Access Control) + Permisos Granulares** implementado a nivel de filtros HTTP y a nivel de métodos de servicio mediante `@PreAuthorize`.
- **Dominio del Negocio**: Sistema de gestión académica universitaria: profesores, cursos, estudiantes, matrículas/inscripciones (`enrollments`), usuarios, roles y permisos de acceso.

---

## 2. Stack Tecnológico

| Componente | Tecnología / Versión |
|---|---|
| **Lenguaje** | Java 17 |
| **Framework Base** | Spring Boot `3.5.11` |
| **Módulos Spring** | Spring Web, Spring Security, Spring Data JPA, Thymeleaf |
| **Base de Datos** | H2 Database (en memoria: `jdbc:h2:mem:testdb`) |
| **Seguridad JWT** | `io.jsonwebtoken:jjwt-api:0.11.5` (+ impl & jackson runtime) |
| **Mapeo DTO/Entidad** | MapStruct `1.6.3` (`lombok-mapstruct-binding:0.2.0`) |
| **Boilerplate** | Project Lombok |
| **Pruebas** | JUnit 5, Mockito, Spring Security Test, Spring Boot Test |
| **Gestor de Compilación** | Apache Maven 3 (`./mvnw` Wrapper incluido) |
| **Empaquetado** | WAR (`<packaging>war</packaging>`) con soporte Servlet 6/Tomcat |

---

## 3. Configuración y Propiedades del Entorno

Archivo principal: `src/main/resources/application.properties`

```properties
spring.application.name=IntroSpringBoot
server.port=8080
server.servlet.context-path=/WebApp6

# Base de datos en memoria H2
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.defer-datasource-initialization=true

# Consola H2
spring.h2.console.enabled=true
spring.h2.console.path=/h2
# URL real de consola: http://localhost:8080/WebApp6/h2

# Configuración JWT
app.security.secretkey=universidadicesiuniversidadicesiuniversidadicesi
app.security.expirationMinutes=30
```

> **IMPORTANTE**: La aplicación utiliza el context-path `/WebApp6`. Cualquier petición HTTP debe incluir este prefijo: `http://localhost:8080/WebApp6/...`.

---

## 4. Estructura de Directorios

```text
262WebApp4/
├── 262Compu2.postman_collection.json  # Colección Postman de prueba
├── mvnw / mvnw.cmd                    # Maven Wrappers
├── pom.xml                            # Configuración del proyecto y dependencias
└── src/
    ├── main/
    │   ├── java/edu/co/icesi/introspringboot/
    │   │   ├── IntroSpringBootApplication.java # Entry point
    │   │   ├── ServletInitializer.java         # Inicializador WAR
    │   │   ├── api/                            # Controladores REST API
    │   │   │   ├── AuthRestController.java
    │   │   │   ├── CourseRestController.java
    │   │   │   ├── HealthCheckerRestController.java
    │   │   │   ├── dto/                        # AuthRequest, AuthResponse, CourseDTO, CourseRequest
    │   │   │   └── mapper/                     # CourseMapper (MapStruct)
    │   │   ├── controller/                     # Controladores Spring MVC (Thymeleaf)
    │   │   │   ├── CourseController.java
    │   │   │   ├── ProfessorController.java
    │   │   │   ├── ProfileController.java
    │   │   │   ├── RoleController.java
    │   │   │   └── UserController.java
    │   │   ├── entity/                         # Entidades JPA
    │   │   │   ├── Course.java
    │   │   │   ├── Enrollment.java
    │   │   │   ├── Permission.java
    │   │   │   ├── Professor.java
    │   │   │   ├── Role.java
    │   │   │   ├── RolePermission.java
    │   │   │   ├── Student.java
    │   │   │   ├── User.java (Tabla: app_user)
    │   │   │   ├── UserRole.java
    │   │   │   └── keys/                       # Composite Keys (@Embeddable)
    │   │   │       ├── RolePermissionId.java
    │   │   │       ├── StudentCourseId.java
    │   │   │       └── UserRoleId.java
    │   │   ├── repo/                           # Repositorios Spring Data JPA
    │   │   │   ├── CourseRepository.java
    │   │   │   ├── EnrollmentRepository.java
    │   │   │   ├── PermissionRepository.java
    │   │   │   ├── ProfessorRepository.java
    │   │   │   ├── RolePermissionRepository.java
    │   │   │   ├── RoleRepository.java
    │   │   │   ├── StudentRepository.java
    │   │   │   ├── UserRepository.java
    │   │   │   └── UserRoleRepository.java
    │   │   ├── security/                       # Configuración y filtros de seguridad
    │   │   │   ├── CustomUserDetailService.java
    │   │   │   ├── JwtService.java
    │   │   │   ├── WebSecurityConfig.java
    │   │   │   └── filter/
    │   │   │       └── JwtAuthFilter.java
    │   │   └── service/                        # Interfaces de Servicios
    │   │       ├── CourseService.java
    │   │       ├── EnrollmentService.java
    │   │       ├── ...
    │   │       └── impl/                       # Implementaciones (@Service)
    │   └── resources/
    │       ├── application.properties
    │       ├── data.sql                        # Carga de datos iniciales / seeds
    │       ├── static/css/                     # Estilos (auth.css, styles.css, etc.)
    │       └── templates/                      # Plantillas Thymeleaf (course, user, role, professor)
    └── test/
        ├── resources/application.properties
        └── java/edu/co/icesi/introspringboot/
            ├── ApplicationTests.java
            ├── unit/services/                  # Pruebas unitarias con Mockito
            │   └── CourseServiceTest.java
            └── integration/services/           # Pruebas de integración con @SpringBootTest
                └── CourseServiceIntegrationTest.java
```

---

## 5. Modelo de Dominio y Entidades

### 5.1 Patrón de Doble Identificador
Cada entidad principal maneja dos identificadores:
- `id` (`Integer`): Llave primaria relacional autoincremental (`GenerationType.IDENTITY`). Uso exclusivo para joins e integridad referencial interna.
- `publicId` (`String` UUID 36 chars): Llave pública expuesta al exterior/cliente (`unique = true, nullable = false, updatable = false`).

### 5.2 Claves Compuestas
Las relaciones intermedias muchos-a-muchos con atributos o entidad propia utilizan `@EmbeddedId` y `@MapsId`:
- `UserRole` (`UserRoleId`: `userId`, `roleId`)
- `RolePermission` (`RolePermissionId`: `roleId`, `permissionId`)
- `Enrollment` (`StudentCourseId`: `studentId`, `courseId`) sobre la tabla `student_course`

### 5.3 Entidades Principales
- **`User` (tabla: `app_user`)**: `id`, `public_id`, `username`, `password` (BCrypt hash).
- **`Role`**: `id`, `public_id`, `name` (ej. `ROLE_ADMIN`, `ROLE_DIRECTOR`).
- **`Permission`**: `id`, `public_id`, `name` (ej. `CREATE_COURSE`, `READ_COURSE`, `DELETE_COURSE`, etc.).
- **`Professor`**: `id`, `public_id`, `name`.
- **`Course`**: `id`, `public_id`, `name`, `credits`, relación `ManyToOne` con `Professor`.
- **`Student`**: `id`, `public_id`, `name`, `code`, `program`.
- **`Enrollment`**: Tabla intermedia `student_course` vinculando estudiante y curso.

---

## 6. Arquitectura de Seguridad (Spring Security)

Configurada en `WebSecurityConfig.java` con `@EnableMethodSecurity`:

### 6.1 Cadenas de Filtros (`SecurityFilterChain`)
1. **Order(1) - Consola H2 (`/h2/**`)**:
   - Acceso permitido a todos (`permitAll`).
   - CSRF deshabilitado para la consola y `frameOptions.sameOrigin()`.
2. **Order(2) - API REST (`/api/**`)**:
   - `Stateless`: `SessionCreationPolicy.STATELESS`.
   - CSRF deshabilitado (`csrf.disable()`).
   - Rutas públicas: `/api/v1/auth/**`, `/api/v1/health`.
   - Resto de rutas `/api/**`: autenticación requerida.
   - Filtro: `JwtAuthFilter` antes de `UsernamePasswordAuthenticationFilter`.
   - Reconstrucción de contexto: `JwtAuthFilter` extrae el claim `authorities` directamente del token y reconstruye la instancia `Authentication` sin necesidad de consultar nuevamente la base de datos.
3. **Order(3) - Vistas MVC (`/**`)**:
   - Rutas estáticas `/css/**` públicas.
   - Formulario de login: `/user/login`.
   - Redirección por defecto al autenticarse: `/profile/me`.

### 6.2 Carga de Autoridades (`CustomUserDetailService`)
Para cada usuario autenticado en login, `loadUserByUsername` consulta:
- `roleRepository.findByUserRoles_User_Username(username)`
- `permissionRepository.findDistinctByRolePermissions_Role_UserRoles_User_Username(username)`

Luego aplanan en una lista combinada de `SimpleGrantedAuthority`:
1. Los nombres de los roles (ej. `ROLE_ADMIN`, `ROLE_DIRECTOR`).
2. Los nombres de cada permiso individual asignado a sus roles (ej. `CREATE_COURSE`, `READ_STUDENT`, etc.).

### 6.3 Particularidades y Advertencias de Seguridad (`JwtAuthFilter`)
- `JwtAuthFilter` asume el prefijo `Bearer ` con `substring(7)`.
- Si se añaden nuevas rutas a la API que deban ser públicas, deben registrarse explícitamente en el `SecurityFilterChain` de `Order(2)`.
- Las rutas web protegidas por formulario deben respetarse en el `Order(3)`.

### 6.3 Seguridad a Nivel de Métodos
Los servicios validan permisos con anotaciones como:
```java
@PreAuthorize("hasAuthority('CREATE_COURSE') and hasAuthority('CREATE_PROFESSOR')")
@PreAuthorize("hasAuthority('DELETE_COURSE')")
```

### 6.4 Usuarios y Credenciales Semilla (`data.sql`)
La contraseña predeterminada para todos los usuarios de prueba en `data.sql` es `123456` (hash BCrypt: `$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506`):
- `nicolas` (Rol: `ROLE_ADMIN`, todos los permisos 1 al 19).
- `juanchoking` (Rol: `ROLE_DIRECTOR`).
- `barragan` (Rol: `ROLE_DIRECTOR`).
- `granda` (Rol: `ROLE_DIRECTOR`).
- `martinez`.

---

## 7. Flujo de API REST y Colección Postman

Archivo: `262Compu2.postman_collection.json`

### 7.1 Autenticación REST
- **Endpoint**: `POST /WebApp6/api/v1/auth/login`
- **Body**:
  ```json
  {
    "username": "nicolas",
    "password": "123456"
  }
  ```
- **Respuesta**:
  ```json
  {
    "accessToken": "<JWT_TOKEN>"
  }
  ```

### 7.2 Cursos REST
- **Listar Cursos**: `GET /WebApp6/api/v1/courses` con Header `Authorization: Bearer <accessToken>`.
- **Crear Curso**: `POST /WebApp6/api/v1/courses` con payload `CourseRequest`.
- **Eliminar Curso**: `DELETE /WebApp6/api/v1/courses/{publicId}` con Header `Authorization: Bearer <accessToken>` (también soporta envío de `publicId` en cuerpo JSON o query parameter).

---

## 8. Comandos de Construcción y Ejecución

Todos los comandos deben ejecutarse desde la raíz del proyecto usando el wrapper de Maven (`./mvnw` en Unix/macOS, `mvnw.cmd` en Windows):

```bash
# Compilar el proyecto
./mvnw clean compile

# Compilar pruebas
./mvnw test-compile

# Ejecutar toda la suite de pruebas (unitarias e integración)
./mvnw test

# Ejecutar una prueba específica
./mvnw test -Dtest=CourseServiceTest
./mvnw test -Dtest=CourseServiceIntegrationTest

# Iniciar la aplicación en modo desarrollo
./mvnw spring-boot:run

# Empaquetar artefacto WAR
./mvnw clean package -DskipTests
```

---

## 9. Patrones y Buenas Prácticas para Agentes

Al modificar, extender o depurar código en este repositorio, cumpla estrictamente con las siguientes reglas:

1. **Uso de MapStruct y DTOs**:
   - No exponga entidades directamente en los endpoints REST. Use DTOs en `api.dto` y mapeadores MapStruct en `api.mapper`.
   - MapStruct está configurado con component model `spring`: inyéctelo con `@Autowired` en los servicios o controladores.
2. **Generación de `publicId`**:
   - Al crear nuevas entidades (`Course`, `Professor`, `Student`, `User`, etc.), asegúrese de inicializar `publicId` con `UUID.randomUUID().toString()` si es nulo antes de persistir.
3. **Mantenimiento de Seguridad**:
   - Siempre anote métodos de negocio críticos con `@PreAuthorize("hasAuthority('NOMBRE_PERMISO')")` y `@Transactional` cuando aplique.
   - Para contraseñas nuevas, use siempre `PasswordEncoder` (`BCryptPasswordEncoder`). Nunca guarde contraseñas en texto plano.
4. **Convenciones de Pruebas**:
   - Pruebas unitarias: Colocadas en `src/test/java/.../unit/`, utilizando `@ExtendWith(MockitoExtension.class)`, `@Mock`, `@InjectMocks` y escenarios limpios (`scenario1()`).
   - Pruebas de integración: Colocadas en `src/test/java/.../integration/`, utilizando `@SpringBootTest` y `@WithMockUser(authorities = "...")` para simular permisos sin levantar sesión web completa.
5. **No romper `application.properties` ni `data.sql`**:
   - Los tests de integración y la ejecución dependen del esquema cargado en memoria desde `data.sql`. Si modifica entidades, actualice coherentemente las sentencias `INSERT` para evitar fallos de Foreign Key o Constraint Violations.
