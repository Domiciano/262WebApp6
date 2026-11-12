package edu.co.icesi.introspringboot.api;

import jakarta.validation.Valid;

import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.api.dto.CourseRequestDTO;
import edu.co.icesi.introspringboot.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/courses")
@CrossOrigin(maxAge = 3600)
public class CourseRestController {

    @Autowired
    private CourseService courseService;

    @GetMapping
    public ResponseEntity<List<CourseDTO>> getCourses() {
        var body = courseService.getAllRest();
        return ResponseEntity.status(200).body(body);
    }

    @GetMapping("/{publicId}")
    public ResponseEntity<CourseDTO> getCourse(@PathVariable("publicId") String publicId) {
        CourseDTO output = courseService.getByPublicIdRest(publicId);
        return ResponseEntity.status(200).body(output);
    }

    //Crear curso
    @PostMapping
    public ResponseEntity<CourseDTO> createCourse(@Valid @RequestBody CourseRequestDTO dto) {
        CourseDTO output = courseService.createRest(dto);
        return ResponseEntity.status(201).body(output);
    }

    //Reemplazar curso
    @PutMapping("/{publicId}")
    public ResponseEntity<CourseDTO> updateCourse(@PathVariable("publicId") String publicId,
                                                  @Valid @RequestBody CourseRequestDTO dto) {
        CourseDTO output = courseService.updateRest(publicId, dto);
        return ResponseEntity.status(200).body(output);
    }

    //Editar solo los campos enviados
    @PatchMapping("/{publicId}")
    public ResponseEntity<CourseDTO> patchCourse(@PathVariable("publicId") String publicId,
                                                 @RequestBody CourseRequestDTO dto) {
        CourseDTO output = courseService.patchRest(publicId, dto);
        return ResponseEntity.status(200).body(output);
    }

    //Eliminar un curso por publicId
    @DeleteMapping("/{publicId}")
    public ResponseEntity<Void> deleteCourse(@PathVariable("publicId") String publicId) {
        courseService.deleteRest(publicId);
        return ResponseEntity.status(204).build();
    }
}
