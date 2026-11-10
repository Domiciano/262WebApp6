package edu.co.icesi.introspringboot.repo;

import edu.co.icesi.introspringboot.entity.Course;
import edu.co.icesi.introspringboot.entity.Enrollment;
import edu.co.icesi.introspringboot.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Integer> {

    @Transactional
    void deleteByCourse_Id(Integer id);

    @Transactional
    void deleteByStudent_Id(Integer id);

    boolean existsByStudentAndCourse(Student student, Course course);

    Optional<Enrollment> findByStudentAndCourse(Student student, Course course);

    List<Enrollment> findByStudent_PublicId(String publicId);

}
