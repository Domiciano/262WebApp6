# Pruebas de /professors. Las corre test.sh, que define check,
# status, body, has y los tokens.

ESTUDIANTE=$(login lgarcia 123456)
WITH_COURSES=e03cac11-7600-484f-9273-9d9a40719055
NONE=00000000-0000-0000-0000-000000000000

check "GET /professors · admin" 200 "$(status GET /professors "$ADMIN")"
check "GET /professors · director" 200 "$(status GET /professors "$DIRECTOR")"
check "GET /professors · sin token" 401 "$(status GET /professors)"
check "GET /professors · token alterado" 401 "$(status GET /professors "$ALTERADO")"

LIST=$(body GET /professors "$ADMIN")
check "GET /professors · trae publicId" si "$(has "$LIST" '"publicId"')"
check "GET /professors · no trae el id" no "$(has "$LIST" '"id":')"

check "GET /professors/{publicId} · existe" 200 \
  "$(status GET "/professors/$WITH_COURSES" "$ADMIN")"
check "GET /professors/{publicId} · sin token" 401 \
  "$(status GET "/professors/$WITH_COURSES")"
check "GET /professors/{publicId} · no existe" 404 \
  "$(status GET "/professors/$NONE" "$ADMIN")"

STAMP=$(date +%s)
NEW="{\"name\":\"Profesor $STAMP\"}"
CREATED=$(curl -s -X POST "$BASE/professors" -H "Authorization: Bearer $ADMIN" \
  -H "Content-Type: application/json" -d "$NEW" -w '\n%{http_code}')
check "POST /professors · admin" 201 "$(echo "$CREATED" | tail -n 1)"
check "POST /professors · trae publicId" si "$(has "$CREATED" '"publicId"')"
check "POST /professors · no trae el id" no "$(has "$CREATED" '"id":')"
PID=$(echo "$CREATED" | head -n 1 | sed -E 's/.*"publicId":"([^"]+)".*/\1/')

check "POST /professors · sin token" 401 "$(status POST /professors "" "$NEW")"
OTHER="{\"name\":\"Profesor B $STAMP\"}"
check "POST /professors · sin permiso" 403 \
  "$(status POST /professors "$DIRECTOR" "$OTHER")"
check "POST /professors · JSON mal formado" 400 \
  "$(status POST /professors "$ADMIN" '{"name":')"
check "POST /professors · sin nombre" 400 "$(status POST /professors "$ADMIN" '{}')"

PUT="{\"name\":\"Profesor PUT $STAMP\"}"
check "PUT /professors/{publicId} · admin" 200 \
  "$(status PUT "/professors/$PID" "$ADMIN" "$PUT")"
check "PUT /professors/{publicId} · sin token" 401 \
  "$(status PUT "/professors/$PID" "" "$PUT")"
check "PUT /professors/{publicId} · sin permiso" 403 \
  "$(status PUT "/professors/$PID" "$DIRECTOR" "$PUT")"
check "PUT /professors/{publicId} · no existe" 404 \
  "$(status PUT "/professors/$NONE" "$ADMIN" "$PUT")"
check "PUT /professors/{publicId} · JSON mal formado" 400 \
  "$(status PUT "/professors/$PID" "$ADMIN" '{"name":')"

check "DELETE /professors/{publicId} · sin token" 401 \
  "$(status DELETE "/professors/$PID")"
check "DELETE /professors/{publicId} · sin permiso" 403 \
  "$(status DELETE "/professors/$PID" "$ESTUDIANTE")"
check "DELETE /professors/{publicId} · con cursos" 409 \
  "$(status DELETE "/professors/$WITH_COURSES" "$ADMIN")"
check "DELETE /professors/{publicId} · admin" 204 \
  "$(status DELETE "/professors/$PID" "$ADMIN")"
check "DELETE /professors/{publicId} · no existe" 404 \
  "$(status DELETE "/professors/$PID" "$ADMIN")"
