package com.study.controller;

import com.study.domain.MemberVO;
import com.study.domain.ShopItemVO;
import com.study.mapper.MemberMapper;
import com.study.mapper.ShopMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    private ShopMapper shopMapper;

    @Autowired
    private MemberMapper memberMapper; // 잔액 확인용

    // 1. 상점 입장
    @GetMapping("/list")
    public void list(HttpSession session, Model model) {
        // 로그인 안 했으면 쫓아내기
        if (session.getAttribute("loginUser") == null) {
            return;
        }

        // 물건 목록 보여주기
        model.addAttribute("list", shopMapper.getList());

        // 현재 내 포인트 최신으로 가져오기 (세션 정보는 옛날 것일 수 있어서)
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        MemberVO dbUser = memberMapper.login(user.getId(), user.getPw());
        model.addAttribute("point", dbUser.getPoint());
    }

    // 2. 물건 구매
    @PostMapping("/buy")
    public String buy(int ino, HttpSession session) {
        MemberVO user = (MemberVO) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        // 1) 물건 가격 확인
        ShopItemVO item = shopMapper.getItem(ino);

        // 2) 내 잔액 확인
        MemberVO dbUser = memberMapper.login(user.getId(), user.getPw());

        // 3) 돈이 충분한지 검사
        if (dbUser.getPoint() >= item.getCost()) {
            // 구매 진행 (차감 -> 기록)
            shopMapper.deductPoint(user.getId(), item.getCost());
            shopMapper.addLog(user.getId(), item.getName(), item.getCost());
            System.out.println("구매 성공: " + item.getName());
            return "redirect:/shop/list?msg=success";
        } else {
            System.out.println("구매 실패: 잔액 부족");
            return "redirect:/shop/list?msg=fail";
        }
    }
}