package edu.co.icesi.introspringboot.api.mapper;

import edu.co.icesi.introspringboot.api.dto.EnrollmentDTO;
import edu.co.icesi.introspringboot.entity.Enrollment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface EnrollmentMapper {
    @Mapping(source = "student.publicId", target = "studentPublicId")
    @Mapping(source = "student.name", target = "studentName")
    @Mapping(source = "course.publicId", target = "coursePublicId")
    @Mapping(source = "course.name", target = "courseName")
    EnrollmentDTO toDTO(Enrollment enrollment);
}
