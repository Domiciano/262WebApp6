package edu.co.icesi.introspringboot.service;

import edu.co.icesi.introspringboot.api.dto.ProfessorDTO;
import edu.co.icesi.introspringboot.api.dto.ProfessorRequestDTO;
import edu.co.icesi.introspringboot.entity.Professor;

import java.util.List;

public interface ProfessorService {

    void renameProfessor(Integer id, String name);

    void save(Professor professor);

    List<Professor> getAll();

    List<ProfessorDTO> getAllRest();

    ProfessorDTO getByPublicIdRest(String publicId);

    ProfessorDTO createRest(ProfessorRequestDTO dto);

    ProfessorDTO updateRest(String publicId, ProfessorRequestDTO dto);

    void deleteRest(String publicId);
}
