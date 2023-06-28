package com.icia.mbp.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.mbp.dto.COMMENT;
import com.icia.mbp.service.CService;

@Controller
public class CController {
	
	@Autowired
	private CService csvc;
	
	// cList : 댓글 목록
	@RequestMapping(value="cList", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cList(@RequestParam("cbNum") int cbNum){
		List<COMMENT> list = csvc.cList(cbNum);
		return list;
	}
	
	// cWrite : 댓글 작성
	@RequestMapping(value="cWrite", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cWrite(@ModelAttribute COMMENT comment){
		List<COMMENT> list = csvc.cWrite(comment);
		return list;
	}
	
	// cModify : 댓글 수정
	@RequestMapping(value="cModify", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cModify(@ModelAttribute COMMENT comment){
		List<COMMENT> list = csvc.cModify(comment);
		return list;
	}
	
	// cDelete : 댓글 삭제
	@RequestMapping(value="cDelete", method = RequestMethod.POST)
	public @ResponseBody List<COMMENT> cDelete(@ModelAttribute COMMENT comment){
		List<COMMENT> list = csvc.cDelete(comment);
		return list;
	}
	
	
	
	
	
	
}








