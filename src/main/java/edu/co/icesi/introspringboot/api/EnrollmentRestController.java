package edu.co.icesi.introspringboot.api;

import jakarta.validation.Valid;
import edu.co.icesi.introspringboot.api.dto.EnrollmentDTO;
import edu.co.icesi.introspringboot.api.dto.EnrollmentRequestDTO;
import edu.co.icesi.introspringboot.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/students/{studentPublicId}/enrollments")
public class EnrollmentRestController {

    @Autowired
    private EnrollmentService enrollmentService;

    @GetMapping
    public ResponseEntity<List<EnrollmentDTO>> getEnrollments(@PathVariable("studentPublicId") String studentPublicId) {
        return ResponseEntity.status(200).body(enrollmentService.getByStudentRest(studentPublicId));
    }

    @PostMapping
    public ResponseEntity<EnrollmentDTO> createEnrollment(@PathVariable("studentPublicId") String studentPublicId,
                                                          @Valid @RequestBody EnrollmentRequestDTO dto) {
        return ResponseEntity.status(201).body(enrollmentService.createRest(studentPublicId, dto));
    }

    @DeleteMapping("/{coursePublicId}")
    public ResponseEntity<Void> deleteEnrollment(@PathVariable("studentPublicId") String studentPublicId,
                                                 @PathVariable("coursePublicId") String coursePublicId) {
        enrollmentService.deleteRest(studentPublicId, coursePublicId);
        return ResponseEntity.status(204).build();
    }
}
