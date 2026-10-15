package edu.co.icesi.introspringboot.service;

import edu.co.icesi.introspringboot.entity.UserRole;
import edu.co.icesi.introspringboot.entity.keys.UserRoleId;

import java.util.List;
import java.util.Optional;

public interface UserRoleService {

    List<UserRole> findAll();

    Optional<UserRole> findById(UserRoleId id);

    UserRole save(UserRole userRole);

    void deleteById(UserRoleId id);

    List<Integer> findRoleIdsByUserId(Integer userId);

    void assignRoles(Integer userId, List<Integer> roleIds);

}
