package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.entity.Enrollment;
import edu.co.icesi.introspringboot.repo.EnrollmentRepository;
import edu.co.icesi.introspringboot.service.EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class EnrollmentServiceImpl implements EnrollmentService {

    @Autowired
    private EnrollmentRepository enrollmentRepository;

    @Override
    @PreAuthorize("hasAuthority('READ_ENROLLMENT')")
    public List<Enrollment> findAll() {
        return enrollmentRepository.findAll();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_ENROLLMENT')")
    public Optional<Enrollment> findById(Integer id) {
        return enrollmentRepository.findById(id);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAnyAuthority('CREATE_ENROLLMENT', 'UPDATE_ENROLLMENT')")
    public Enrollment save(Enrollment enrollment) {
        return enrollmentRepository.save(enrollment);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_ENROLLMENT')")
    public void deleteById(Integer id) {
        enrollmentRepository.deleteById(id);
    }
}
