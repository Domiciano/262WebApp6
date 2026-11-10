package edu.co.icesi.introspringboot.api.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentDTO {
    private String publicId;
    private String name;
    private String code;
    private String program;
}
