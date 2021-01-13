package org.scd.controller;

import org.scd.config.exception.BusinessException;
import org.scd.model.User;
import org.scd.model.dto.UserLoginDTO;
import org.scd.model.dto.UserRegisterDTO;
import org.scd.model.security.CustomUserDetails;
import org.scd.service.UserService;
import org.scd.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController()
@RequestMapping("/users")
public class UserController {
    private final UserServiceImpl userService;

    @Autowired
    public UserController(UserServiceImpl userService) {
        this.userService = userService;
    }

    @GetMapping(path="/users")
    public ResponseEntity<List<User>> getUsers() throws BusinessException {
           return ResponseEntity.ok(userService.getUsers());
    }

    @GetMapping(path = "/me")
    public ResponseEntity<User> getCurrentUser() {
        final User currentUser = ((CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUser();
        return ResponseEntity.ok(currentUser);
    }

    @GetMapping(path = "/me/id")
    public ResponseEntity<Long> getCurrentUserId() {
        final Long currentUserId = ((CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUser().getId();
        return ResponseEntity.ok(currentUserId);
    }

    @PostMapping(path = "/login")
    public ResponseEntity<User> loginUser(@RequestBody final UserLoginDTO userLoginDTO) throws BusinessException {
        return ResponseEntity.ok(userService.login(userLoginDTO));
    }

    @PostMapping(path = "/register")
    public ResponseEntity<User> registerUser(@RequestBody final UserRegisterDTO userRegisterDTO) throws BusinessException {
        return ResponseEntity.ok(userService.register(userRegisterDTO));
    }

    @GetMapping(path="/roles/admin/{id}")
    public ResponseEntity<User> makeAdmin(@PathVariable Long id) throws BusinessException {
        return ResponseEntity.ok(userService.makeAdmin(id));
    }

    @GetMapping(path="/roles/basicUser/{id}")
    public ResponseEntity<User> makeBasicUser(@PathVariable Long id) throws BusinessException {
        return ResponseEntity.ok(userService.makeBasicUser(id));
    }

    @DeleteMapping(path="/delete/{id}")
    public void deleteUser(@PathVariable Long id) throws BusinessException {
        userService.delete(id);
    }

}