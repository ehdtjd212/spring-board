package com.study.domain;

import java.util.Date;

public class BoardVO {
    private int id;
    private String title;
    private String content;
    private String writer;
    private Date regDate;

    // Getter & Setter (단축키: Alt + Insert -> Getter and Setter -> 전체 선택 -> OK)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }
    public Date getRegDate() { return regDate; }
    public void setRegDate(Date regDate) { this.regDate = regDate; }

    // ... 기존 Getter/Setter 아래에 추가 ...

    @Override
    public String toString() {
        return "BoardVO [id=" + id + ", title=" + title + ", writer=" + writer + ", regDate=" + regDate + "]";
    }
}