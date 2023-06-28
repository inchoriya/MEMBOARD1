package com.icia.mbp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.mbp.dto.COMMENT;

@Repository
public class CDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	public List<COMMENT> cList(int cbNum) {
		return sql.selectList("Comment.cList", cbNum);
	}

	public void cWrite(COMMENT comment) {
		sql.insert("Comment.cWrite", comment);
	}

	public void cModify(COMMENT comment) {
		sql.update("Comment.cModify",comment);
	}

	public void cDelete(COMMENT comment) {
		sql.delete("Comment.cDelete", comment);
	}

}
