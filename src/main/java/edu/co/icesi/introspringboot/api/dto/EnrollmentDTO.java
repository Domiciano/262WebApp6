package edu.co.icesi.introspringboot.api.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EnrollmentDTO {
    private String studentPublicId;
    private String studentName;
    private String coursePublicId;
    private String courseName;
}
