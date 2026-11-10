package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.api.exception.NotFoundException;
import edu.co.icesi.introspringboot.api.exception.ConflictException;
import edu.co.icesi.introspringboot.api.dto.ProfessorDTO;
import edu.co.icesi.introspringboot.api.dto.ProfessorRequestDTO;
import edu.co.icesi.introspringboot.api.mapper.ProfessorMapper;
import edu.co.icesi.introspringboot.entity.Professor;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.repo.ProfessorRepository;
import edu.co.icesi.introspringboot.service.ProfessorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ProfessorServiceImpl implements ProfessorService {

    @Autowired
    private ProfessorRepository professorRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private ProfessorMapper professorMapper;

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('UPDATE_PROFESSOR')")
    public void renameProfessor(Integer id, String name) {
        Optional<Professor> opProfessor = professorRepository.findById(id);
        if(opProfessor.isPresent()){
            Professor professor = opProfessor.get();
            professor.setName(name);
        } else throw new RuntimeException("Professor with id " + id + " not found");

    }

    @Override
    @PreAuthorize("hasAnyAuthority('CREATE_PROFESSOR', 'UPDATE_PROFESSOR')")
    public void save(Professor professor) {
        if(professor.getPublicId() == null) {
            professor.setPublicId(UUID.randomUUID().toString());
        }
        professorRepository.save(professor);
    }

    @Override
    @PreAuthorize("hasAuthority('READ_PROFESSOR')")
    public List<Professor> getAll() {
        return professorRepository.findAll();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_PROFESSOR')")
    public List<ProfessorDTO> getAllRest() {
        return professorRepository.findAll().stream().map(professorMapper::toDTO).toList();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_PROFESSOR')")
    public ProfessorDTO getByPublicIdRest(String publicId) {
        return professorMapper.toDTO(findByPublicIdOrThrow(publicId));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_PROFESSOR')")
    public ProfessorDTO createRest(ProfessorRequestDTO dto) {
        Professor professor = professorMapper.toEntity(dto);
        professor.setPublicId(UUID.randomUUID().toString());
        return professorMapper.toDTO(professorRepository.save(professor));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('UPDATE_PROFESSOR')")
    public ProfessorDTO updateRest(String publicId, ProfessorRequestDTO dto) {
        Professor professor = findByPublicIdOrThrow(publicId);
        professorMapper.updateEntity(dto, professor);
        return professorMapper.toDTO(professorRepository.save(professor));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_PROFESSOR')")
    public void deleteRest(String publicId) {
        Professor professor = findByPublicIdOrThrow(publicId);
        if (courseRepository.existsByProfessor_Id(professor.getId())) {
            throw new ConflictException("Professor " + publicId + " still has courses");
        }
        professorRepository.delete(professor);
    }

    private Professor findByPublicIdOrThrow(String publicId) {
        return professorRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Professor with publicId " + publicId + " does not exist"));
    }
}
