package edu.co.icesi.introspringboot.integration.services;

import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Professor;
import edu.co.icesi.introspringboot.repo.CourseRepository;
import edu.co.icesi.introspringboot.repo.ProfessorRepository;
import edu.co.icesi.introspringboot.service.CourseService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class CourseServiceIntegrationTest {

    @Autowired
    private CourseService courseService;

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private ProfessorRepository professorRepository;

    private Course course;
    private Professor professor;

    @BeforeEach
    void setup() {
        professor = new Professor();
        professor.setName("Test Professor");
        professor.setPublicId(UUID.randomUUID().toString());
        professorRepository.save(professor);

        course = new Course();
        course.setCredits(3);
        course.setName("Test Course");
        course.setProfessor(professor);
        course.setPublicId(UUID.randomUUID().toString());
        courseRepository.save(course);
    }

    @Test
    @WithMockUser(authorities = "CREATE_COURSE")
    void createCourse_WhenValid_ReturnsSavedCourse(){
        //Arrange
        Course newCourse = new Course();
        newCourse.setCredits(3);
        newCourse.setName("New Test Course");
        newCourse.setProfessor(professor);
        //Act
        Course outputCourse = courseService.createCourse(newCourse);
        int courseSize = courseRepository.findAll().size();
        //Assert
        assertNotNull(outputCourse);
        assertNotNull(outputCourse.getId());
        assertNotNull(outputCourse.getPublicId());
        assertEquals(3, outputCourse.getCredits());
        assertEquals(2, courseSize);

    }

    @Test
    @WithMockUser(authorities = "CREATE_COURSE")
    void createCourse_WhenNameIsNull_ThrowsException(){
        //Arrange

        Course courseWithNameNull = new Course();
        courseWithNameNull.setCredits(3);
        courseWithNameNull.setProfessor(professor);
        //Act & Assert
        assertThrows(IllegalStateException.class, ()->{
            courseService.createCourse(courseWithNameNull);
        } );

    }

    @Test
    @WithMockUser(authorities = "DELETE_COURSE")
    void deleteRest_WhenCourseExists_DeletesAndReturnsDTO() {
        // Act
        CourseDTO deletedCourse = courseService.deleteRest(course.getPublicId());

        // Assert
        assertNotNull(deletedCourse);
        assertEquals(course.getPublicId(), deletedCourse.getPublicId());
        assertTrue(courseRepository.findByPublicId(course.getPublicId()).isEmpty());
    }

    @AfterEach
    void tearDown(){
        courseRepository.deleteAll();
        professorRepository.deleteAll();
    }

}
