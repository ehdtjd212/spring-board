package com.study.controller;

import com.study.domain.BoardVO;
import com.study.domain.PageHandler;
import com.study.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model; // Model 임포트 필수!
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping; // 경로 묶기용
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/board") // 이제 주소창에 /board/list 로 접속하게 합니다
public class HomeController {

    @Autowired
    private BoardMapper boardMapper;

    // 기존 list 메서드를 이걸로 교체하세요
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page,
                       @RequestParam(required = false) String option,  // 검색 조건 (필수 아님)
                       @RequestParam(required = false) String keyword, // 검색어 (필수 아님)
                       Model model) {

        // 1. 검색어에 맞는 전체 개수 가져오기
        int totalCount = boardMapper.countAll(option, keyword);

        // 2. 페이지 계산기 (검색어도 같이 기억함)
        PageHandler pageHandler = new PageHandler(totalCount, page, option, keyword);

        // 3. 검색된 데이터만 가져오기
        List<BoardVO> list = boardMapper.findAll(pageHandler.getOffset(), pageHandler.getSize(), option, keyword);

        model.addAttribute("list", list);
        model.addAttribute("ph", pageHandler);

        return "board/list";
    }

    // 1. 글쓰기 화면 보여주기 (GET 방식)
    @GetMapping("/write")
    public String writeForm() {
        return "board/write"; // write.jsp 로 이동
    }

    // 2. 글 저장하기 (POST 방식)
    @org.springframework.web.bind.annotation.PostMapping("/write")
    public String writeSave(BoardVO board) {
        // 사용자가 입력한 데이터(board)를 DB에 저장
        boardMapper.insert(board);

        // 저장이 끝나면 다시 목록 페이지로 강제 이동(Redirect)
        return "redirect:/board/list";
    }
    // ... 기존 메서드들 아래에 추가 ...

    // 3. 게시글 상세 보기
    @GetMapping("/read")
    public String read(int id, Model model) {
        // 1. DB에서 글 내용 가져오기
        BoardVO board = boardMapper.findById(id);

        // 2. [Redis] 조회수 키 만들기 (예: "view:count:3")
        String key = "view:count:" + id;

        // 3. [Redis] 조회수 1 증가시키기 (increment)
        // 만약 키가 없으면 자동으로 0에서 시작해서 1을 만듭니다.
        redisTemplate.opsForValue().increment(key);

        // 4. [Redis] 증가된 조회수 가져오기
        String viewCount = redisTemplate.opsForValue().get(key);

        // 5. 화면으로 조회수도 같이 보냄
        model.addAttribute("board", board);
        model.addAttribute("viewCount", viewCount);

        return "board/read";
    }

    // 4. 수정 페이지로 이동 (기존 내용을 가지고 감)
    @GetMapping("/modify")
    public String modifyForm(int id, Model model) {
        BoardVO board = boardMapper.findById(id);
        model.addAttribute("board", board);
        return "board/modify"; // modify.jsp 로 이동
    }

    // 5. 수정 내용 저장 (POST)
    @org.springframework.web.bind.annotation.PostMapping("/modify")
    public String modifyAction(BoardVO board) {
        boardMapper.update(board);
        return "redirect:/board/read?id=" + board.getId(); // 수정한 글을 다시 보여줌
    }

    // 6. 삭제하기
    @GetMapping("/delete")
    public String deleteAction(int id) {
        boardMapper.delete(id);
        return "redirect:/board/list"; // 목록으로 이동
    }
    // ↓↓↓ 이 부분 추가!
    @Autowired
    private org.springframework.data.redis.core.RedisTemplate<String, String> redisTemplate;
}