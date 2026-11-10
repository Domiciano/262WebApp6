# Pruebas de /courses. Las corre test.sh, que define check,
# status, body, has y los tokens.

ESTUDIANTE=$(login lgarcia 123456)
PROF=e03cac11-7600-484f-9273-9d9a40719055
NONE=00000000-0000-0000-0000-000000000000

check "GET /courses · admin" 200 "$(status GET /courses "$ADMIN")"
check "GET /courses · director" 200 "$(status GET /courses "$DIRECTOR")"
check "GET /courses · sin token" 401 "$(status GET /courses)"
check "GET /courses · token alterado" 401 "$(status GET /courses "$ALTERADO")"

LIST=$(body GET /courses "$ADMIN")
check "GET /courses · trae publicId" si "$(has "$LIST" '"publicId"')"
check "GET /courses · trae professorName" si "$(has "$LIST" '"professorName"')"
check "GET /courses · no trae el id" no "$(has "$LIST" '"id":')"

ID=$(echo "$LIST" | sed -E 's/.*"publicId":"([^"]+)".*/\1/')
check "GET /courses/{publicId} · existe" 200 \
  "$(status GET "/courses/$ID" "$ADMIN")"
check "GET /courses/{publicId} · sin token" 401 \
  "$(status GET "/courses/$ID")"
check "GET /courses/{publicId} · no existe" 404 \
  "$(status GET "/courses/$NONE" "$ADMIN")"

STAMP=$(date +%s)
NEW="{\"name\":\"Curso $STAMP\",\"credits\":3,\"professorPublicId\":\"$PROF\"}"
CREATED=$(curl -s -X POST "$BASE/courses" -H "Authorization: Bearer $ADMIN" \
  -H "Content-Type: application/json" -d "$NEW" -w '\n%{http_code}')
check "POST /courses · admin" 201 "$(echo "$CREATED" | tail -n 1)"
check "POST /courses · trae publicId" si "$(has "$CREATED" '"publicId"')"
check "POST /courses · no trae el id" no "$(has "$CREATED" '"id":')"
CID=$(echo "$CREATED" | head -n 1 | sed -E 's/.*"publicId":"([^"]+)".*/\1/')

check "POST /courses · nombre repetido" 409 \
  "$(status POST /courses "$ADMIN" "$NEW")"
NO_AUTH="{\"name\":\"Curso B $STAMP\",\"credits\":3}"
check "POST /courses · sin token" 401 \
  "$(status POST /courses "" "$NO_AUTH")"
OTHER="{\"name\":\"Curso C $STAMP\",\"credits\":3,\"professorPublicId\":\"$PROF\"}"
check "POST /courses · sin permiso" 403 \
  "$(status POST /courses "$DIRECTOR" "$OTHER")"
check "POST /courses · JSON mal formado" 400 \
  "$(status POST /courses "$ADMIN" '{"name":')"
NO_NAME="{\"credits\":3,\"professorPublicId\":\"$PROF\"}"
check "POST /courses · sin nombre" 400 \
  "$(status POST /courses "$ADMIN" "$NO_NAME")"

PUT="{\"name\":\"Curso PUT $STAMP\",\"credits\":4,\"professorPublicId\":\"$PROF\"}"
check "PUT /courses/{publicId} · admin" 200 \
  "$(status PUT "/courses/$CID" "$ADMIN" "$PUT")"
check "PUT /courses/{publicId} · sin token" 401 \
  "$(status PUT "/courses/$CID" "" "$PUT")"
check "PUT /courses/{publicId} · sin permiso" 403 \
  "$(status PUT "/courses/$CID" "$ESTUDIANTE" "$PUT")"
check "PUT /courses/{publicId} · no existe" 404 \
  "$(status PUT "/courses/$NONE" "$ADMIN" "$PUT")"
check "PUT /courses/{publicId} · JSON mal formado" 400 \
  "$(status PUT "/courses/$CID" "$ADMIN" '{"name":')"

check "PATCH /courses/{publicId} · admin" 200 \
  "$(status PATCH "/courses/$CID" "$ADMIN" '{"credits":5}')"
check "PATCH /courses/{publicId} · conserva el nombre" si \
  "$(has "$(body GET "/courses/$CID" "$ADMIN")" "Curso PUT $STAMP")"
check "PATCH /courses/{publicId} · sin token" 401 \
  "$(status PATCH "/courses/$CID" "" '{"credits":5}')"
check "PATCH /courses/{publicId} · sin permiso" 403 \
  "$(status PATCH "/courses/$CID" "$ESTUDIANTE" '{"credits":5}')"
check "PATCH /courses/{publicId} · no existe" 404 \
  "$(status PATCH "/courses/$NONE" "$ADMIN" '{"credits":5}')"

check "DELETE /courses/{publicId} · sin token" 401 \
  "$(status DELETE "/courses/$CID")"
check "DELETE /courses/{publicId} · sin permiso" 403 \
  "$(status DELETE "/courses/$CID" "$DIRECTOR")"
check "DELETE /courses/{publicId} · admin" 204 \
  "$(status DELETE "/courses/$CID" "$ADMIN")"
check "DELETE /courses/{publicId} · no existe" 404 \
  "$(status DELETE "/courses/$CID" "$ADMIN")"
