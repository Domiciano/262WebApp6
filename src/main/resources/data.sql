-- Profesores
INSERT INTO professor (name) VALUES ('Juan Perez');
INSERT INTO professor (name) VALUES ('Maria Rodriguez');
INSERT INTO professor (name) VALUES ('Marlon Gomez');

-- Cursos
INSERT INTO course (name, credits, professor_id) VALUES ('Introduccion a la Programacion', 4, 3);
INSERT INTO course (name, credits, professor_id) VALUES ('Estructuras de Datos', 4, 1);
INSERT INTO course (name, credits, professor_id) VALUES ('Anatomia Humana', 5, 3);
INSERT INTO course (name, credits, professor_id) VALUES ('Fisiologia', 5, 2);
INSERT INTO course (name, credits, professor_id) VALUES ('Derecho Penal', 3, 3);
INSERT INTO course (name, credits, professor_id) VALUES ('Historia del Arte', 3, 3);

-- Estudiantes
INSERT INTO student (name, code, program) VALUES ('Laura Garcia', '2021102001', 'Ingenieria de Sistemas');
INSERT INTO student (name, code, program) VALUES ('Pedro Pascal', '2021102002', 'Ingenieria de Sistemas');
INSERT INTO student (name, code, program) VALUES ('Andres Lopez', '2021102003', 'Medicina');
INSERT INTO student (name, code, program) VALUES ('Sofia Torres', '2021102004', 'Derecho');
INSERT INTO student (name, code, program) VALUES ('Camila Velez', '2021102005', 'Medicina');

-- Inscripciones (student_course)
INSERT INTO student_course (student_id, course_id) VALUES (1, 1);
INSERT INTO student_course (student_id, course_id) VALUES (1, 2);
INSERT INTO student_course (student_id, course_id) VALUES (2, 1);
INSERT INTO student_course (student_id, course_id) VALUES (3, 3);
INSERT INTO student_course (student_id, course_id) VALUES (3, 4);
INSERT INTO student_course (student_id, course_id) VALUES (4, 5);
INSERT INTO student_course (student_id, course_id) VALUES (4, 6);
INSERT INTO student_course (student_id, course_id) VALUES (5, 3);


-- ─── PERMISOS: 4 operaciones × 4 tablas = 16 permisos ───────────────────────
INSERT INTO permission (name) VALUES ('CREATE_STUDENT');    -- 1
INSERT INTO permission (name) VALUES ('READ_STUDENT');      -- 2
INSERT INTO permission (name) VALUES ('UPDATE_STUDENT');    -- 3
INSERT INTO permission (name) VALUES ('DELETE_STUDENT');    -- 4
INSERT INTO permission (name) VALUES ('CREATE_PROFESSOR');  -- 5
INSERT INTO permission (name) VALUES ('READ_PROFESSOR');    -- 6
INSERT INTO permission (name) VALUES ('UPDATE_PROFESSOR');  -- 7
INSERT INTO permission (name) VALUES ('DELETE_PROFESSOR');  -- 8
INSERT INTO permission (name) VALUES ('CREATE_ENROLLMENT'); -- 9
INSERT INTO permission (name) VALUES ('READ_ENROLLMENT');   -- 10
INSERT INTO permission (name) VALUES ('UPDATE_ENROLLMENT'); -- 11
INSERT INTO permission (name) VALUES ('DELETE_ENROLLMENT'); -- 12
INSERT INTO permission (name) VALUES ('CREATE_COURSE');     -- 13
INSERT INTO permission (name) VALUES ('READ_COURSE');       -- 14
INSERT INTO permission (name) VALUES ('UPDATE_COURSE');     -- 15
INSERT INTO permission (name) VALUES ('DELETE_COURSE');     -- 16
INSERT INTO permission (name) VALUES ('READ_USER');         -- 17
INSERT INTO permission (name) VALUES ('DELETE_USER');       -- 18
INSERT INTO permission (name) VALUES ('CREATE_USER');       -- 19

-- ─── ROLES ───────────────────────────────────────────────────────────────────
INSERT INTO role (name) VALUES ('ROLE_ADMIN');    -- 1
INSERT INTO role (name) VALUES ('ROLE_DIRECTOR'); -- 2

-- ─── ADMIN: todos los permisos (1 – 19) ──────────────────────────────────────
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 1);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 2);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 3);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 4);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 5);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 6);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 7);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 8);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 9);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 10);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 11);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 12);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 13);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 14);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 15);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 16);
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 17); -- READ_USER
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 18); -- DELETE_USER
INSERT INTO role_permission (role_id, permission_id) VALUES (1, 19); -- CREATE_USER

-- ─── DIRECTOR: leer todo + CRUD completo de Enrollment ───────────────────────
--   READ de todas las tablas
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 2);  -- READ_STUDENT
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 6);  -- READ_PROFESSOR
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 14); -- READ_COURSE
--   CRUD completo de Enrollment
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 9);  -- CREATE_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 10); -- READ_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 11); -- UPDATE_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (2, 12); -- DELETE_ENROLLMENT

-- ─── USUARIOS (contraseña en texto plano solo para pruebas) ──────────────────
INSERT INTO app_user (username, password) VALUES ('nicolas',  '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');    -- 1
INSERT INTO app_user (username, password) VALUES ('juanchoking',   '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');    -- 2
INSERT INTO app_user (username, password) VALUES ('barragan',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');      -- 3
INSERT INTO app_user (username, password) VALUES ('granda',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');      -- 4
INSERT INTO app_user (username, password) VALUES ('martinez',   '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');      -- 5

-- ─── ASIGNACIÓN DE ROLES ─────────────────────────────────────────────────────
INSERT INTO user_role (user_id, role_id) VALUES (1, 1); -- carlos  → ADMIN
INSERT INTO user_role (user_id, role_id) VALUES (2, 2); -- maria   → ADMIN
INSERT INTO user_role (user_id, role_id) VALUES (3, 2); -- ana     → DIRECTOR
INSERT INTO user_role (user_id, role_id) VALUES (4, 2); -- juan    → DIRECTOR
INSERT INTO user_role (user_id, role_id) VALUES (5, 2); -- sofia   → DIRECTOR

-- 7 Profesores adicionales (Juan Perez, Maria Rodriguez y Carlos Gomez ya existen, ids 1-3)
INSERT INTO professor (name) VALUES ('Ana Martinez');
INSERT INTO professor (name) VALUES ('Luis Hernandez');
INSERT INTO professor (name) VALUES ('Pedro Sanchez');
INSERT INTO professor (name) VALUES ('Rosa Moreno');
INSERT INTO professor (name) VALUES ('Jorge Castillo');
INSERT INTO professor (name) VALUES ('Elena Vargas');
INSERT INTO professor (name) VALUES ('Miguel Torres');

-- 47 Cursos adicionales (todos con nombre distinto entre si y respecto a los 6 de arriba)
-- Juan Perez (Sistemas) — Introduccion a la Programacion y Estructuras de Datos ya existen (ids 1-2)
INSERT INTO course (name, credits, professor_id) VALUES ('Algoritmos y Complejidad', 4, 1);
INSERT INTO course (name, credits, professor_id) VALUES ('Base de Datos', 3, 1);
INSERT INTO course (name, credits, professor_id) VALUES ('Redes de Computadores', 3, 1);

-- Maria Rodriguez (Medicina) — Anatomia Humana y Fisiologia ya existen (ids 3-4)
INSERT INTO course (name, credits, professor_id) VALUES ('Bioquimica Medica', 4, 2);
INSERT INTO course (name, credits, professor_id) VALUES ('Farmacologia', 4, 2);
INSERT INTO course (name, credits, professor_id) VALUES ('Patologia General', 5, 2);

-- Carlos Gomez (Derecho) — Derecho Penal ya existe (id 5)
INSERT INTO course (name, credits, professor_id) VALUES ('Derecho Civil', 3, 3);
INSERT INTO course (name, credits, professor_id) VALUES ('Derecho Constitucional', 3, 3);
INSERT INTO course (name, credits, professor_id) VALUES ('Derecho Laboral', 3, 3);
INSERT INTO course (name, credits, professor_id) VALUES ('Derecho Internacional', 2, 3);

-- Ana Martinez (Arquitectura)
INSERT INTO course (name, credits, professor_id) VALUES ('Dibujo Tecnico', 2, 4);
INSERT INTO course (name, credits, professor_id) VALUES ('Diseno Arquitectonico I', 4, 4);
INSERT INTO course (name, credits, professor_id) VALUES ('Diseno Arquitectonico II', 4, 4);
INSERT INTO course (name, credits, professor_id) VALUES ('Historia de la Arquitectura', 3, 4);
INSERT INTO course (name, credits, professor_id) VALUES ('Materiales de Construccion', 3, 4);

-- Luis Hernandez (Historia y Arte) — 'Historia del Arte' ya existe (id 6), no se repite aqui
INSERT INTO course (name, credits, professor_id) VALUES ('Historia Universal', 3, 5);
INSERT INTO course (name, credits, professor_id) VALUES ('Historia de Colombia', 3, 5);
INSERT INTO course (name, credits, professor_id) VALUES ('Filosofia Moderna', 2, 5);
INSERT INTO course (name, credits, professor_id) VALUES ('Etica y Sociedad', 2, 5);

-- Pedro Sanchez (Matematicas)
INSERT INTO course (name, credits, professor_id) VALUES ('Calculo Diferencial', 4, 6);
INSERT INTO course (name, credits, professor_id) VALUES ('Calculo Integral', 4, 6);
INSERT INTO course (name, credits, professor_id) VALUES ('Algebra Lineal', 4, 6);
INSERT INTO course (name, credits, professor_id) VALUES ('Ecuaciones Diferenciales', 3, 6);
INSERT INTO course (name, credits, professor_id) VALUES ('Estadistica y Probabilidad', 3, 6);

-- Rosa Moreno (Fisica)
INSERT INTO course (name, credits, professor_id) VALUES ('Fisica Mecanica', 4, 7);
INSERT INTO course (name, credits, professor_id) VALUES ('Fisica Electromagnetismo', 4, 7);
INSERT INTO course (name, credits, professor_id) VALUES ('Fisica Moderna', 3, 7);
INSERT INTO course (name, credits, professor_id) VALUES ('Laboratorio de Fisica I', 2, 7);
INSERT INTO course (name, credits, professor_id) VALUES ('Laboratorio de Fisica II', 2, 7);

-- Jorge Castillo (Quimica)
INSERT INTO course (name, credits, professor_id) VALUES ('Quimica General', 4, 8);
INSERT INTO course (name, credits, professor_id) VALUES ('Quimica Organica', 4, 8);
INSERT INTO course (name, credits, professor_id) VALUES ('Quimica Analitica', 3, 8);
INSERT INTO course (name, credits, professor_id) VALUES ('Laboratorio de Quimica', 2, 8);
INSERT INTO course (name, credits, professor_id) VALUES ('Quimica Ambiental', 3, 8);

-- Elena Vargas (Biologia)
INSERT INTO course (name, credits, professor_id) VALUES ('Biologia Celular', 4, 9);
INSERT INTO course (name, credits, professor_id) VALUES ('Genetica', 4, 9);
INSERT INTO course (name, credits, professor_id) VALUES ('Microbiologia', 3, 9);
INSERT INTO course (name, credits, professor_id) VALUES ('Ecologia', 3, 9);
INSERT INTO course (name, credits, professor_id) VALUES ('Botanica', 3, 9);

-- Miguel Torres (Economia)
INSERT INTO course (name, credits, professor_id) VALUES ('Microeconomia', 3, 10);
INSERT INTO course (name, credits, professor_id) VALUES ('Macroeconomia', 3, 10);
INSERT INTO course (name, credits, professor_id) VALUES ('Economia Internacional', 3, 10);
INSERT INTO course (name, credits, professor_id) VALUES ('Finanzas Corporativas', 4, 10);
INSERT INTO course (name, credits, professor_id) VALUES ('Contabilidad General', 3, 10);

-- ─── PROFESOR SIN CURSOS ASIGNADOS (edge case: JOIN vacio / lista vacia) ─────
INSERT INTO professor (name) VALUES ('Diana Ospina'); -- id 11

-- ─── CURSOS CON CREDITOS LIMITE (para Between/GreaterThan/LessThan) ─────────
INSERT INTO course (name, credits, professor_id) VALUES ('Ingles Tecnico', 2, 4);                -- id 51 (Ana Martinez), electiva abierta a varios programas
INSERT INTO course (name, credits, professor_id) VALUES ('Seminario de Investigacion', 1, 1);    -- id 52
INSERT INTO course (name, credits, professor_id) VALUES ('Trabajo de Grado', 6, 2);              -- id 53

-- ─── ESTUDIANTES ADICIONALES ────────────────────────────────────────────────
INSERT INTO student (name, code, program) VALUES ('Mariana Perez', '2022102006', 'Ingenieria de Sistemas');     -- id 6, sin inscripciones (edge case)
INSERT INTO student (name, code, program) VALUES ('Laura Garcia', '2023102007', 'Arquitectura');                -- id 7, mismo nombre que el id 1, distinto codigo/programa
INSERT INTO student (name, code, program) VALUES ('Juan Pablo Marin', '2022102008', 'Matematicas');             -- id 8
INSERT INTO student (name, code, program) VALUES ('Valentina Ruiz', '2022102009', 'Fisica');                    -- id 9
INSERT INTO student (name, code, program) VALUES ('Santiago Ramirez', '2022102010', 'Quimica');                 -- id 10
INSERT INTO student (name, code, program) VALUES ('Isabella Castro', '2023102011', 'Biologia');                 -- id 11
INSERT INTO student (name, code, program) VALUES ('Daniel Ortiz', '2023102012', 'Economia');                    -- id 12
INSERT INTO student (name, code, program) VALUES ('MARIA JOSE Gomez', '2023102013', 'Historia del Arte');       -- id 13, mayusculas para ContainingIgnoreCase
INSERT INTO student (name, code, program) VALUES ('Nicolas Vargas', '2021102014', 'Ingenieria de Sistemas');    -- id 14, el mas inscrito
INSERT INTO student (name, code, program) VALUES ('Camilo Restrepo', '2024102015', 'Derecho');                  -- id 15

-- ─── INSCRIPCIONES ADICIONALES (varios estudiantes por curso disponible) ────
INSERT INTO student_course (student_id, course_id) VALUES (2, 7);   -- Pedro Pascal + Algoritmos y Complejidad
INSERT INTO student_course (student_id, course_id) VALUES (8, 1);   -- Juan Pablo Marin + Introduccion a la Programacion (electiva)
INSERT INTO student_course (student_id, course_id) VALUES (14, 1);  -- Nicolas Vargas + Introduccion a la Programacion
INSERT INTO student_course (student_id, course_id) VALUES (14, 2);  -- Nicolas Vargas + Estructuras de Datos
INSERT INTO student_course (student_id, course_id) VALUES (14, 7);  -- Nicolas Vargas + Algoritmos y Complejidad
INSERT INTO student_course (student_id, course_id) VALUES (14, 8);  -- Nicolas Vargas + Base de Datos
INSERT INTO student_course (student_id, course_id) VALUES (14, 9);  -- Nicolas Vargas + Redes de Computadores
INSERT INTO student_course (student_id, course_id) VALUES (7, 17);  -- Laura Garcia (Arquitectura) + Dibujo Tecnico
INSERT INTO student_course (student_id, course_id) VALUES (7, 18);  -- Laura Garcia (Arquitectura) + Diseno Arquitectonico I
INSERT INTO student_course (student_id, course_id) VALUES (8, 26);  -- Juan Pablo Marin + Calculo Diferencial
INSERT INTO student_course (student_id, course_id) VALUES (8, 28);  -- Juan Pablo Marin + Algebra Lineal
INSERT INTO student_course (student_id, course_id) VALUES (8, 30);  -- Juan Pablo Marin + Estadistica y Probabilidad
INSERT INTO student_course (student_id, course_id) VALUES (9, 31);  -- Valentina Ruiz + Fisica Mecanica
INSERT INTO student_course (student_id, course_id) VALUES (9, 34);  -- Valentina Ruiz + Laboratorio de Fisica I
INSERT INTO student_course (student_id, course_id) VALUES (10, 36); -- Santiago Ramirez + Quimica General
INSERT INTO student_course (student_id, course_id) VALUES (10, 39); -- Santiago Ramirez + Laboratorio de Quimica
INSERT INTO student_course (student_id, course_id) VALUES (11, 41); -- Isabella Castro + Biologia Celular
INSERT INTO student_course (student_id, course_id) VALUES (11, 43); -- Isabella Castro + Microbiologia
INSERT INTO student_course (student_id, course_id) VALUES (12, 46); -- Daniel Ortiz + Microeconomia
INSERT INTO student_course (student_id, course_id) VALUES (12, 49); -- Daniel Ortiz + Finanzas Corporativas
INSERT INTO student_course (student_id, course_id) VALUES (12, 30); -- Daniel Ortiz + Estadistica y Probabilidad (comparte curso con Juan Pablo Marin)
INSERT INTO student_course (student_id, course_id) VALUES (13, 6);  -- Maria Jose Gomez + Historia del Arte
INSERT INTO student_course (student_id, course_id) VALUES (13, 22); -- Maria Jose Gomez + Historia Universal
INSERT INTO student_course (student_id, course_id) VALUES (13, 25); -- Maria Jose Gomez + Etica y Sociedad
INSERT INTO student_course (student_id, course_id) VALUES (7, 6);   -- Laura Garcia (Arquitectura) + Historia del Arte
INSERT INTO student_course (student_id, course_id) VALUES (15, 5);  -- Camilo Restrepo + Derecho Penal
INSERT INTO student_course (student_id, course_id) VALUES (15, 6);  -- Camilo Restrepo + Historia del Arte
INSERT INTO student_course (student_id, course_id) VALUES (15, 13); -- Camilo Restrepo + Derecho Civil
INSERT INTO student_course (student_id, course_id) VALUES (15, 25); -- Camilo Restrepo + Etica y Sociedad
INSERT INTO student_course (student_id, course_id) VALUES (1, 51);  -- Laura Garcia (Sistemas) + Ingles Tecnico (electiva)
INSERT INTO student_course (student_id, course_id) VALUES (7, 51);  -- Laura Garcia (Arquitectura) + Ingles Tecnico
INSERT INTO student_course (student_id, course_id) VALUES (9, 51);  -- Valentina Ruiz + Ingles Tecnico
INSERT INTO student_course (student_id, course_id) VALUES (14, 51); -- Nicolas Vargas + Ingles Tecnico (electiva)
INSERT INTO student_course (student_id, course_id) VALUES (10, 51); -- Santiago Ramirez + Ingles Tecnico
INSERT INTO student_course (student_id, course_id) VALUES (1, 52);  -- Laura Garcia (Sistemas) + Seminario de Investigacion
INSERT INTO student_course (student_id, course_id) VALUES (3, 52);  -- Andres Lopez + Seminario de Investigacion
INSERT INTO student_course (student_id, course_id) VALUES (14, 52); -- Nicolas Vargas + Seminario de Investigacion
INSERT INTO student_course (student_id, course_id) VALUES (8, 53);  -- Juan Pablo Marin + Trabajo de Grado
INSERT INTO student_course (student_id, course_id) VALUES (14, 53); -- Nicolas Vargas + Trabajo de Grado

-- ─── ROL ADICIONAL (para navegacion anidada Role→Permission y User→Role) ────
INSERT INTO role (name) VALUES ('ROLE_PROFESSOR'); -- id 3
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 2);  -- READ_STUDENT
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 14); -- READ_COURSE
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 15); -- UPDATE_COURSE

-- ─── USUARIOS ADICIONALES CON ROL PROFESSOR ─────────────────────────────────
INSERT INTO app_user (username, password) VALUES ('diana', '{noop}prof123'); -- id 6
INSERT INTO app_user (username, password) VALUES ('luis',  '{noop}prof123'); -- id 7
INSERT INTO user_role (user_id, role_id) VALUES (6, 3); -- diana → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (7, 3); -- luis  → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (3, 3); -- ana ya es DIRECTOR; ahora tambien PROFESSOR (usuario con 2 roles)

-- ─── ROL ESTUDIANTE (id 4) ──────────────────────────────────────────────────
INSERT INTO role (name) VALUES ('ROLE_STUDENT'); -- id 4
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 6);  -- READ_PROFESSOR
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 14); -- READ_COURSE
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 9);  -- CREATE_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 10); -- READ_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 12); -- DELETE_ENROLLMENT

-- ─── PROFESOR: ademas puede ver profesores e inscripciones ──────────────────
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 6);  -- READ_PROFESSOR
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 10); -- READ_ENROLLMENT

-- ─── USUARIOS ADICIONALES (misma contraseña bcrypt que los primeros) ────────
INSERT INTO app_user (username, password) VALUES ('jperez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 8,  profesor
INSERT INTO app_user (username, password) VALUES ('mrodriguez', '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 9,  profesor
INSERT INTO app_user (username, password) VALUES ('amartinez',  '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 10, profesor
INSERT INTO app_user (username, password) VALUES ('lgarcia',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 11, estudiante
INSERT INTO app_user (username, password) VALUES ('ppascal',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 12, estudiante
INSERT INTO app_user (username, password) VALUES ('alopez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 13, estudiante
INSERT INTO app_user (username, password) VALUES ('storres',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 14, estudiante
INSERT INTO app_user (username, password) VALUES ('cvelez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 15, estudiante
INSERT INTO app_user (username, password) VALUES ('mgomez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 16, profesor y estudiante
INSERT INTO app_user (username, password) VALUES ('rmoreno',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 17, director y profesor

INSERT INTO user_role (user_id, role_id) VALUES (8, 3);  -- jperez     → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (9, 3);  -- mrodriguez → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (10, 3); -- amartinez  → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (11, 4); -- lgarcia    → STUDENT
INSERT INTO user_role (user_id, role_id) VALUES (12, 4); -- ppascal    → STUDENT
INSERT INTO user_role (user_id, role_id) VALUES (13, 4); -- alopez     → STUDENT
INSERT INTO user_role (user_id, role_id) VALUES (14, 4); -- storres    → STUDENT
INSERT INTO user_role (user_id, role_id) VALUES (15, 4); -- cvelez     → STUDENT
INSERT INTO user_role (user_id, role_id) VALUES (16, 3); -- mgomez     → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (16, 4); -- mgomez     → STUDENT
INSERT INTO user_role (user_id, role_id) VALUES (17, 2); -- rmoreno    → DIRECTOR
INSERT INTO user_role (user_id, role_id) VALUES (17, 3); -- rmoreno    → PROFESSOR
