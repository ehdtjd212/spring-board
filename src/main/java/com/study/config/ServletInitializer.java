package com.study.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class ServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    @Override
    protected Class<?>[] getServletConfigClasses() {
        // WebConfig 클래스를 여기서 불러옵니다.
        return new Class[] { WebConfig.class };
    }

    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }
    @Override
    protected Class<?>[] getRootConfigClasses() {
        // 기존 return null; 을 지우고 아래처럼 바꾸세요!
        return new Class[] { DBConfig.class ,RedisConfig.class};
    }

    // ↓↓↓ 이 코드를 복사해서 추가하세요
    @Override
    protected javax.servlet.Filter[] getServletFilters() {
        org.springframework.web.filter.CharacterEncodingFilter encodingFilter = new org.springframework.web.filter.CharacterEncodingFilter();
        encodingFilter.setEncoding("UTF-8");
        encodingFilter.setForceEncoding(true); // "강제로 UTF-8로 변환해!"
        return new javax.servlet.Filter[]{encodingFilter};
    }
}