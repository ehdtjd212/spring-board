package com.study.mapper;

import com.study.domain.ReplyVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import java.util.List;

public interface ReplyMapper {

    // 1. 댓글 등록
    @Insert("INSERT INTO reply (bno, reply, replyer) VALUES (#{bno}, #{reply}, #{replyer})")
    void insert(ReplyVO reply);

    // 2. 댓글 목록 가져오기 (특정 게시글 bno에 달린 것만)
    @Select("SELECT * FROM reply WHERE bno = #{bno} ORDER BY rno DESC")
    List<ReplyVO> getList(int bno);
}