package com.study.domain;

import lombok.Data;

@Data
public class ShopItemVO {
    private int ino;      // 물건 번호
    private String name;  // 물건 이름
    private int cost;     // 가격
}