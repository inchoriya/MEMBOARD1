package com.icia.membo.dto;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name="MEMBERENTITY")
public class MemberEntity {

    @Id
    private String MId;

    @Column
    private String MPw;

    @Column
    private String MName;

    @Column
    private String MBirth;

    @Column
    private String MGender;

    @Column
    private String MEmail;

    @Column
    private String MPhone;

    @Column
    private String MAddr;

    @Column
    private String MProfileName;

    @OneToMany(mappedBy = "member")
    private List<BoardEntity> boards;

    @OneToMany(mappedBy = "member")
    private List<CommentEntity> comments;


    public static MemberEntity toEntity(MemberDTO dto){
        MemberEntity entity = new MemberEntity();

        entity.setMId(dto.getMId());
        entity.setMPw(dto.getMPw());
        entity.setMName(dto.getMName());
        entity.setMBirth(dto.getMBirth());
        entity.setMGender(dto.getMGender());
        entity.setMEmail(dto.getMEmail());
        entity.setMPhone(dto.getMPhone());
        entity.setMAddr(dto.getMAddr());
        entity.setMProfileName(dto.getMProfileName());

        return entity;
    }





}







