package com.study.mapper;

import com.study.domain.MemberVO;
import org.apache.ibatis.annotations.Mapper; // 이거 임포트 필수!
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Param;

@Mapper // ⭐ 여기가 가장 중요합니다! 이 도장이 있어야 스프링이 알아봅니다.
public interface MemberMapper {

    // 1. 회원가입
    @Insert("INSERT INTO member (id, pw, name) VALUES (#{id}, #{pw}, #{name})")
    void join(MemberVO member);

    // 2. 로그인
    @Select("SELECT * FROM member WHERE id = #{id} AND pw = #{pw}")
    MemberVO login(@Param("id") String id, @Param("pw") String pw);
}