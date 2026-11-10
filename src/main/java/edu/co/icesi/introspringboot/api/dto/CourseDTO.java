package edu.co.icesi.introspringboot.api.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseDTO {
    private String publicId;
    private String name;
    private String professorPublicId;
    private String professorName;
    private int credits;
}
