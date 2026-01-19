package com.study.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardController {

    @GetMapping("/list")
    public String list() {
        // WEB-INF/views/board/list.jsp 파일을 찾아가도록 리턴
        return "board/list";
    }
}