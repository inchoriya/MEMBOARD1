package com.icia.membo.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

@Data
public class BoardDTO {
    private int BNum;
    private String BWriter;
    private String BTitle;
    private String BContent;
    private LocalDateTime BDate;
    private LocalDateTime BUpdateDate;
    private int BHit;
    private MultipartFile BFile;
    private String BFileName;

    public static BoardDTO toDTO(BoardEntity entity){
        BoardDTO dto = new BoardDTO();

        dto.setBNum(entity.getBNum());
        dto.setBTitle(entity.getBTitle());
        dto.setBContent(entity.getBContent());
        dto.setBDate(entity.getBDate());
        dto.setBUpdateDate(entity.getBUpdateDate());
        dto.setBHit(entity.getBHit());
        dto.setBFileName(entity.getBFileName());

        dto.setBWriter(entity.getMember().getMId());

        return dto;
    }
}











