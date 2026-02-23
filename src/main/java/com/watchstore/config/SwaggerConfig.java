package com.watchstore.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI watchStoreOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Watch Store API")
                        .description("REST API documentation for the Watch Store E-Commerce application")
                        .version("1.0.0"));
    }
}
