package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.api.exception.NotFoundException;
import edu.co.icesi.introspringboot.api.exception.ConflictException;
import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.api.dto.CourseRequestDTO;
import edu.co.icesi.introspringboot.api.mapper.CourseMapper;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Professor;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.repo.EnrollmentRepository;
import edu.co.icesi.introspringboot.repo.ProfessorRepository;
import edu.co.icesi.introspringboot.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private ProfessorRepository professorRepository;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private CourseMapper courseMapper;


    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_COURSE') and hasAuthority('CREATE_PROFESSOR')")
    public void createCourseWithProfessor(
            Course course,
            Professor professor
    ) {
        if(professor.getPublicId() == null) {
            professor.setPublicId(UUID.randomUUID().toString());
        }
        professorRepository.save(professor);
        course.setPublicId(UUID.randomUUID().toString());
        courseRepository.save(course);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_COURSE')")
    public void deleteCourse(Integer id) {
        courseRepository.deleteById(id);
        //Eliminar los enrollments asociados
        enrollmentRepository.deleteByCourse_Id(id);
    }

    @Override
    @PreAuthorize("hasAuthority('CREATE_COURSE')")
    public Course createCourse(Course course) {
        if(courseRepository.existsByName(course.getName())) {
            throw new IllegalArgumentException("Course with name " + course.getName() + " already exists");
        }
        else if(professorRepository.findById(course.getProfessor().getId()).isEmpty()) {
            throw new IllegalStateException("Professor with id " + course.getProfessor().getId() + " does not exist");
        }
        else if(course.getName() == null){
            throw new IllegalStateException("Course name is null");
        }else {
            course.setPublicId(UUID.randomUUID().toString());
            Course savedCourse = courseRepository.save(course);
            return savedCourse;
        }
    }

    @Override
    @PreAuthorize("hasAuthority('READ_COURSE')")
    public List<Course> getAll() {
        return courseRepository.findAll();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_COURSE')")
    public List<CourseDTO> getAllRest() {
        List<Course> courses = courseRepository.findAll();
        //List<CourseDTO> coursesDTO = courses.stream().map(courseMapper::toDTO).toList();
        List<CourseDTO> coursesDTO = courses.stream().map(
                entity -> courseMapper.toDTO(entity)
        ).toList();
        return coursesDTO;
    }

    @Override
    @PreAuthorize("hasAuthority('READ_COURSE')")
    public Course getById(Integer id) {
        Optional<Course> course = courseRepository.findById(id);
        if(course.isPresent()) {
            return course.get();
        }else{
            throw new RuntimeException("Course with id " + id + " does not exist");
        }
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_COURSE')")
    public CourseDTO createRest(CourseRequestDTO dto) {
        if (courseRepository.existsByName(dto.getName())) {
            throw new ConflictException("Course with name " + dto.getName() + " already exists");
        }
        Professor professor = findProfessorOrThrow(dto.getProfessorPublicId());
        Course course = courseMapper.toEntity(dto);
        course.setProfessor(professor);
        course.setPublicId(UUID.randomUUID().toString());
        Course savedCourse = courseRepository.save(course);
        return courseMapper.toDTO(savedCourse);
    }

    @Override
    @PreAuthorize("hasAuthority('READ_COURSE')")
    public CourseDTO getByPublicIdRest(String publicId) {
        return courseMapper.toDTO(findByPublicIdOrThrow(publicId));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('UPDATE_COURSE')")
    public CourseDTO updateRest(String publicId, CourseRequestDTO dto) {
        Course course = findByPublicIdOrThrow(publicId);
        courseMapper.updateEntity(dto, course);
        course.setProfessor(findProfessorOrThrow(dto.getProfessorPublicId()));
        return courseMapper.toDTO(courseRepository.saveAndFlush(course));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('UPDATE_COURSE')")
    public CourseDTO patchRest(String publicId, CourseRequestDTO dto) {
        Course course = findByPublicIdOrThrow(publicId);
        courseMapper.patchEntity(dto, course);
        if (dto.getProfessorPublicId() != null) {
            course.setProfessor(findProfessorOrThrow(dto.getProfessorPublicId()));
        }
        return courseMapper.toDTO(courseRepository.saveAndFlush(course));
    }

    private Course findByPublicIdOrThrow(String publicId) {
        return courseRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Course with publicId " + publicId + " does not exist"));
    }

    private Professor findProfessorOrThrow(String professorPublicId) {
        return professorRepository
                .findByPublicId(professorPublicId)
                .orElseThrow(() -> new NotFoundException(
                        "Professor " + professorPublicId + " does not exist"));
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_COURSE')")
    public CourseDTO deleteRest(String publicId) {
        Course course = courseRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Course with publicId " + publicId + " does not exist"));
        CourseDTO dto = courseMapper.toDTO(course);
        enrollmentRepository.deleteByCourse_Id(course.getId());
        courseRepository.delete(course);
        return dto;
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_COURSE')")
    public void deleteCourseByPublicId(String publicId) {
        Course course = courseRepository.findByPublicId(publicId)
                .orElseThrow(() -> new NotFoundException("Course with publicId " + publicId + " does not exist"));
        enrollmentRepository.deleteByCourse_Id(course.getId());
        courseRepository.delete(course);
    }

}
