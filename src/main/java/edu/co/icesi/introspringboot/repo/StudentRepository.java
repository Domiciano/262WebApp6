package edu.co.icesi.introspringboot.repo;


import edu.co.icesi.introspringboot.entity.Student;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {

    Optional<Student> findByCode(String code);

    Optional<Student> findByPublicId(String publicId);
    List<Student> findDistinctByStudentCourses_Course_Professor_Name(String name);

    List<Student> findByStudentCourses_Course_Name(String courseName);

    Page<Student> findAll(Pageable pageable);
}
