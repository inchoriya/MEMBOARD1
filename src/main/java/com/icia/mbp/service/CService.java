package com.icia.mbp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.mbp.dao.CDAO;
import com.icia.mbp.dto.COMMENT;

@Service
public class CService {
	
	@Autowired
	private CDAO cdao;

	public List<COMMENT> cList(int cbNum) {
		List<COMMENT> list = cdao.cList(cbNum);
		return list;
	}

	public List<COMMENT> cWrite(COMMENT comment) {

		
		try {
			cdao.cWrite(comment);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		List<COMMENT> list = cdao.cList(comment.getCbNum());
		
		return list;
	}

	public List<COMMENT> cModify(COMMENT comment) {
		
		try {
			cdao.cModify(comment);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		List<COMMENT> list = cdao.cList(comment.getCbNum());
		
		return list;
	}

	public List<COMMENT> cDelete(COMMENT comment) {
		try {
			cdao.cDelete(comment);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		List<COMMENT> list = cdao.cList(comment.getCbNum());
		
		return list;
	}

}
