package com.study.mapper;

import com.study.domain.BoardVO;
import org.apache.ibatis.annotations.Select;
import java.util.List;
import org.apache.ibatis.annotations.Param; // 이거 임포트 필수!

public interface BoardMapper {

    // 1. 검색 조건에 따라 글 목록 조회 (동적 쿼리)
    @Select("<script>" +
            "SELECT * FROM board " +
            "<where>" +
            "  <if test='option == \"T\"'> AND title LIKE CONCAT('%', #{keyword}, '%') </if>" +
            "  <if test='option == \"W\"'> AND writer LIKE CONCAT('%', #{keyword}, '%') </if>" +
            "</where>" +
            "ORDER BY id DESC LIMIT #{offset}, #{size}" +
            "</script>")
    List<BoardVO> findAll(@Param("offset") int offset, @Param("size") int size,
                          @Param("option") String option, @Param("keyword") String keyword);

    // 2. 검색된 글의 개수만 세기 (그래야 페이지 계산이 맞음)
    @Select("<script>" +
            "SELECT count(*) FROM board " +
            "<where>" +
            "  <if test='option == \"T\"'> AND title LIKE CONCAT('%', #{keyword}, '%') </if>" +
            "  <if test='option == \"W\"'> AND writer LIKE CONCAT('%', #{keyword}, '%') </if>" +
            "</where>" +
            "</script>")
    int countAll(@Param("option") String option, @Param("keyword") String keyword);

    // ↓↓↓ 이 부분 추가! (데이터를 넣는 SQL)
    @org.apache.ibatis.annotations.Insert("INSERT INTO board (title, content, writer) VALUES (#{title}, #{content}, #{writer})")
    void insert(BoardVO board);

    // ↓↓↓ 이 부분 추가! (ID로 글 하나만 조회하기)
    @Select("SELECT * FROM board WHERE id = #{id}")
    BoardVO findById(int id);

    // 1. 글 수정하기
    @org.apache.ibatis.annotations.Update("UPDATE board SET title=#{title}, content=#{content}, writer=#{writer} WHERE id=#{id}")
    void update(BoardVO board);

    // 2. 글 삭제하기
    @org.apache.ibatis.annotations.Delete("DELETE FROM board WHERE id=#{id}")
    void delete(int id);
}