package com.icia.mbp.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.mbp.dao.MDAO;
import com.icia.mbp.dto.MEMBER;
import com.icia.mbp.dto.PAGING;

@Service
public class MService {

	@Autowired
	private MDAO mdao;

	@Autowired
	private HttpServletRequest request;
	
	public String savePath() {
		String path = request.getServletContext().getRealPath("");
		return path;
	}
	

	@Autowired
	private BCryptPasswordEncoder pwEnc;

	@Autowired
	private HttpSession session;

	private ModelAndView mav;

	public String idCheck(String mId) {
		String result = null;

		String checkId = mdao.idCheck(mId);

		if (checkId == null) {
			// 아이디 사용가능
			result = "OK";
		} else {
			// 아이디 사용불가능
			result = "NO";
		}

		return result;
	}

	public ModelAndView mJoin(MEMBER member) {
		System.out.println("[2] controller → service : " + member);
		mav = new ModelAndView();

		// 파일(사진) 업로드
		// (1)경로(폴더) 생성
		
		// String savePath =
		// "D:\\강의자료\\SpringWorkspace\\MEMBOARD\\src\\main\\webapp\\resources\\profile\\";

		// D:\강의자료\SpringWorkspace\MEMBOARD\src\main\webapp\resources\profile\
		// D:\강의자료\SpringWorkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MEMBOARD\

		// .metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ 지우고
		// src\main\webapp\resources\profile\ 더하고

		String savePath = savePath().replace(".metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\", "")
				+ "src\\main\\webapp\\resources\\profile\\";

		MultipartFile mProfile = member.getMProfile();

		String mProfileName = null;

		if (!mProfile.isEmpty()) {
			// (2)파일 이름 생성(식별자 uuid + 파일 원래 이름)
			String uuid = UUID.randomUUID().toString().substring(0, 8);

			String fileName = mProfile.getOriginalFilename();

			mProfileName = uuid + "_" + fileName;
			member.setMProfileName(mProfileName);

		}

		// [2] 주소결합
		String mAddr = "(" + member.getAddr1() + ") " + member.getAddr2() + ", " + member.getAddr3();

		// (22223) 인천시 매소홀로 488번길 6-32, 태승빌딩4층

		member.setMAddr(mAddr);

		// [3] 비밀번호 암호화
		member.setMPw(pwEnc.encode(member.getMPw()));

		try {
			mdao.mJoin(member);
			System.out.println("[4] dao → service");

			// (3) 업로드
			try {
				mProfile.transferTo(new File(savePath + mProfileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			mav.setViewName("index");

		} catch (Exception e) {
			mav.setViewName("member/join");

			// 오류가 난 부분을 알려준다.
			e.printStackTrace();
		}

		return mav;
	}

	public ModelAndView mLogin(MEMBER member) {
		System.out.println("[2] controller → service : " + member);
		mav = new ModelAndView();

		// db에서 해당 id에 대한 pw를 가져온다(암호화 된 비밀번호)
		String encPw = mdao.mLogin(member.getMId());
		System.out.println("[4] dao → service : " + encPw);

		// 로그인 페이지에서 입력한 비밀번호
		String mPw = member.getMPw();

		// matches() 를 사용해서 입력한 비밀번호와 암호화 된 비밀번호 매칭하기
		if (pwEnc.matches(mPw, encPw)) {
			session.setAttribute("loginId", member.getMId());
			mav.setViewName("index");
		} else {
			mav.setViewName("member/login");
		}

		return mav;
	}

	public ModelAndView mList(int page, int limit) {
		System.out.println("[2] controller → service : " + page);
		mav = new ModelAndView();
		
		int count = mdao.mCount();
		
		PAGING paging = paging(page, limit, count);
		
		List<MEMBER> memberList = mdao.mList(paging);
		System.out.println("[4] dao → service : " + memberList);
		
		mav.setViewName("member/list");
		mav.addObject("memberList", memberList);
		mav.addObject("paging", paging);

		return mav;
	}
	
	public ModelAndView mList3() {
		
		mav = new ModelAndView();
		
		int count = mdao.mCount();
		
		List<MEMBER> memberList = mdao.mList2();
		
		mav.setViewName("member/list");
		mav.addObject("memberList", memberList);
		mav.addObject("count", count);

		return mav;
	}

	public PAGING paging(int page, int limit, int count) {
		
		// (1) 한 화면에 보여줄 페이지 번호 갯수
		int block = 5;

		// 최대페이지 : 4
		int maxPage = (int) (Math.ceil((double) count / limit));

		if (page > maxPage) {
			if(maxPage==0) {
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

		return paging;
	}

	public int mCount() {
		return mdao.mCount();
	}

	public List<MEMBER> mList2() {
		return mdao.mList2();
	}

}
