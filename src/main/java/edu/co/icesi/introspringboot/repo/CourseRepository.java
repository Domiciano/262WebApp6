package edu.co.icesi.introspringboot.repo;

import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Professor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseRepository extends JpaRepository<Course, Integer> {
    List<Course> findByCreditsEquals(int credits);

    List<Course> findByProfessor_Name(String name);

    boolean existsByName(String name);

    Optional<Course> findByName(String name);

    Optional<Course> findByPublicId(String publicId);
}
