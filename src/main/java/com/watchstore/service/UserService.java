package com.watchstore.service;

import com.watchstore.dto.ProfileUpdateDTO;
import com.watchstore.dto.UserRegistrationDTO;
import com.watchstore.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import java.util.Optional;

public interface UserService {
    User register(UserRegistrationDTO dto);
    Optional<User> findByEmail(String email);
    Optional<User> findById(Long id);
    User updateProfile(Long userId, ProfileUpdateDTO dto);
    String updateProfileImage(Long userId, MultipartFile file);
    void toggleUserEnabled(Long userId);
    Page<User> getAllUsers(String search, Pageable pageable);
    long getTotalUsers();
    boolean existsByEmail(String email);
}
