package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.entity.Professor;
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
}
