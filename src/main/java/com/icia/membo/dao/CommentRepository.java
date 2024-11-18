package com.icia.membo.dao;

import com.icia.membo.dto.CommentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<CommentEntity, Integer> {

    List<CommentEntity> findAllByBoard_BNum(int cbNum);


}
