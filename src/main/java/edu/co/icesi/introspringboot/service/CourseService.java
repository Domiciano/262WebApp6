package edu.co.icesi.introspringboot.service;

import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Professor;

import java.util.List;

public interface CourseService {

    void createCourseWithProfessor(Course course, Professor professor);

    void deleteCourse(Integer id);

    Course createCourse(Course course);

    List<Course> getAll();

    Course getById(Integer id);

    List<CourseDTO> getAllRest();
}
