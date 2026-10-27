-- Profesores
INSERT INTO professor (public_id, name) VALUES ('e03cac11-7600-484f-9273-9d9a40719055', 'Juan Perez');
INSERT INTO professor (public_id, name) VALUES ('c32bb47a-4179-494b-aa7b-7cf97ac35734', 'Maria Rodriguez');
INSERT INTO professor (public_id, name) VALUES ('808adb07-c845-4dac-a18b-0fcbfc7db372', 'Marlon Gomez');

-- Cursos
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('59c98002-5ad7-4353-8d72-5b2822efa09f', 'Introduccion a la Programacion', 4, 3);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('1e2499b9-2200-4eb3-a58d-d73d39672f02', 'Estructuras de Datos', 4, 1);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('7c5c4df3-e9ca-4994-8bd8-e50a879b9a5a', 'Anatomia Humana', 5, 3);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('0e5bfa55-c5e1-4e64-8b71-1344f43c4eda', 'Fisiologia', 5, 2);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('b29cdbc0-6e1c-4940-b5c3-00daae454445', 'Derecho Penal', 3, 3);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('b9a92c06-a31d-446e-930e-de8e645a92da', 'Historia del Arte', 3, 3);

-- Estudiantes
INSERT INTO student (public_id, name, code, program) VALUES ('0d82aa18-66f9-49e1-9404-038787f0738d', 'Laura Garcia', '2021102001', 'Ingenieria de Sistemas');
INSERT INTO student (public_id, name, code, program) VALUES ('9fa22e25-28bb-4da5-b92a-0797c78cd9a9', 'Pedro Pascal', '2021102002', 'Ingenieria de Sistemas');
INSERT INTO student (public_id, name, code, program) VALUES ('0971d1d4-b0f1-45ed-9084-97b9f918e95a', 'Andres Lopez', '2021102003', 'Medicina');
INSERT INTO student (public_id, name, code, program) VALUES ('ca4da152-edca-4a76-ac8d-9f24fffab749', 'Sofia Torres', '2021102004', 'Derecho');
INSERT INTO student (public_id, name, code, program) VALUES ('270f9632-bcfa-44cd-9cad-780968ed0a42', 'Camila Velez', '2021102005', 'Medicina');

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
INSERT INTO permission (public_id, name) VALUES ('335ae472-52f5-45d1-9673-377a7329e1f7', 'CREATE_STUDENT');    -- 1
INSERT INTO permission (public_id, name) VALUES ('1edac9be-febf-44fc-a324-2d0b5455b5b6', 'READ_STUDENT');      -- 2
INSERT INTO permission (public_id, name) VALUES ('0ed2f77e-a518-4e9e-baa2-5e1c8ce8b4b1', 'UPDATE_STUDENT');    -- 3
INSERT INTO permission (public_id, name) VALUES ('a671f1d1-4f81-43ab-918e-c4b79281bbcc', 'DELETE_STUDENT');    -- 4
INSERT INTO permission (public_id, name) VALUES ('d2888eb7-cdd6-4685-b0c2-52d0b94ec380', 'CREATE_PROFESSOR');  -- 5
INSERT INTO permission (public_id, name) VALUES ('a2cba821-59c1-43ed-8db2-a137e60ca6b0', 'READ_PROFESSOR');    -- 6
INSERT INTO permission (public_id, name) VALUES ('040a6bd0-08fe-415f-b20f-0b9f59a29106', 'UPDATE_PROFESSOR');  -- 7
INSERT INTO permission (public_id, name) VALUES ('d85f0e15-cf27-43a5-b657-7f2e851590db', 'DELETE_PROFESSOR');  -- 8
INSERT INTO permission (public_id, name) VALUES ('e2f227a5-179c-452e-8011-e87b6161d90f', 'CREATE_ENROLLMENT'); -- 9
INSERT INTO permission (public_id, name) VALUES ('5a2b5610-b796-4495-83a1-7eb624192135', 'READ_ENROLLMENT');   -- 10
INSERT INTO permission (public_id, name) VALUES ('ffb870d0-59b3-4a66-aef8-29ec75993d67', 'UPDATE_ENROLLMENT'); -- 11
INSERT INTO permission (public_id, name) VALUES ('5c697d6e-e20d-46f6-b3ac-915fea2bcc50', 'DELETE_ENROLLMENT'); -- 12
INSERT INTO permission (public_id, name) VALUES ('eece8c14-c4a7-44d4-aede-bc6a1cca2501', 'CREATE_COURSE');     -- 13
INSERT INTO permission (public_id, name) VALUES ('e6e5fc70-aa1e-4673-a863-d10da3d8ec86', 'READ_COURSE');       -- 14
INSERT INTO permission (public_id, name) VALUES ('eebdcf1c-4b9c-4578-85f6-685f25916f67', 'UPDATE_COURSE');     -- 15
INSERT INTO permission (public_id, name) VALUES ('7a73e398-79e0-4365-a0e5-e3de2456d6db', 'DELETE_COURSE');     -- 16
INSERT INTO permission (public_id, name) VALUES ('65130a2e-1576-47b9-bf4c-003762f3b33a', 'READ_USER');         -- 17
INSERT INTO permission (public_id, name) VALUES ('6f810dd7-5fd0-4f88-a768-1dc4d4c5ef15', 'DELETE_USER');       -- 18
INSERT INTO permission (public_id, name) VALUES ('1762e9db-0d3c-40e9-b15e-4ebf8784282e', 'CREATE_USER');       -- 19

-- ─── ROLES ───────────────────────────────────────────────────────────────────
INSERT INTO role (public_id, name) VALUES ('9c411ced-00c4-4f2f-8aa6-dfe31d77180f', 'ROLE_ADMIN');    -- 1
INSERT INTO role (public_id, name) VALUES ('6afa30cc-a37d-4bb6-925c-342976f854f8', 'ROLE_DIRECTOR'); -- 2

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
INSERT INTO app_user (public_id, username, password) VALUES ('05a65934-916d-40bd-b83d-4492b6d46fed', 'nicolas',  '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');    -- 1
INSERT INTO app_user (public_id, username, password) VALUES ('3232805e-61e3-445c-ad9b-140b9534a567', 'juanchoking',   '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');    -- 2
INSERT INTO app_user (public_id, username, password) VALUES ('dd9681b8-1cc7-4968-bfea-c632e2c570ff', 'barragan',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');      -- 3
INSERT INTO app_user (public_id, username, password) VALUES ('33f49542-ac19-42bd-9291-b86c6cffd7ec', 'granda',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');      -- 4
INSERT INTO app_user (public_id, username, password) VALUES ('0af93101-ca73-4e57-b967-59e673f363ac', 'martinez',   '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506');      -- 5

-- ─── ASIGNACIÓN DE ROLES ─────────────────────────────────────────────────────
INSERT INTO user_role (user_id, role_id) VALUES (1, 1); -- carlos  → ADMIN
INSERT INTO user_role (user_id, role_id) VALUES (2, 2); -- maria   → ADMIN
INSERT INTO user_role (user_id, role_id) VALUES (3, 2); -- ana     → DIRECTOR
INSERT INTO user_role (user_id, role_id) VALUES (4, 2); -- juan    → DIRECTOR
INSERT INTO user_role (user_id, role_id) VALUES (5, 2); -- sofia   → DIRECTOR

-- 7 Profesores adicionales (Juan Perez, Maria Rodriguez y Carlos Gomez ya existen, ids 1-3)
INSERT INTO professor (public_id, name) VALUES ('86f9035d-4b66-47a1-b27b-59fc58970e47', 'Ana Martinez');
INSERT INTO professor (public_id, name) VALUES ('a84141b9-7445-439d-964e-88f84b328916', 'Luis Hernandez');
INSERT INTO professor (public_id, name) VALUES ('f146ee89-6a78-4e01-97d5-4073d8abfad5', 'Pedro Sanchez');
INSERT INTO professor (public_id, name) VALUES ('071da1a0-612e-4817-853d-c70325c87093', 'Rosa Moreno');
INSERT INTO professor (public_id, name) VALUES ('f09d9472-a4e7-4c4e-b26f-c5aabf7a81ee', 'Jorge Castillo');
INSERT INTO professor (public_id, name) VALUES ('c67cee52-c852-47dc-b4ca-49cece93212d', 'Elena Vargas');
INSERT INTO professor (public_id, name) VALUES ('69fb5435-ecfb-48fb-85bc-861bebc28ba7', 'Miguel Torres');

-- 47 Cursos adicionales (todos con nombre distinto entre si y respecto a los 6 de arriba)
-- Juan Perez (Sistemas) — Introduccion a la Programacion y Estructuras de Datos ya existen (ids 1-2)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('0c63e84b-809f-4f0a-bc06-31e246798322', 'Algoritmos y Complejidad', 4, 1);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('ee827163-c109-43e7-9409-c6b026bad4d9', 'Base de Datos', 3, 1);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('33686842-624c-4703-8d7e-1561f5570c4f', 'Redes de Computadores', 3, 1);

-- Maria Rodriguez (Medicina) — Anatomia Humana y Fisiologia ya existen (ids 3-4)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('617d8428-fdad-49f8-895d-05b35951df8f', 'Bioquimica Medica', 4, 2);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('f1b79911-1812-4f09-9b61-4d44166b1d55', 'Farmacologia', 4, 2);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('38710310-97bb-4fd9-9df9-0b146025bd87', 'Patologia General', 5, 2);

-- Carlos Gomez (Derecho) — Derecho Penal ya existe (id 5)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('55b3db78-b1ea-4671-9a50-3ccce9571fe2', 'Derecho Civil', 3, 3);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('f79ec074-9d93-487a-80a1-d75931677cb0', 'Derecho Constitucional', 3, 3);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('043006ae-c6ed-4644-a3f5-6e8206f14fb7', 'Derecho Laboral', 3, 3);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('dbdb1ef3-0fae-4728-9ff9-bae5c254b33a', 'Derecho Internacional', 2, 3);

-- Ana Martinez (Arquitectura)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('35d67e36-3160-4e9c-acdc-1a9d5893be12', 'Dibujo Tecnico', 2, 4);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('bb792650-6053-49cb-b7bb-627a977208b4', 'Diseno Arquitectonico I', 4, 4);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('1634853e-70d5-4a44-aa19-e57f78a06cde', 'Diseno Arquitectonico II', 4, 4);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('607c1d5c-98ad-4f25-8636-c56fd6adb33c', 'Historia de la Arquitectura', 3, 4);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('2485f1c5-ced8-41ef-aadb-e30fd7f2d095', 'Materiales de Construccion', 3, 4);

-- Luis Hernandez (Historia y Arte) — 'Historia del Arte' ya existe (id 6), no se repite aqui
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('04b3a02e-f3ce-4546-9ca4-0de09860367f', 'Historia Universal', 3, 5);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('1a1f6892-ddc7-4a7a-8bbb-8fc05d538291', 'Historia de Colombia', 3, 5);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('f9b7697d-66f2-4b57-ab2c-69f8cd95767e', 'Filosofia Moderna', 2, 5);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('0bfcd266-8a04-471a-bf85-74b8d09a7ae6', 'Etica y Sociedad', 2, 5);

-- Pedro Sanchez (Matematicas)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('c40349a6-5bae-4454-af04-b1d0f3837446', 'Calculo Diferencial', 4, 6);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('3be36aee-80de-4966-94cf-c3d0313ca7ab', 'Calculo Integral', 4, 6);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('b48693cf-011d-4b5c-9133-d17d30ffdab7', 'Algebra Lineal', 4, 6);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('69103939-3d20-4462-8aa2-925a455cc279', 'Ecuaciones Diferenciales', 3, 6);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('481cd79c-796f-4bdd-907d-6c5d1f420b08', 'Estadistica y Probabilidad', 3, 6);

-- Rosa Moreno (Fisica)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('a222250a-c557-4dc2-946f-ccaf7a238ee9', 'Fisica Mecanica', 4, 7);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('0db20d72-466b-418f-bcef-71fa76bd9016', 'Fisica Electromagnetismo', 4, 7);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('435eba6e-89b3-4746-9fd3-ba1b12527009', 'Fisica Moderna', 3, 7);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('3c7099d5-e77e-492d-af10-565c8c960eb9', 'Laboratorio de Fisica I', 2, 7);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('03249714-73ef-46f0-8b0d-701d2b7dfaa8', 'Laboratorio de Fisica II', 2, 7);

-- Jorge Castillo (Quimica)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('f0907b55-3ff2-44c0-b744-b5c50233b4cc', 'Quimica General', 4, 8);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('09f3eb8f-b7c2-431c-920d-6ebe39602da7', 'Quimica Organica', 4, 8);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('15b8b483-42f3-42fe-9747-80f3ff338ed3', 'Quimica Analitica', 3, 8);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('b786ead4-7cbe-423b-ad33-b883a3b56636', 'Laboratorio de Quimica', 2, 8);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('56feb6b7-0556-4e3a-a38c-16ca33e8a8d0', 'Quimica Ambiental', 3, 8);

-- Elena Vargas (Biologia)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('6abbadf2-7b92-42b3-a3bd-bf5d991c996c', 'Biologia Celular', 4, 9);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('6b248da3-4546-4149-a754-f745be6bd2ff', 'Genetica', 4, 9);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('7b67859f-2ad6-4b67-b1b0-f553fcabc489', 'Microbiologia', 3, 9);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('1f9ecd68-6135-42e2-95f0-316c81920272', 'Ecologia', 3, 9);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('9ffaf505-75e7-4730-8421-9f92f744595b', 'Botanica', 3, 9);

-- Miguel Torres (Economia)
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('1e94452d-27a0-4e21-aa04-665da85a59e9', 'Microeconomia', 3, 10);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('22d63702-3af3-4bbe-8c26-34c0b3df4426', 'Macroeconomia', 3, 10);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('43f8defb-af2a-4b30-9670-da5431dda3e4', 'Economia Internacional', 3, 10);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('6cc4e778-5b5e-4fd4-bedd-a8e0b92e4ea3', 'Finanzas Corporativas', 4, 10);
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('0f0966d0-9ce2-417d-9a29-0cd0746a69db', 'Contabilidad General', 3, 10);

-- ─── PROFESOR SIN CURSOS ASIGNADOS (edge case: JOIN vacio / lista vacia) ─────
INSERT INTO professor (public_id, name) VALUES ('28001e7a-70d1-4cfa-994f-324cfa3dc2cf', 'Diana Ospina'); -- id 11

-- ─── CURSOS CON CREDITOS LIMITE (para Between/GreaterThan/LessThan) ─────────
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('26203808-2205-4aa8-8a2c-63e2a655af45', 'Ingles Tecnico', 2, 4);                -- id 51 (Ana Martinez), electiva abierta a varios programas
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('47f0dab4-36c3-4a5b-8beb-79a71df1f652', 'Seminario de Investigacion', 1, 1);    -- id 52
INSERT INTO course (public_id, name, credits, professor_id) VALUES ('ae8eeb6b-b38a-4cb8-9b30-8fa07e2f949e', 'Trabajo de Grado', 6, 2);              -- id 53

-- ─── ESTUDIANTES ADICIONALES ────────────────────────────────────────────────
INSERT INTO student (public_id, name, code, program) VALUES ('53f4db6b-0873-4b8d-b415-632014a40f5e', 'Mariana Perez', '2022102006', 'Ingenieria de Sistemas');     -- id 6, sin inscripciones (edge case)
INSERT INTO student (public_id, name, code, program) VALUES ('913d2bbb-6467-424f-a856-13b160d5ec10', 'Laura Garcia', '2023102007', 'Arquitectura');                -- id 7, mismo nombre que el id 1, distinto codigo/programa
INSERT INTO student (public_id, name, code, program) VALUES ('54166999-d4c1-465b-b68a-7a30e27b6ecf', 'Juan Pablo Marin', '2022102008', 'Matematicas');             -- id 8
INSERT INTO student (public_id, name, code, program) VALUES ('b52e0e3e-9c62-4cf3-850d-876bb0bcfaca', 'Valentina Ruiz', '2022102009', 'Fisica');                    -- id 9
INSERT INTO student (public_id, name, code, program) VALUES ('b8751a64-d658-449e-a18c-d14a1b6d5993', 'Santiago Ramirez', '2022102010', 'Quimica');                 -- id 10
INSERT INTO student (public_id, name, code, program) VALUES ('95213bee-76a1-4860-845a-6a1b8ecfd99c', 'Isabella Castro', '2023102011', 'Biologia');                 -- id 11
INSERT INTO student (public_id, name, code, program) VALUES ('827507f4-1398-4613-ae1f-d50248d1c35d', 'Daniel Ortiz', '2023102012', 'Economia');                    -- id 12
INSERT INTO student (public_id, name, code, program) VALUES ('ff9f86a4-f43b-47c4-8de1-5b551be42d96', 'MARIA JOSE Gomez', '2023102013', 'Historia del Arte');       -- id 13, mayusculas para ContainingIgnoreCase
INSERT INTO student (public_id, name, code, program) VALUES ('be636404-9ac8-449c-b2a7-c4ec836303b5', 'Nicolas Vargas', '2021102014', 'Ingenieria de Sistemas');    -- id 14, el mas inscrito
INSERT INTO student (public_id, name, code, program) VALUES ('48c40ab6-9f1b-4312-93ea-84c2672a736d', 'Camilo Restrepo', '2024102015', 'Derecho');                  -- id 15

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
INSERT INTO role (public_id, name) VALUES ('4b531bc2-c71c-4000-b387-01cf2a5ebe12', 'ROLE_PROFESSOR'); -- id 3
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 2);  -- READ_STUDENT
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 14); -- READ_COURSE
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 15); -- UPDATE_COURSE

-- ─── USUARIOS ADICIONALES CON ROL PROFESSOR ─────────────────────────────────
INSERT INTO app_user (public_id, username, password) VALUES ('e88594d3-1133-461e-bed0-d1423fe2009b', 'diana', '{noop}prof123'); -- id 6
INSERT INTO app_user (public_id, username, password) VALUES ('0df176e1-8f25-4e09-941d-a08488508d97', 'luis',  '{noop}prof123'); -- id 7
INSERT INTO user_role (user_id, role_id) VALUES (6, 3); -- diana → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (7, 3); -- luis  → PROFESSOR
INSERT INTO user_role (user_id, role_id) VALUES (3, 3); -- ana ya es DIRECTOR; ahora tambien PROFESSOR (usuario con 2 roles)

-- ─── ROL ESTUDIANTE (id 4) ──────────────────────────────────────────────────
INSERT INTO role (public_id, name) VALUES ('8ed16b9a-1a64-43a7-a6a4-ee92a58b9845', 'ROLE_STUDENT'); -- id 4
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 6);  -- READ_PROFESSOR
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 14); -- READ_COURSE
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 9);  -- CREATE_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 10); -- READ_ENROLLMENT
INSERT INTO role_permission (role_id, permission_id) VALUES (4, 12); -- DELETE_ENROLLMENT

-- ─── PROFESOR: ademas puede ver profesores e inscripciones ──────────────────
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 6);  -- READ_PROFESSOR
INSERT INTO role_permission (role_id, permission_id) VALUES (3, 10); -- READ_ENROLLMENT

-- ─── USUARIOS ADICIONALES (misma contraseña bcrypt que los primeros) ────────
INSERT INTO app_user (public_id, username, password) VALUES ('5660f8ce-2919-4b85-af79-63c2ad600eb4', 'jperez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 8,  profesor
INSERT INTO app_user (public_id, username, password) VALUES ('a947461f-0236-43ea-858b-ea4c87882dd9', 'mrodriguez', '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 9,  profesor
INSERT INTO app_user (public_id, username, password) VALUES ('a430824c-09a4-403c-a478-234af866aa86', 'amartinez',  '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 10, profesor
INSERT INTO app_user (public_id, username, password) VALUES ('b85c8fbd-c573-416d-914a-ff2477424662', 'lgarcia',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 11, estudiante
INSERT INTO app_user (public_id, username, password) VALUES ('00ff5f42-82bf-4e59-a37b-56d23713124d', 'ppascal',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 12, estudiante
INSERT INTO app_user (public_id, username, password) VALUES ('d8ed5d44-c090-43d2-ad0b-e2686989f378', 'alopez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 13, estudiante
INSERT INTO app_user (public_id, username, password) VALUES ('cbb99f4a-a63f-4adb-a800-307469df2e42', 'storres',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 14, estudiante
INSERT INTO app_user (public_id, username, password) VALUES ('12c271a1-0dd5-4fdf-9b93-120d865d0c4e', 'cvelez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 15, estudiante
INSERT INTO app_user (public_id, username, password) VALUES ('c749220a-2ebf-4db0-949a-c4b4df7da9bf', 'mgomez',     '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 16, profesor y estudiante
INSERT INTO app_user (public_id, username, password) VALUES ('2b0f51af-71ea-447c-85d9-2aae14634e9e', 'rmoreno',    '$2a$12$LE5wWF2zJKLfE98E4KgJPO.buVfS0xHlSg2F2ciQMnk5kdgEBx506'); -- id 17, director y profesor

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
