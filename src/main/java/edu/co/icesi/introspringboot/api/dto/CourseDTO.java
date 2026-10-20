package edu.co.icesi.introspringboot.api.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CourseDTO {
    private String publicId;
    private String name;
    private String professorName;
    private int credits;
}
