package com.study.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
// @MapperScan: 나중에 만들 SQL 매퍼 인터페이스 위치 (일단 적어둡니다)
@MapperScan(basePackages = "com.study.mapper")
public class DBConfig {

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        // 주소 뒤에 UTF-8 설정 등을 붙여야 한글이 안 깨집니다.
        dataSource.setUrl("jdbc:mysql://localhost:3306/board_db?serverTimezone=Asia/Seoul&characterEncoding=UTF-8");
        dataSource.setUsername("root");
        dataSource.setPassword("1234"); // insecure 모드라 비번 없음
        return dataSource;
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);

        // ↓↓↓↓↓ [이 부분이 핵심 추가된 코드입니다!] ↓↓↓↓↓
        // "밑줄(snake_case)을 카멜케이스(camelCase)로 자동 변환해라" 설정
        org.apache.ibatis.session.Configuration config = new org.apache.ibatis.session.Configuration();
        config.setMapUnderscoreToCamelCase(true);
        sessionFactory.setConfiguration(config);
        // ↑↑↑↑↑

        return sessionFactory.getObject();
    }
}