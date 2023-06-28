package com.icia.mbp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.mbp.dto.MEMBER;
import com.icia.mbp.dto.PAGING;

@Repository
public class MDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	// 아이디 중복 체크
	public String idCheck(String mId) {
		return sql.selectOne("Member.idCheck", mId);
	}

	// 회원가입
	public void mJoin(MEMBER member) {
		System.out.println("[3] service → dao : " + member);
		sql.insert("Member.mJoin", member);
	}

	public String mLogin(String mId) {
		System.out.println("[3] service → dao : " + mId);		
		return sql.selectOne("Member.mLogin", mId);
	}

	public int mCount() {
		return sql.selectOne("Member.mCount");
	}

	public List<MEMBER> mList(PAGING paging) {
		System.out.println("[3] service → dao : " + paging);
		return sql.selectList("Member.mList", paging);
	}

	public List<MEMBER> mList2() {
		return sql.selectList("Member.mList2");
	}


}
