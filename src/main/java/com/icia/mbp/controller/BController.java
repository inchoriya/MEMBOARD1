package com.icia.mbp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.mbp.dto.BOARD;
import com.icia.mbp.service.BService;

@Controller
public class BController {

	@Autowired
	private BService bsvc;

	private ModelAndView mav;

	// writeForm : 게시글 작성 페이지로 이동
	@RequestMapping(value = "writeForm", method = RequestMethod.GET)
	public String writeForm() {
		return "board/write";
	}

	// bWrite : 게시글 작성
	@RequestMapping(value = "bWrite", method = RequestMethod.POST)
	public ModelAndView bWrite(@ModelAttribute BOARD board) {
		System.out.println("[1] jsp → controller : " + board);

		mav = bsvc.bWrite(board);
		System.out.println("[5] service → controller : " + mav);

		return mav;
	}

	// bList : 게시글 목록
	@RequestMapping(value = "bList", method = RequestMethod.GET)
	public ModelAndView bList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
							  @RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {
		System.out.println("[1] jsp → controller => page : " + page + " , limit : " + 5);

		mav = bsvc.bList(page, limit);
		System.out.println("[5] service → controller : " + mav);

		return mav;
	}
	
	// bView : 게시글 상세보기
	@RequestMapping(value = "bView", method = RequestMethod.GET)
	public ModelAndView bView(@RequestParam("bNum") int bNum, 
							  HttpServletRequest request, HttpServletResponse response) {
		System.out.println("\n==================== 게시글 상세보기 ==========================");
		System.out.println("[1] jsp → controller => bNum : " + bNum);

		mav = bsvc.bView(bNum, request, response);
		System.out.println("[5] service → controller : " + mav + "\n");

		return mav;
	}

}











