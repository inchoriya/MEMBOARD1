package com.icia.membo.service;

import com.icia.membo.dao.CommentRepository;
import com.icia.membo.dto.BoardEntity;
import com.icia.membo.dto.CommentDTO;
import com.icia.membo.dto.CommentEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository crepo;

    public List<CommentDTO> cList(int CBNum) {
        List<CommentDTO> dtoList = new ArrayList<>();
        List<CommentEntity> entityList = crepo.findAllByBoard_BNum(CBNum);

        for(CommentEntity entity : entityList ){
            dtoList.add(CommentDTO.toDTO(entity));
        }

        return dtoList;
    }

    public List<CommentDTO> cWrite(CommentDTO comment) {

        // 댓글 입력
        CommentEntity entity = CommentEntity.toEntity(comment);
        crepo.save(entity);

        // 댓글 입력 후 목록 불러오기
        List<CommentDTO> dtoList = cList(comment.getCBNum());
        return dtoList;

    }


    public List<CommentDTO> cDelete(CommentDTO comment) {

        // 댓글 삭제
        crepo.deleteById(comment.getCNum());

        // 댓글 입력 후 목록 불러오기
        List<CommentDTO> dtoList = cList(comment.getCBNum());
        return dtoList;

    }
}
