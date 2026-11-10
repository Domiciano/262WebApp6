package edu.co.icesi.introspringboot.api;

import jakarta.validation.Valid;
import edu.co.icesi.introspringboot.api.dto.StudentDTO;
import edu.co.icesi.introspringboot.api.dto.StudentRequestDTO;
import edu.co.icesi.introspringboot.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/students")
public class StudentRestController {

    @Autowired
    private StudentService studentService;

    @GetMapping
    public ResponseEntity<List<StudentDTO>> getStudents() {
        return ResponseEntity.status(200).body(studentService.getAllRest());
    }

    @GetMapping("/{publicId}")
    public ResponseEntity<StudentDTO> getStudent(@PathVariable("publicId") String publicId) {
        return ResponseEntity.status(200).body(studentService.getByPublicIdRest(publicId));
    }

    @PostMapping
    public ResponseEntity<StudentDTO> createStudent(@Valid @RequestBody StudentRequestDTO dto) {
        return ResponseEntity.status(201).body(studentService.createRest(dto));
    }

    @PutMapping("/{publicId}")
    public ResponseEntity<StudentDTO> updateStudent(@PathVariable("publicId") String publicId,
                                                    @Valid @RequestBody StudentRequestDTO dto) {
        return ResponseEntity.status(200).body(studentService.updateRest(publicId, dto));
    }

    @DeleteMapping("/{publicId}")
    public ResponseEntity<Void> deleteStudent(@PathVariable("publicId") String publicId) {
        studentService.deleteRest(publicId);
        return ResponseEntity.status(204).build();
    }
}
