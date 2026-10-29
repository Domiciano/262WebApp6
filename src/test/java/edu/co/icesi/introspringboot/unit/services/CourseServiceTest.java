package edu.co.icesi.introspringboot.unit.services;


import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.api.mapper.CourseMapper;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Professor;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.repo.EnrollmentRepository;
import edu.co.icesi.introspringboot.repo.ProfessorRepository;
import edu.co.icesi.introspringboot.service.CourseService;
import edu.co.icesi.introspringboot.service.impl.CourseServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class CourseServiceTest {

    @Mock
    private CourseRepository courseRepository;
    // Este objeto lo controla el ingeniero de testing
    @Mock
    private ProfessorRepository professorRepository;
    // Este objeto lo controla el ingeniero de testing
    @Mock
    private EnrollmentRepository enrollmentRepository;
    @Mock
    private CourseMapper courseMapper;

    @InjectMocks
    private CourseServiceImpl courseService;


    private Course course;
    private Professor professor;

    void scenario1(){
        professor = new Professor();
        professor.setId(1);
        professor.setName("Test Professor");

        course = new Course();
        course.setId(1);
        course.setProfessor(professor);
        course.setName("Test Course");
        course.setCredits(3);
    }


    @Test
    void createCourse_WhenIsValid_ReturnCourse() {
        //Arrange
        scenario1();

        when(courseRepository.existsByName("Test Course"))
                .thenReturn(false);
        when(professorRepository.findById(1))
                .thenReturn(
                    Optional.of(professor)
        );
        when(courseRepository.save(course)).thenReturn(course);

        //Act
        Course savedCourse = courseService.createCourse(course);
        //Assert
        assertNotNull(savedCourse);
    }

    @Test
    void getAll_WhenIsCalled_ReturnAllCourses() {
        //Arrange: simular el comportamiento del mock
        when(courseRepository.findAll())
            .thenReturn(Arrays.asList(
                    new Course(),
                    new Course(),
                    new Course()
            ));

        //Act
        List<Course> courses = courseService.getAll();
        //Assert
        assertEquals(3, courses.size());

    }

    @Test
    void deleteRest_WhenCourseExists_ReturnsCourseDTO() {
        // Arrange
        scenario1();
        String publicId = "test-public-id";
        course.setPublicId(publicId);

        CourseDTO expectedDTO = new CourseDTO();
        expectedDTO.setPublicId(publicId);
        expectedDTO.setName("Test Course");

        when(courseRepository.findByPublicId(publicId)).thenReturn(Optional.of(course));
        when(courseMapper.toDTO(course)).thenReturn(expectedDTO);

        // Act
        CourseDTO result = courseService.deleteRest(publicId);

        // Assert
        assertNotNull(result);
        assertEquals(publicId, result.getPublicId());
        verify(enrollmentRepository).deleteByCourse_Id(course.getId());
        verify(courseRepository).delete(course);
    }

}
