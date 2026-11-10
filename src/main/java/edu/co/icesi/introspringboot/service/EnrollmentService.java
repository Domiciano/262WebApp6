package edu.co.icesi.introspringboot.service;

import edu.co.icesi.introspringboot.api.dto.EnrollmentDTO;
import edu.co.icesi.introspringboot.api.dto.EnrollmentRequestDTO;
import edu.co.icesi.introspringboot.entity.Enrollment;

import java.util.List;
import java.util.Optional;

public interface EnrollmentService {

    List<Enrollment> findAll();

    Optional<Enrollment> findById(Integer id);

    Enrollment save(Enrollment enrollment);

    void deleteById(Integer id);

    List<EnrollmentDTO> getByStudentRest(String studentPublicId);

    EnrollmentDTO createRest(String studentPublicId, EnrollmentRequestDTO dto);

    void deleteRest(String studentPublicId, String coursePublicId);
}
