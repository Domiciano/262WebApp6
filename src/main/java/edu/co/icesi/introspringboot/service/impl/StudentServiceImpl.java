package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.api.exception.NotFoundException;
import edu.co.icesi.introspringboot.api.dto.StudentDTO;
import edu.co.icesi.introspringboot.api.dto.StudentRequestDTO;
import edu.co.icesi.introspringboot.api.mapper.StudentMapper;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Enrollment;
import edu.co.icesi.introspringboot.entity.Student;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.repo.EnrollmentRepository;
import edu.co.icesi.introspringboot.repo.StudentRepository;
import edu.co.icesi.introspringboot.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private StudentMapper studentMapper;

    @Override
    @PreAuthorize("hasAuthority('READ_STUDENT')")
    public List<Student> findAll() {
        return studentRepository.findAll();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_STUDENT')")
    public Optional<Student> findById(Integer id) {
        return studentRepository.findById(id);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAnyAuthority('CREATE_STUDENT', 'UPDATE_STUDENT')")
    public Student save(Student student) {
        if(student.getPublicId() == null) {
            student.setPublicId(UUID.randomUUID().toString());
        }
        return studentRepository.save(student);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_STUDENT')")
    public void deleteById(Integer id) {
        studentRepository.deleteById(id);
        enrollmentRepository.deleteByStudent_Id(id);
    }

    @Override
    @PreAuthorize("hasAuthority('READ_STUDENT')")
    public Student findStudentByCode(String code) {
        // TODO: si el código es nulo o vacío, lanzar IllegalArgumentException.
        // TODO: buscar el estudiante por código; si no existe, lanzar RuntimeException.
        return null;
    }

    @Override
    @PreAuthorize("hasAuthority('READ_STUDENT')")
    public List<Student> getStudentsByCourseName(String courseName) {
        // TODO: si el curso no existe, lanzar RuntimeException.
        // TODO: devolver los estudiantes inscritos en ese curso (puede ser una lista vacía).
        return null;
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_STUDENT')")
    public void deleteStudentByCode(String code) {
        // TODO: buscar el estudiante por código; si no existe, lanzar RuntimeException.
        // TODO: eliminarlo.
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_ENROLLMENT')")
    public Enrollment enrollStudentInCourse(String studentCode, String courseName) {
        // TODO: buscar el estudiante por código; si no existe, lanzar RuntimeException.
        // TODO: buscar el curso por nombre; si no existe, lanzar RuntimeException.
        // TODO: si ya existe la inscripción, lanzar IllegalStateException.
        // TODO: crear y guardar la nueva inscripción.
        return null;
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_ENROLLMENT')")
    public void unenrollStudentFromCourse(String studentCode, String courseName) {
        // TODO: buscar el estudiante por código; si no existe, lanzar RuntimeException.
        // TODO: buscar el curso por nombre; si no existe, lanzar RuntimeException.
        // TODO: buscar la inscripción; si no existe, lanzar IllegalStateException.
        // TODO: eliminarla.
    }

    @Override
    @PreAuthorize("hasAuthority('READ_STUDENT')")
    public List<StudentDTO> getAllRest() {
        return studentRepository.findAll().stream().map(studentMapper::toDTO).toList();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_STUDENT')")
    public StudentDTO getByPublicIdRest(String publicId) {
        return studentMapper.toDTO(findByPublicIdOrThrow(publicId));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_STUDENT')")
    public StudentDTO createRest(StudentRequestDTO dto) {
        Student student = studentMapper.toEntity(dto);
        student.setPublicId(UUID.randomUUID().toString());
        return studentMapper.toDTO(studentRepository.saveAndFlush(student));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('UPDATE_STUDENT')")
    public StudentDTO updateRest(String publicId, StudentRequestDTO dto) {
        Student student = findByPublicIdOrThrow(publicId);
        studentMapper.updateEntity(dto, student);
        return studentMapper.toDTO(studentRepository.saveAndFlush(student));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_STUDENT')")
    public void deleteRest(String publicId) {
        Student student = findByPublicIdOrThrow(publicId);
        enrollmentRepository.deleteByStudent_Id(student.getId());
        studentRepository.delete(student);
    }

    private Student findByPublicIdOrThrow(String publicId) {
        return studentRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Student with publicId " + publicId + " does not exist"));
    }
}
