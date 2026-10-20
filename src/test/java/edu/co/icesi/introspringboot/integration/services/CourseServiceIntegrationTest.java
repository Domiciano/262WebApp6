package edu.co.icesi.introspringboot.integration.services;

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
        professorRepository.save(professor);

        course = new Course();
        course.setCredits(3);
        course.setName("Test Course");
        course.setProfessor(professor);
        course.setPublicId(UUID.randomUUID().toString());
        courseRepository.save(course);
    }

    @Test
    void createCourse_WhenValid_ReturnsSavedCourse(){
        //Arrange
        // Se invoca solo
        //Act
        Course outputCourse = courseService.createCourse(course);
        int courseSize = courseRepository.findAll().size();
        //Assert
        assertNotNull(outputCourse);
        assertNotNull(outputCourse.getId());
        assertEquals(3, outputCourse.getCredits());
        assertEquals(1, courseSize);

    }

    @Test
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

    @AfterEach
    void tearDown(){
        courseRepository.deleteAll();
        professorRepository.deleteAll();
    }

}
