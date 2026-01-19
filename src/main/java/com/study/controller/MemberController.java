package com.study.controller;

import com.study.domain.MemberVO;
import com.study.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession; // 세션 관리용

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberMapper memberMapper;

    // 1. 로그인 화면 보여주기
    @GetMapping("/login")
    public String loginForm() {
        return "member/login";
    }

    // 2. 로그인 처리 (ID, PW 검사)
    @PostMapping("/login")
    public String loginAction(String id, String pw, HttpSession session) {
        // DB에서 회원 정보 조회
        MemberVO member = memberMapper.login(id, pw);

        if (member != null) {
            // 성공: 세션에 회원정보 저장 (이름표 붙이기)
            session.setAttribute("member", member);
            return "redirect:/board/list"; // 게시판 목록으로 이동
        } else {
            // 실패: 다시 로그인 화면으로 (에러 파라미터 추가)
            return "redirect:/member/login?error=true";
        }
    }

    // 3. 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 전체 삭제 (로그아웃)
        return "redirect:/board/list";
    }
}