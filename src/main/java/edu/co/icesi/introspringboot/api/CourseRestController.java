package edu.co.icesi.introspringboot.api;


import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.api.dto.CourseRequest;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/api/v1/courses")
public class CourseRestController {

    @Autowired
    private CourseService courseService;

    @GetMapping
    public ResponseEntity<List<CourseDTO>> getCourses() {
        var body = courseService.getAllRest();
        return ResponseEntity.status(200).body(body);
    }

    //Crear curso
    @PostMapping
    public ResponseEntity<CourseDTO> createCourse(@RequestBody CourseRequest dto) {
        CourseDTO output = courseService.createRest(dto);
        return ResponseEntity.status(201).body(output);
    }

    //Reemplazar curso o crear
    @PutMapping
    public ResponseEntity<CourseDTO> updateCourse(@RequestBody CourseDTO dto) {
        throw new RuntimeException("Not implemented");
    }

    //Editar un campo
    @PatchMapping
    public ResponseEntity<CourseDTO> patchCourse(@RequestBody CourseDTO dto) {
        throw new RuntimeException("Not implemented");
    }

    //Eliminar un curso
    @DeleteMapping
    public ResponseEntity<CourseDTO> deleteCourse(@RequestBody CourseDTO dto) {
        throw new RuntimeException("Not implemented");
    }
}
