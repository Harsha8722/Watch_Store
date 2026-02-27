package com.watchstore.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    // Hard-coded upload directory (Windows path)
    private static final String UPLOAD_DIR = "d:/Watches/uploads/";

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Serve uploaded files from the uploads directory
        // Ensure the path ends with / and uses file:/// prefix
        String uploadLocation = "file:///" + UPLOAD_DIR.replace("\\", "/");
        if (!uploadLocation.endsWith("/")) {
            uploadLocation = uploadLocation + "/";
        }

        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadLocation);

        // Map /static/** to classpath:/static/
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}
