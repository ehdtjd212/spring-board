package com.study.domain;

import lombok.Data;

@Data
public class MemberVO {
    private String id;
    private String pw;
    private String name;
    private int point; // 어제 추가한 포인트 컬럼
}