# Pruebas de /auth y /health. Las corre test.sh, que define check,
# status, body, has y los tokens.

check "POST /auth/login · credenciales válidas" 200 \
  "$(status POST /auth/login "" '{"username":"nicolas","password":"123456"}')"
check "POST /auth/login · trae accessToken" si \
  "$(has "$(curl -s -X POST "$BASE/auth/login" -H "Content-Type: application/json" \
    -d '{"username":"nicolas","password":"123456"}')" '"accessToken"')"
check "POST /auth/login · contraseña equivocada" 401 \
  "$(status POST /auth/login "" '{"username":"nicolas","password":"malaclave"}')"
check "POST /auth/login · usuario que no existe" 401 \
  "$(status POST /auth/login "" '{"username":"nadie","password":"123456"}')"
check "POST /auth/login · JSON mal formado" 400 \
  "$(status POST /auth/login "" '{"username":')"

check "GET /health · sin token" 200 "$(status GET /health)"
check "GET /health · trae status" si "$(has "$(curl -s "$BASE/health")" '"status"')"
