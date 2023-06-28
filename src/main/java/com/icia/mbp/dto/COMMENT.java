package com.icia.mbp.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class COMMENT {
	private int cNum;			// 댓글번호
	private int cbNum;			// 게시글 번호
	private String cWriter;		// 댓글 작성자
	private String cContent;	// 댓글 내용
	private Date cDate;			// 댓글 작성일
}
