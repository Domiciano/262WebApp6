# Pruebas de /students/{studentPublicId}/enrollments. Las corre test.sh,
# que define check, status, body, has y los tokens.

PROFESOR=$(login jperez 123456)
LAURA=0d82aa18-66f9-49e1-9404-038787f0738d
COURSE=59c98002-5ad7-4353-8d72-5b2822efa09f
NONE=00000000-0000-0000-0000-000000000000
EP="GET /students/{studentPublicId}/enrollments"
PP="POST /students/{studentPublicId}/enrollments"
DP="DELETE /students/{studentPublicId}/enrollments/{coursePublicId}"

check "$EP · admin" 200 "$(status GET "/students/$LAURA/enrollments" "$ADMIN")"
check "$EP · director" 200 "$(status GET "/students/$LAURA/enrollments" "$DIRECTOR")"
check "$EP · sin token" 401 "$(status GET "/students/$LAURA/enrollments")"
check "$EP · token alterado" 401 \
  "$(status GET "/students/$LAURA/enrollments" "$ALTERADO")"
check "$EP · no existe" 404 "$(status GET "/students/$NONE/enrollments" "$ADMIN")"

LIST=$(body GET "/students/$LAURA/enrollments" "$ADMIN")
check "$EP · trae coursePublicId" si "$(has "$LIST" '"coursePublicId"')"
check "$EP · no trae el id" no "$(has "$LIST" '"id":')"

STAMP=$(date +%s)
STUDENT=$(curl -s -X POST "$BASE/students" -H "Authorization: Bearer $ADMIN" \
  -H "Content-Type: application/json" \
  -d "{\"name\":\"Inscrito $STAMP\",\"code\":\"E$STAMP\",\"program\":\"Medicina\"}")
SID=$(echo "$STUDENT" | sed -E 's/.*"publicId":"([^"]+)".*/\1/')
NEW="{\"coursePublicId\":\"$COURSE\"}"

check "$PP · sin token" 401 "$(status POST "/students/$SID/enrollments" "" "$NEW")"
check "$PP · sin permiso" 403 \
  "$(status POST "/students/$SID/enrollments" "$PROFESOR" "$NEW")"
CREATED=$(curl -s -X POST "$BASE/students/$SID/enrollments" \
  -H "Authorization: Bearer $DIRECTOR" -H "Content-Type: application/json" \
  -d "$NEW" -w '\n%{http_code}')
check "$PP · director" 201 "$(echo "$CREATED" | tail -n 1)"
check "$PP · trae coursePublicId" si "$(has "$CREATED" '"coursePublicId"')"
check "$PP · no trae el id" no "$(has "$CREATED" '"id":')"
check "$PP · inscripción repetida" 409 \
  "$(status POST "/students/$SID/enrollments" "$ADMIN" "$NEW")"
MISSING_COURSE="{\"coursePublicId\":\"$NONE\"}"
check "$PP · curso no existe" 404 \
  "$(status POST "/students/$SID/enrollments" "$ADMIN" "$MISSING_COURSE")"
check "$PP · estudiante no existe" 404 \
  "$(status POST "/students/$NONE/enrollments" "$ADMIN" "$NEW")"
check "$PP · JSON mal formado" 400 \
  "$(status POST "/students/$SID/enrollments" "$ADMIN" '{"coursePublicId":')"
check "$PP · sin curso" 400 "$(status POST "/students/$SID/enrollments" "$ADMIN" '{}')"

check "$DP · sin token" 401 "$(status DELETE "/students/$SID/enrollments/$COURSE")"
check "$DP · sin permiso" 403 \
  "$(status DELETE "/students/$SID/enrollments/$COURSE" "$PROFESOR")"
check "$DP · director" 204 \
  "$(status DELETE "/students/$SID/enrollments/$COURSE" "$DIRECTOR")"
check "$DP · no existe" 404 \
  "$(status DELETE "/students/$SID/enrollments/$COURSE" "$ADMIN")"

status DELETE "/students/$SID" "$ADMIN" > /dev/null
