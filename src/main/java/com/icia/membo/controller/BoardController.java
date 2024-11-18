package com.icia.membo.controller;

import com.icia.membo.dto.BoardDTO;
import com.icia.membo.service.BoardService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService bsvc;

    private final HttpSession session;

    // bWriteForm
    @GetMapping("/bWriteForm")
    public String bWriteForm(){

//        if(session.getAttribute("loginId") == null){
//            return "member/login";
//        } else {
//            return "board/write";
//        }
        return "board/write";
    }

    // bWrite : 게시글 작성
    @PostMapping("/bWrite")
    public ModelAndView bWrite(@ModelAttribute BoardDTO board){
        System.out.println("\n게시글작성1\n[1] board : " + board);
        return bsvc.bWrite(board);
    }

    // bList : 게시글 목록 페이지로 이동
    @GetMapping("bList")
    public String bList(){
        return "board/list";
    }

    // bView : 게시글 상세보기
    @GetMapping("/bView/{BNum}")
    public ModelAndView bView(@PathVariable int BNum){
        return bsvc.bView(BNum);
    }








}



