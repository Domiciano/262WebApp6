package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.api.exception.NotFoundException;
import edu.co.icesi.introspringboot.api.exception.ConflictException;
import edu.co.icesi.introspringboot.api.dto.EnrollmentDTO;
import edu.co.icesi.introspringboot.api.dto.EnrollmentRequestDTO;
import edu.co.icesi.introspringboot.api.mapper.EnrollmentMapper;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Enrollment;
import edu.co.icesi.introspringboot.entity.Student;
import edu.co.icesi.introspringboot.entity.keys.StudentCourseId;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.repo.EnrollmentRepository;
import edu.co.icesi.introspringboot.repo.StudentRepository;
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
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private EnrollmentMapper enrollmentMapper;

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

    @Override
    @PreAuthorize("hasAuthority('READ_ENROLLMENT')")
    public List<EnrollmentDTO> getByStudentRest(String studentPublicId) {
        findStudentOrThrow(studentPublicId);
        return enrollmentRepository.findByStudent_PublicId(studentPublicId).stream()
                .map(enrollmentMapper::toDTO).toList();
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_ENROLLMENT')")
    public EnrollmentDTO createRest(String studentPublicId, EnrollmentRequestDTO dto) {
        Student student = findStudentOrThrow(studentPublicId);
        Course course = findCourseOrThrow(dto.getCoursePublicId());
        if (enrollmentRepository.existsByStudentAndCourse(student, course)) {
            throw new ConflictException("Student " + studentPublicId + " is already enrolled in " + dto.getCoursePublicId());
        }
        Enrollment enrollment = new Enrollment();
        enrollment.setId(new StudentCourseId());
        enrollment.setStudent(student);
        enrollment.setCourse(course);
        return enrollmentMapper.toDTO(enrollmentRepository.save(enrollment));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_ENROLLMENT')")
    public void deleteRest(String studentPublicId, String coursePublicId) {
        Student student = findStudentOrThrow(studentPublicId);
        Course course = findCourseOrThrow(coursePublicId);
        Enrollment enrollment = enrollmentRepository.findByStudentAndCourse(student, course)
                .orElseThrow(() -> new NotFoundException(
                        "Student " + studentPublicId + " is not enrolled in " + coursePublicId));
        enrollmentRepository.delete(enrollment);
    }

    private Student findStudentOrThrow(String publicId) {
        return studentRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Student with publicId " + publicId + " does not exist"));
    }

    private Course findCourseOrThrow(String publicId) {
        return courseRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Course with publicId " + publicId + " does not exist"));
    }
}
