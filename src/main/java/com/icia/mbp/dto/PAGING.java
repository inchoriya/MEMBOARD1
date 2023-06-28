package com.icia.mbp.dto;

import lombok.Data;

@Data
public class PAGING {
	private int page;		// 현재 페이지
	private int maxPage;	// 최대 페이지
	private int startPage;	// 시작 페이지
	private int endPage;	// 마지막 페이지
	private int startRow;	// 페이지에 표시될 게시글의 시작 행
	private int endRow;		// 페이지에 표시될 게시글의 마지막 행
	private int limit;		// 한 페이지에 출력할 게시글 갯수
}
