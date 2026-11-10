package edu.co.icesi.introspringboot.api.mapper;

import edu.co.icesi.introspringboot.api.dto.ProfessorDTO;
import edu.co.icesi.introspringboot.api.dto.ProfessorRequestDTO;
import edu.co.icesi.introspringboot.entity.Professor;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface ProfessorMapper {
    ProfessorDTO toDTO(Professor professor);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "courses", ignore = true)
    Professor toEntity(ProfessorRequestDTO dto);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "publicId", ignore = true)
    @Mapping(target = "courses", ignore = true)
    void updateEntity(ProfessorRequestDTO dto, @MappingTarget Professor professor);
}
