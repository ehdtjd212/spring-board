package com.study.controller;

import com.study.domain.MemberVO;
import com.study.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import javax.servlet.http.HttpSession;

@Controller
public class MemberController {

    @Autowired
    private MemberMapper mapper;

    // 1. 로그인 페이지 보여주기
    @GetMapping("/login")
    public String loginPage() {
        return "login"; // /WEB-INF/views/login.jsp를 찾아감
    }

    // 2. 실제 로그인 처리 (버튼 눌렀을 때)
    @PostMapping("/loginAction")
    public String loginAction(String id, String pw, HttpSession session) {
        // DB에서 회원 조회
        MemberVO member = mapper.login(id, pw);

        if (member != null) {
            // 로그인 성공! -> 세션(Session)이라는 서버 메모리에 회원정보 저장
            session.setAttribute("loginUser", member);
            System.out.println("로그인 성공: " + member.getName());

            // 아빠(admin)면 재우 미션판으로, 아이들이면 자기 미션판으로 이동
            if(member.getId().equals("admin")) {
                return "redirect:/mission/list?targetId=jaewoo";
            } else {
                return "redirect:/mission/list?targetId=" + member.getId();
            }
        } else {
            // 로그인 실패 -> 다시 로그인 페이지로
            System.out.println("로그인 실패");
            return "redirect:/login?error=fail";
        }
    }

    // 3. 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 삭제 (통행증 파기)
        return "redirect:/login";
    }
}