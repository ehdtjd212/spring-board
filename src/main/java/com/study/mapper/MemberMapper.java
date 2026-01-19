package com.study.mapper;

import com.study.domain.MemberVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;

public interface MemberMapper {

    // 1. 회원가입
    @Insert("INSERT INTO member (id, pw, name) VALUES (#{id}, #{pw}, #{name})")
    void join(MemberVO member);

    // 2. 로그인 (아이디와 비번이 일치하는 회원 정보 가져오기)
    @Select("SELECT * FROM member WHERE id = #{id} AND pw = #{pw}")
    MemberVO login(@Param("id") String id, @Param("pw") String pw);
}