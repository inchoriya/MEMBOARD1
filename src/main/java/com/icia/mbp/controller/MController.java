package com.icia.mbp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.mbp.dto.MEMBER;
import com.icia.mbp.service.MService;

@Controller
public class MController {

	@Autowired
	private MService msvc;

	private ModelAndView mav;

	// 프로젝트 시작!
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		return "index";
	}

	// joinForm : 회원가입 페이지로 이동
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm() {
		return "member/join";
	}

	// mList1 : 목록 체크
	@RequestMapping(value = "/mList1", method = RequestMethod.GET)
	public String mList1() {
		return "member/list";
	}

	// mList4 : 목록 체크
	@RequestMapping(value = "/mList4", method = RequestMethod.GET)
	public String mList4() {
		return "member/list2";
	}

	// idCheck : 아이디 중복 체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	public @ResponseBody String idCheck(@RequestParam("mId") String mId) {
		// ResponseBody를 추가하면 return값이 jsp가 아닌 data로 반환된다.
		String result = msvc.idCheck(mId);
		return result;
	}

	// mCount : 회원수 체크
	@RequestMapping(value = "/mCount", method = RequestMethod.GET)
	public @ResponseBody int mCount() {
		return msvc.mCount();
	}

	// mList2 : 회원목록
	@RequestMapping(value = "/mList2", method = RequestMethod.GET)
	public @ResponseBody List<MEMBER> mList2() {
		return msvc.mList2();
	}

	// mJoin : 회원가입
	@RequestMapping(value = "/mJoin", method = RequestMethod.POST)
	public ModelAndView mJoin(@ModelAttribute MEMBER member) {

		System.out.println("\n================ 회원가입 ================");
		System.out.println("[1] jsp → controller : " + member);

		mav = msvc.mJoin(member);
		System.out.println("[5] service → controller => mav : " + mav + "\n");

		return mav;

	}

	// loginForm : 로그인 페이지 이동
	@RequestMapping(value = "/loginForm", method = RequestMethod.GET)
	public String loginForm() {
		return "member/login";
	}

	// mLogin : 로그인
	@RequestMapping(value = "/mLogin", method = RequestMethod.POST)
	public ModelAndView mLogin(@ModelAttribute MEMBER member) {

		System.out.println("\n================ 로그인 ================");
		System.out.println("[1] jsp → controller : " + member);

		mav = msvc.mLogin(member);
		System.out.println("[5] service → controller => mav : " + mav + "\n");

		return mav;

	}

	// mlist : 회원목록
	@RequestMapping(value = "/mList", method = RequestMethod.GET)
	public ModelAndView mList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(value = "limit", required = false, defaultValue = "5") int limit) {

		System.out.println("\n================ 회원목록 ================");
		System.out.println("[1] jsp → controller : " + page);

		mav = msvc.mList(page, limit);
		System.out.println("[5] service → controller => mav : " + mav + "\n");

		return mav;

	}

	@RequestMapping(value = "/mList3", method = RequestMethod.GET)
	public ModelAndView mList3() {

		mav = msvc.mList3();
		return mav;

	}

}
