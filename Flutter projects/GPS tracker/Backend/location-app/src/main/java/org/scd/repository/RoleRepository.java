package org.scd.repository;

import org.scd.model.security.Role;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;
import java.util.Set;

public interface RoleRepository extends CrudRepository<Role, Long> {
    Set<Role> findById(int i);

    Set<Role> findByRole(String role);

    Set<Role> findAll();
}
