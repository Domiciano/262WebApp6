package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.entity.Permission;
import edu.co.icesi.introspringboot.repo.PermissionRepository;
import edu.co.icesi.introspringboot.repo.RolePermissionRepository;
import edu.co.icesi.introspringboot.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    private PermissionRepository permissionRepository;
    @Autowired
    private RolePermissionRepository rolePermissionRepository;

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public List<Permission> findAll() {
        return permissionRepository.findAll();
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public Optional<Permission> findById(Integer id) {
        return permissionRepository.findById(id);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public Permission save(Permission permission) {
        return permissionRepository.save(permission);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void deleteById(Integer id) {
        permissionRepository.deleteById(id);
        rolePermissionRepository.deleteByPermission_Id(id);
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public List<Permission> findByUsername(String username) {
        return permissionRepository.findDistinctByRolePermissions_Role_UserRoles_User_Username(username);
    }
}
