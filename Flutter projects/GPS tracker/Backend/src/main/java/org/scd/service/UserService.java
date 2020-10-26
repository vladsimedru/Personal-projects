package org.scd.service;

import org.scd.config.exception.BusinessException;
import org.scd.model.User;
import org.scd.model.dto.UserLoginDTO;
import org.scd.model.dto.UserRegisterDTO;
import org.scd.model.security.Role;

import java.util.List;
import java.util.Set;

public interface UserService {
    /**
     * Get existing list of users from database
     * @return
     */
    List<User> getUsers();

    /**
     * Login into application
     * @param userLoginDTO - user information
     * @return
     */
    User login(final UserLoginDTO userLoginDTO) throws BusinessException;

    /**
     * Register into application
     * @param userRegisterDTO - user information
     * @return
     */
    User register(final UserRegisterDTO userRegisterDTO) throws BusinessException;
}