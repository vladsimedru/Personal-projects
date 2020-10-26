package org.scd.service;

import org.scd.config.exception.BusinessException;
import org.scd.model.User;
import org.scd.model.dto.UserLoginDTO;
import org.scd.model.dto.UserRegisterDTO;
import org.scd.repository.RoleRepository;
import org.scd.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.List;
import java.util.Objects;

public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder passwordEncoder;
    private final String defaultRole="1";

    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public List<User> getUsers() {
        return (List<User>) userRepository.findAll();
    }

    @Override
    public User login(UserLoginDTO userLoginDTO) throws BusinessException {

        if (Objects.isNull(userLoginDTO)) {
            throw new BusinessException(401, "Body null !");
        }

        if (Objects.isNull(userLoginDTO.getEmail())) {
            throw new BusinessException(400, "Email cannot be null ! ");
        }

        if (Objects.isNull(userLoginDTO.getPassword())) {
            throw new BusinessException(400, "Password cannot be null !");
        }

        final User user = userRepository.findByEmail(userLoginDTO.getEmail());

        if (Objects.isNull(user)) {
            throw new BusinessException(401, "Bad credentials !");
        }

        if (!passwordEncoder.matches(userLoginDTO.getPassword(), user.getPassword())) {
            throw new BusinessException(401, "Bad credentials !");
        }

        return user;
    }

    @Override
    public User register(UserRegisterDTO userRegisterDTO) throws BusinessException {
        if (Objects.isNull(userRegisterDTO)) {
            throw new BusinessException(401, "Body null !");
        }

        if (userRegisterDTO.getFirstName().isEmpty()) {
            throw new BusinessException(400, "First name cannot be empty ! ");
        }


        if (userRegisterDTO.getLastName().isEmpty()) {
            throw new BusinessException(400, "Last name cannot be empty! ");
        }

        if (userRegisterDTO.getEmail().isEmpty()) {
            throw new BusinessException(400, "Email cannot be null ! ");
        }

        if (userRegisterDTO.getPassword().isEmpty()) {
            throw new BusinessException(400, "Password cannot be null !");
        }

        if (!Objects.isNull(userRepository.findByEmail(userRegisterDTO.getEmail()))) {
            throw new BusinessException(409, "Email already exist!");
        }

        if (!userRegisterDTO.getPassword().equals(userRegisterDTO.getConfirmPassword())) {
            throw new BusinessException(401, "Password must be the same");
        }

        User user=new User();
        user.setFirstName(userRegisterDTO.getFirstName());
        user.setLastName(userRegisterDTO.getLastName());
        user.setEmail(userRegisterDTO.getEmail());
        user.setPassword(passwordEncoder.encode(userRegisterDTO.getPassword()));
        user.setRoles(roleRepository.findByRole("BASIC_USER"));
        return userRepository.save(user);
    }
}
