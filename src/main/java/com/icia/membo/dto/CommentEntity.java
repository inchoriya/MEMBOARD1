package com.icia.membo.dto;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "COMMENTENTITY")
@SequenceGenerator(name = "CMT_SEQ_GENERATOR", sequenceName = "CMT_SEQ", allocationSize = 1)
public class CommentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CMT_SEQ_GENERATOR")
    private int CNum;

    @Column
    private String CContent;

    @Column(updatable = false)
    @CreationTimestamp
    private LocalDateTime CDate;

    @ManyToOne
    @JoinColumn(name="CWriter")
    private MemberEntity member;

    @ManyToOne
    @JoinColumn(name="CBNum")
    private BoardEntity board;

    public static CommentEntity toEntity(CommentDTO dto){
        CommentEntity entity = new CommentEntity();

        entity.setCNum(dto.getCNum());
        entity.setCContent(dto.getCContent());
        entity.setCDate(dto.getCDate());

        MemberEntity member = new MemberEntity();
        member.setMId(dto.getCWriter());
        entity.setMember(member);

        BoardEntity board = new BoardEntity();
        board.setBNum(dto.getCBNum());
        entity.setBoard(board);

        return entity;
    }




}
