package edu.co.icesi.introspringboot.api.mapper;

import edu.co.icesi.introspringboot.api.dto.CourseDTO;
import edu.co.icesi.introspringboot.api.dto.CourseRequestDTO;
import edu.co.icesi.introspringboot.entity.Course;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring")
public interface CourseMapper {
    @Mapping(source = "professor.publicId", target = "professorPublicId")
    @Mapping(source = "professor.name", target = "professorName")
    CourseDTO toDTO(Course course);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "professor", ignore = true)
    @Mapping(target = "enrollments", ignore = true)
    Course toEntity(CourseRequestDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "professor", ignore = true)
    @Mapping(target = "enrollments", ignore = true)
    void updateEntity(CourseRequestDTO dto, @MappingTarget Course course);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "professor", ignore = true)
    @Mapping(target = "enrollments", ignore = true)
    void patchEntity(CourseRequestDTO dto, @MappingTarget Course course);
}
