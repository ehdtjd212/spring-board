package com.study.domain;

public class PageHandler {
    private int total;      // 전체 게시글 수
    private int page;       // 현재 페이지
    private int size = 10;  // 페이지당 글 수

    // ↓↓↓ [추가된 부분] 검색 기능용 변수
    private String option;  // 검색 조건 (T:제목, W:작성자)
    private String keyword; // 검색어

    private int totalPage;
    private int begin;
    private int end;
    private boolean prev;
    private boolean next;

    // 생성자 수정: 검색어(keyword)와 조건(option)도 같이 받음
    public PageHandler(int total, int page, String option, String keyword) {
        this.total = total;
        this.page = page;
        this.option = option;
        this.keyword = keyword;

        this.totalPage = (int) Math.ceil((double)total / size);
        this.end = (int) (Math.ceil(page / 10.0)) * 10;
        this.begin = this.end - 9;

        if(this.totalPage < this.end) {
            this.end = this.totalPage;
        }

        this.prev = this.begin > 1;
        this.next = this.end < this.totalPage;
    }

    public int getOffset() { return (page - 1) * size; }

    // Getter 메서드들
    public int getTotal() { return total; }
    public int getPage() { return page; }
    public int getSize() { return size; }
    public int getTotalPage() { return totalPage; }
    public int getBegin() { return begin; }
    public int getEnd() { return end; }
    public boolean isPrev() { return prev; }
    public boolean isNext() { return next; }
    public String getOption() { return option; }
    public String getKeyword() { return keyword; }
}