package com.icia.mbp.dto;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BOARD {

	private int bNum;				// 글번호
	private String bWriter;			// 작성자
	private String bTitle;			// 제목
	private String bContent;		// 내용
	private Date bDate;				// 작성일
	private int bHit;				// 조회수
	
	private MultipartFile bFile;	// 업로드 파일
	private String bFileName;		// 업로드 파일이름
	
}
