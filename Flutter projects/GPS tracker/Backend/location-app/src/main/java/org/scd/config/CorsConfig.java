package org.scd.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.Arrays;
import java.util.List;

@Configuration
public class CorsConfig {
    private List<String> allowedOrigins=Arrays.asList("*");

    @Bean
    public CorsFilter buildCorsFilter() {
        final UrlBasedCorsConfigurationSource source=new UrlBasedCorsConfigurationSource();
        final CorsConfiguration config=new CorsConfiguration();

        config.setAllowCredentials(true);
        allowedOrigins.forEach(config::addAllowedOrigin);
        config.setAllowedMethods(Arrays.asList("POST","PUT","GET","OPTIONS","DELETE","PATCH"));
        config.setAllowedHeaders(Arrays.asList("Authorization","Content-Type","Accept"));
        config.setExposedHeaders(Arrays.asList("Location"));

        source.registerCorsConfiguration("/**",config);

        return new CorsFilter(source);
    };
}