package edu.co.icesi.introspringboot.api.mapper;

import edu.co.icesi.introspringboot.api.dto.StudentDTO;
import edu.co.icesi.introspringboot.api.dto.StudentRequestDTO;
import edu.co.icesi.introspringboot.entity.Student;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface StudentMapper {
    StudentDTO toDTO(Student student);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "studentCourses", ignore = true)
    Student toEntity(StudentRequestDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "studentCourses", ignore = true)
    void updateEntity(StudentRequestDTO dto, @MappingTarget Student student);
}
