package edu.co.icesi.introspringboot.api.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseRequestDTO {
    @NotBlank
    private String name;
    private Integer credits;
    @NotBlank
    private String professorPublicId;
}
