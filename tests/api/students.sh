# Pruebas de /students. Las corre test.sh, que define check,
# status, body, has y los tokens.

ESTUDIANTE=$(login lgarcia 123456)
NONE=00000000-0000-0000-0000-000000000000

check "GET /students · admin" 200 "$(status GET /students "$ADMIN")"
check "GET /students · director" 200 "$(status GET /students "$DIRECTOR")"
check "GET /students · sin token" 401 "$(status GET /students)"
check "GET /students · token alterado" 401 "$(status GET /students "$ALTERADO")"
check "GET /students · sin permiso" 403 "$(status GET /students "$ESTUDIANTE")"

LIST=$(body GET /students "$ADMIN")
check "GET /students · trae publicId" si "$(has "$LIST" '"publicId"')"
check "GET /students · trae code" si "$(has "$LIST" '"code"')"
check "GET /students · no trae el id" no "$(has "$LIST" '"id":')"

ID=$(echo "$LIST" | sed -E 's/.*"publicId":"([^"]+)".*/\1/')
check "GET /students/{publicId} · existe" 200 \
  "$(status GET "/students/$ID" "$ADMIN")"
check "GET /students/{publicId} · sin token" 401 \
  "$(status GET "/students/$ID")"
check "GET /students/{publicId} · sin permiso" 403 \
  "$(status GET "/students/$ID" "$ESTUDIANTE")"
check "GET /students/{publicId} · no existe" 404 \
  "$(status GET "/students/$NONE" "$ADMIN")"

STAMP=$(date +%s)
NEW="{\"name\":\"Estudiante $STAMP\",\"code\":\"S$STAMP\",\"program\":\"Ingenieria de Sistemas\"}"
CREATED=$(curl -s -X POST "$BASE/students" -H "Authorization: Bearer $ADMIN" \
  -H "Content-Type: application/json" -d "$NEW" -w '\n%{http_code}')
check "POST /students · admin" 201 "$(echo "$CREATED" | tail -n 1)"
check "POST /students · trae publicId" si "$(has "$CREATED" '"publicId"')"
check "POST /students · no trae el id" no "$(has "$CREATED" '"id":')"
SID=$(echo "$CREATED" | head -n 1 | sed -E 's/.*"publicId":"([^"]+)".*/\1/')

check "POST /students · código repetido" 409 \
  "$(status POST /students "$ADMIN" "$NEW")"
check "POST /students · sin token" 401 "$(status POST /students "" "$NEW")"
OTHER="{\"name\":\"B $STAMP\",\"code\":\"B$STAMP\",\"program\":\"Medicina\"}"
check "POST /students · sin permiso" 403 \
  "$(status POST /students "$DIRECTOR" "$OTHER")"
check "POST /students · JSON mal formado" 400 \
  "$(status POST /students "$ADMIN" '{"name":')"
NO_CODE="{\"name\":\"C $STAMP\",\"program\":\"Medicina\"}"
check "POST /students · sin código" 400 \
  "$(status POST /students "$ADMIN" "$NO_CODE")"

PUT="{\"name\":\"Estudiante PUT $STAMP\",\"code\":\"S$STAMP\",\"program\":\"Medicina\"}"
check "PUT /students/{publicId} · admin" 200 \
  "$(status PUT "/students/$SID" "$ADMIN" "$PUT")"
check "PUT /students/{publicId} · sin token" 401 \
  "$(status PUT "/students/$SID" "" "$PUT")"
check "PUT /students/{publicId} · sin permiso" 403 \
  "$(status PUT "/students/$SID" "$DIRECTOR" "$PUT")"
check "PUT /students/{publicId} · no existe" 404 \
  "$(status PUT "/students/$NONE" "$ADMIN" "$PUT")"
check "PUT /students/{publicId} · código de otro" 409 \
  "$(status PUT "/students/$SID" "$ADMIN" '{"name":"X","code":"2021102001","program":"Medicina"}')"
check "PUT /students/{publicId} · JSON mal formado" 400 \
  "$(status PUT "/students/$SID" "$ADMIN" '{"name":')"

check "DELETE /students/{publicId} · sin token" 401 \
  "$(status DELETE "/students/$SID")"
check "DELETE /students/{publicId} · sin permiso" 403 \
  "$(status DELETE "/students/$SID" "$DIRECTOR")"
check "DELETE /students/{publicId} · admin" 204 \
  "$(status DELETE "/students/$SID" "$ADMIN")"
check "DELETE /students/{publicId} · no existe" 404 \
  "$(status DELETE "/students/$SID" "$ADMIN")"
