package com.study.controller;

import com.study.domain.MissionVO;
import com.study.mapper.MissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/mission")
public class MissionController {

    @Autowired
    private MissionMapper mapper;

    // 1. 미션 목록 페이지 보여주기
    // 접속 주소: /mission/list?targetId=jaewoo (재우꺼)
    @GetMapping("/list")
    public void list(@RequestParam("targetId") String targetId, Model model) {
        model.addAttribute("list", mapper.getList(targetId));
        model.addAttribute("targetId", targetId); // 화면에 누구 건지 표시하려고
        // 추가된 줄: 현재 총 포인트 가져오기
        model.addAttribute("totalPoint", mapper.getPoint(targetId));
    }

    // 2. 미션 등록하기 (아빠가 입력한 폼 처리)
    @PostMapping("/register")
    public String register(MissionVO mission) {
        mapper.insert(mission);
        return "redirect:/mission/list?targetId=" + mission.getTargetId();
    }

    // 3. 완료하기 (수정됨: 점수 지급 로직 추가)
    @PostMapping("/complete")
    public String complete(int mno, String targetId, int reward) { // reward 파라미터 추가
        mapper.updateStatus(mno);           // 1. 미션 완료 도장 쾅!
        mapper.plusPoint(targetId, reward); // 2. 보너스 입금 띠링! 💰
        return "redirect:/mission/list?targetId=" + targetId;
    }
}