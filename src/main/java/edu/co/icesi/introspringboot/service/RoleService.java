package edu.co.icesi.introspringboot.service;

import edu.co.icesi.introspringboot.entity.Role;

import java.util.List;
import java.util.Optional;

public interface RoleService {

    List<Role> findAll();

    Optional<Role> findById(Integer id);

    Role save(Role role);

    void deleteById(Integer id);

    List<Integer> findPermissionIdsByRoleId(Integer roleId);

    void updatePermissions(Integer roleId, List<Integer> permissionIds);

}
