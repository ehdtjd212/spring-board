package com.study.mapper;

import com.study.domain.ShopItemVO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import java.util.List;

@Mapper
public interface ShopMapper {

    // 1. 상점 물건 목록 가져오기
    @Select("SELECT * FROM shop_item ORDER BY cost ASC")
    List<ShopItemVO> getList();

    // 2. 물건 하나 정보 가져오기 (가격 확인용)
    @Select("SELECT * FROM shop_item WHERE ino = #{ino}")
    ShopItemVO getItem(int ino);

    // 3. 포인트 차감 (돈 내기)
    @Update("UPDATE member SET point = point - #{cost} WHERE id = #{id}")
    void deductPoint(@Param("id") String id, @Param("cost") int cost);

    // 4. 영수증 쓰기 (기록 남기기)
    @Insert("INSERT INTO purchase_log (member_id, item_name, cost) VALUES (#{id}, #{itemName}, #{cost})")
    void addLog(@Param("id") String id, @Param("itemName") String itemName, @Param("cost") int cost);
}