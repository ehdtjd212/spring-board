package com.study.controller;

import com.study.domain.ReplyVO;
import com.study.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController // [중요] 화면 대신 데이터(JSON)를 리턴하는 컨트롤러!
@RequestMapping("/reply")
public class ReplyController {

    @Autowired
    private ReplyMapper replyMapper;

    // 1. 댓글 등록 (POST 방식)
    // 받아올 때 @RequestBody를 써야 JSON 데이터를 자바 객체로 받음
    @PostMapping("/write")
    public String write(@RequestBody ReplyVO reply) {
        replyMapper.insert(reply);
        return "SUCCESS";
    }

    // 2. 댓글 목록 조회 (GET 방식)
    @GetMapping("/list")
    public List<ReplyVO> getList(int bno) {
        return replyMapper.getList(bno); // 자바 리스트를 주면 알아서 JSON 배열로 변환됨
    }
}