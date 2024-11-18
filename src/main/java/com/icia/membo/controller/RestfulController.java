package com.icia.membo.controller;

import com.icia.membo.dto.BoardDTO;
import com.icia.membo.dto.SearchDTO;
import com.icia.membo.service.BoardService;
import com.icia.membo.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class RestfulController {

    private final MemberService msvc;

    private final BoardService bsvc;

    // idCheck : 아이디 중복 체크
    @PostMapping("/idCheck")
    public String idCheck(@RequestParam("MId") String mId){
        String result = msvc.idCheck(mId);
        return result;
    }

    // emailCheck : 이메일 인증번호 받아오기
    @PostMapping("/emailCheck")
    public String emailCheck(@RequestParam("MEmail") String mEmail){
        String uuid = msvc.emailCheck(mEmail);
        return uuid;
    }

    // boardList : 게시글 목록
    @PostMapping("/boardList")
    public List<BoardDTO> boardList(){
        return bsvc.boardList();
    }

    // searchList : 검색 목록
    @PostMapping("/searchList")
    public List<BoardDTO> searchList(@ModelAttribute SearchDTO search){
        System.out.println("search : " + search);   // category, keyword
        return bsvc.searchList(search);
    }

}
