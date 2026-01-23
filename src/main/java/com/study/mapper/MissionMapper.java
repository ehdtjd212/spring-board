package com.study.mapper;

import com.study.domain.MissionVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MissionMapper {
    // 1. 특정 자녀(targetId)의 미션 목록 가져오기
    List<MissionVO> getList(String targetId);

    // 2. 미션 등록하기 (아빠가)
    void insert(MissionVO mission);

    // 3. 미션 완료 처리하기 (상태를 DONE으로 변경)
    void updateStatus(int mno);

    // 기존 코드 아래에 추가
    // 4. 회원 포인트 올려주기
    void plusPoint(@Param("targetId") String targetId, @Param("amount") int amount);

    // 5. 현재 포인트 가져오기 (화면에 보여주려고)
    int getPoint(String targetId);
}