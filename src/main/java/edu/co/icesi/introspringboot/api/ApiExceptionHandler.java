package edu.co.icesi.introspringboot.api;

import edu.co.icesi.introspringboot.api.exception.ConflictException;
import edu.co.icesi.introspringboot.api.exception.NotFoundException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice(basePackages = "edu.co.icesi.introspringboot.api")
public class ApiExceptionHandler {

    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<Map<String, String>> handleNotFound(NotFoundException ex) {
        return error(404, "Not Found", ex.getMessage());
    }

    @ExceptionHandler(ConflictException.class)
    public ResponseEntity<Map<String, String>> handleConflict(ConflictException ex) {
        return error(409, "Conflict", ex.getMessage());
    }

    //Campo único repetido (nombre de curso, código de estudiante)
    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<Map<String, String>> handleDataIntegrity(DataIntegrityViolationException ex) {
        return error(409, "Conflict", "A unique field is already in use");
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<Map<String, String>> handleUnreadable(HttpMessageNotReadableException ex) {
        return error(400, "Bad Request", "Malformed JSON");
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleInvalid(MethodArgumentNotValidException ex) {
        var field = ex.getBindingResult().getFieldError();
        String message = field == null ? "Invalid request" : field.getField() + " " + field.getDefaultMessage();
        return error(400, "Bad Request", message);
    }

    private ResponseEntity<Map<String, String>> error(int status, String error, String message) {
        return ResponseEntity.status(status).body(Map.of("error", error, "message", message));
    }
}
