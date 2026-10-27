package edu.co.icesi.introspringboot.api.mapper;

import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.api.dto.CourseRequest;
import edu.co.icesi.introspringboot.entity.Course;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CourseMapper {
    @Mapping(source = "professor.name", target = "professorName")
    CourseDTO toDTO(Course course);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "professor", ignore = true)
    @Mapping(target = "enrollments", ignore = true)
    Course toEntity(CourseRequest dto);
}
