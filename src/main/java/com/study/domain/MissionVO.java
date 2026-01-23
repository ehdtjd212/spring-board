package com.study.domain;

import lombok.Data;

import java.util.Date;

@Data
public class MissionVO {
    private int mno;          // 미션 번호
    private String title;     // 미션 내용 (예: 수학 문제집 풀기)
    private String targetId;  // 누구 미션인지 (jaewoo 또는 jaei)
    private int reward;       // 보상 포인트
    private String status;    // 상태 (TODO: 할일, DONE: 완료)
    private Date regdate;     // 등록일
}