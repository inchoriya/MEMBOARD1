package com.icia.mbp.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.mbp.dao.BDAO;
import com.icia.mbp.dto.BOARD;
import com.icia.mbp.dto.PAGING;

@Service
public class BService {

	private ModelAndView mav;

	@Autowired
	private BDAO bdao;

	@Autowired
	private HttpServletRequest request;

	@Autowired
	private HttpSession session;

	public ModelAndView bWrite(BOARD board) {
		System.out.println("[2] controller → service : " + board);

		mav = new ModelAndView();

		// (1) 경로 설정 : fileUpload 폴더 생성 후 진행
		String savePath = request.getServletContext().getRealPath("src\\main\\webapp\\resources\\fileUpload\\")
				.replace(".metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\", "");

		MultipartFile bFile = board.getBFile();
		String bFileName = null;

		if (!bFile.isEmpty()) { // 파일이 비어있지 않을 경우 (파일이 존재할 경우)
			// (2) 식별자 UUID
			String uuid = UUID.randomUUID().toString().substring(0, 8);

			// (3) 파일 원본 이름
			String fileName = bFile.getOriginalFilename();

			// (2) + (3)
			bFileName = uuid + "_" + fileName;
			board.setBFileName(bFileName);
		}

		try {

			bdao.bWrite(board);
			System.out.println("[4] dao → service : 게시글 등록 성공!");

			// (4) 업로드는 게시글 작성이 성공했을 경우에 실행!!
			if (!bFile.isEmpty()) {
				bFile.transferTo(new File(savePath + bFileName));
			}

			// 목록 보기 만든 후 bList로 이동
			mav.setViewName("index");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("[4] dao → service : 게시글 등록 실패!");
			mav.setViewName("board/write");
		}

		return mav;
	}

	public ModelAndView bList(int page, int limit) {
		System.out.println("[2] controller → service : " + page);
		mav = new ModelAndView();

		// (1) 한 화면에 보여줄 페이지 번호 갯수
		int block = 5;

		int count = bdao.bCount();

		// 최대페이지 : 4
		int maxPage = (int) (Math.ceil((double) count / limit));

		if (page > maxPage) {
			if (maxPage == 0) {
				maxPage = 1;
			}
			page = maxPage;
		}

		// 시작 행 : 1 6 11
		int startRow = (page - 1) * limit + 1;

		// 끝나는 행 : 5 10 15
		int endRow = page * limit;

		// 시작하는 페이지
		int startPage = (((int) (Math.ceil((double) page / block))) - 1) * block + 1;

		// 끝나는 페이지
		int endPage = startPage + block - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}

		// 페이징 객체 생성
		PAGING paging = new PAGING();

		paging.setPage(page);
		paging.setStartRow(startRow);
		paging.setEndRow(endRow);
		paging.setMaxPage(maxPage);
		paging.setStartPage(startPage);
		paging.setEndPage(endPage);
		paging.setLimit(limit);

		List<BOARD> boardList = bdao.bList();

		mav.addObject("boardList", boardList);
		mav.addObject("paging", paging);
		mav.addObject("count", count);

		mav.setViewName("board/list");

		System.out.println("[2] dao → service : " + page);
		return mav;

	}

	public ModelAndView bView(int bNum, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("[2] controller → service => bNum : " + bNum);
		mav = new ModelAndView();

		// 로그인 아이디 확인하기
		String loginId = (String) session.getAttribute("loginId");
		System.out.println("로그인 아이디 확인 : " + loginId);

		// 쿠키를 사용하기 위해서
		// request와 response 필요!

		// 쿠기(타입) 객체(배열) 생성
		Cookie[] cookies = request.getCookies();

		// 비교를 위한 새로운 쿠키
		Cookie viewCookie = null;

		// 쿠키가 있을 경우
		if (cookies != null && cookies.length > 0) {

//			for(int i = 0; i<cookies.length; i++) {
//				
//				// Cookie의 name이 'cookie' + loginId + bNum과 일치하는 쿠키를 viewCookie에 넣어줌
//				if(cookies[i].getName().equals("|cookie|" + loginId + "|" + bNum + "|")) {
//					// |cookie|icia|3|
//					// |cookie|로그인아이디|게시글번호|
//					viewCookie = cookies[i];
//				}				
//			}

			// cookies[i] 대신에 cookie로 사용
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("|cookie|" + loginId + "|" + bNum + "|")) {
					viewCookie = cookie;
				}
			}
		}

		// 만일 viewCookie가 null 경우 : 쿠키를 생성해서 조회수 증가 로직을 처리한다.
		if (viewCookie == null) {

			// 쿠키 생성(이름, 값) : |cookie|로그인아이디|게시글번호| , 로그인아이디|게시글번호|
			Cookie newCookie = new Cookie("|cookie|" + loginId + "|" + bNum + "|", loginId + "|" + bNum + "|");

			// 유효시간 설정 (초 * 분 * 시)
			// newCookie.setMaxAge(60 * 60 * 1);

			newCookie.setMaxAge(60 * 1); // 1분으로 설정

			response.addCookie(newCookie);

			// 쿠키를 증가 시키고 조회수 증가
			int result = bdao.bHit(bNum);

			if (result > 0) {
				System.out.println("조회수 증가");
			} else {
				System.out.println("조회수 증가 오류");
			}
		} else {
			System.out.println("cookie 있음");

			// 쿠키 값 확인
			String cookieValue = viewCookie.getValue();
			System.out.println("cookie 값 : " + cookieValue);
		}
		
		BOARD board = bdao.bView(bNum);
		System.out.println("[4] dao → service : " + board);
		
		mav.addObject("view", board);
		mav.setViewName("board/view");
		

		return mav;
	}

}
