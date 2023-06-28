package com.icia.mbp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.mbp.dto.BOARD;

@Repository
public class BDAO {

	@Autowired
	private SqlSessionTemplate sql;
	
	public void bWrite(BOARD board) {
		System.out.println("[3] service → dao : " + board);
		sql.insert("Board.bWrite", board);
	}

	public int bCount() {
		return sql.selectOne("Board.bCount");
	}

	public List<BOARD> bList() {
		System.out.println("[3] service → dao");
		return sql.selectList("Board.bList");
	}

	public int bHit(int bNum) {
		return sql.update("Board.bHit", bNum);
	}

	public BOARD bView(int bNum) {
		System.out.println("[3] service → dao => bNum : " + bNum);
		return sql.selectOne("Board.bView", bNum);
	}


}







