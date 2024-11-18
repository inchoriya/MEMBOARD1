package com.icia.membo.dto;

import jakarta.persistence.*;
import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Entity
@Table(name = "BOARDENTITY")
@SequenceGenerator(name="BE_SEQ_GENERATOR", sequenceName = "BE_SEQ", allocationSize = 1)
public class BoardEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BE_SEQ_GENERATOR")
    private int BNum;

    @Column
    private String BTitle;

    @Column(length = 1000)
    private String BContent;

    @Column(updatable = false)
    @CreationTimestamp
    private LocalDateTime BDate;

    @Column(insertable = false)
    @CreationTimestamp
    private LocalDateTime BUpdateDate;

    @Column
    private int BHit;

    @Column
    private String BFileName;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "BWriter")
    private MemberEntity member;

    @OneToMany(mappedBy = "board")
    private List<CommentEntity> comments;

    public static BoardEntity toEntity(BoardDTO dto){
        BoardEntity entity = new BoardEntity();
        MemberEntity member = new MemberEntity();

        entity.setBNum(dto.getBNum());
        entity.setBTitle(dto.getBTitle());
        entity.setBContent(dto.getBContent());
        entity.setBDate(dto.getBDate());
        entity.setBUpdateDate(dto.getBUpdateDate());
        entity.setBHit(dto.getBHit());
        entity.setBFileName(dto.getBFileName());

        member.setMId(dto.getBWriter());
        entity.setMember(member);

        return entity;
    }








}
