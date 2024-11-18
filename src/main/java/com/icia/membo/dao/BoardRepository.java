package com.icia.membo.dao;

import com.icia.membo.dto.BoardEntity;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BoardRepository extends JpaRepository<BoardEntity, Integer> {

    List<BoardEntity> findAllByOrderByBNumDesc();

    List<BoardEntity> findByBTitleContainingOrderByBNumDesc(String keyword);

    List<BoardEntity> findByBContentContainingOrderByBNumDesc(String keyword);

    //List<BoardEntity> findByMember_MIdContainingOrderByBNumDesc(String keyword);

    @Modifying
    @Transactional
    @Query("UPDATE BoardEntity b Set b.BHit = b.BHit + 1 WHERE b.BNum = :BNum")
    void incrementBHit(@Param("BNum") int BNum);


    List<BoardEntity> findByMember_MIdContainingOrderByBNumDesc(String keyword);
}





