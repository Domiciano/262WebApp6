package edu.co.icesi.introspringboot.api;

import jakarta.validation.Valid;
import edu.co.icesi.introspringboot.api.dto.ProfessorDTO;
import edu.co.icesi.introspringboot.api.dto.ProfessorRequestDTO;
import edu.co.icesi.introspringboot.service.ProfessorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/professors")
public class ProfessorRestController {

    @Autowired
    private ProfessorService professorService;

    @GetMapping
    public ResponseEntity<List<ProfessorDTO>> getProfessors() {
        return ResponseEntity.status(200).body(professorService.getAllRest());
    }

    @GetMapping("/{publicId}")
    public ResponseEntity<ProfessorDTO> getProfessor(@PathVariable("publicId") String publicId) {
        return ResponseEntity.status(200).body(professorService.getByPublicIdRest(publicId));
    }

    @PostMapping
    public ResponseEntity<ProfessorDTO> createProfessor(@Valid @RequestBody ProfessorRequestDTO dto) {
        return ResponseEntity.status(201).body(professorService.createRest(dto));
    }

    @PutMapping("/{publicId}")
    public ResponseEntity<ProfessorDTO> updateProfessor(@PathVariable("publicId") String publicId,
                                                    @Valid @RequestBody ProfessorRequestDTO dto) {
        return ResponseEntity.status(200).body(professorService.updateRest(publicId, dto));
    }

    @DeleteMapping("/{publicId}")
    public ResponseEntity<Void> deleteProfessor(@PathVariable("publicId") String publicId) {
        professorService.deleteRest(publicId);
        return ResponseEntity.status(204).build();
    }
}
