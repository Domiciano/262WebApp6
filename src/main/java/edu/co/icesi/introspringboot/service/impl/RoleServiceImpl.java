package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.entity.Role;
import edu.co.icesi.introspringboot.entity.RolePermission;
import edu.co.icesi.introspringboot.entity.keys.RolePermissionId;
import edu.co.icesi.introspringboot.repo.PermissionRepository;
import edu.co.icesi.introspringboot.repo.RolePermissionRepository;
import edu.co.icesi.introspringboot.repo.RoleRepository;
import edu.co.icesi.introspringboot.repo.UserRoleRepository;
import edu.co.icesi.introspringboot.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private UserRoleRepository userRoleRepository;
    @Autowired
    private RolePermissionRepository rolePermissionRepository;
    @Autowired
    private PermissionRepository permissionRepository;

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public Optional<Role> findById(Integer id) {
        return roleRepository.findById(id);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public Role save(Role role) {
        if(role.getPublicId() == null) {
            role.setPublicId(UUID.randomUUID().toString());
        }
        return roleRepository.save(role);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void deleteById(Integer id) {
        roleRepository.deleteById(id);
        userRoleRepository.deleteByRole_Id(id);
        rolePermissionRepository.deleteByRole_Id(id);
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public List<Integer> findPermissionIdsByRoleId(Integer roleId) {
        return rolePermissionRepository.findByRole_Id(roleId).stream()
                .map(rolePermission -> rolePermission.getPermission().getId())
                .toList();
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void updatePermissions(Integer roleId, List<Integer> permissionIds) {
        List<RolePermission> currentRolePermissions = rolePermissionRepository.findByRole_Id(roleId);

        //Quitar los permisos que ya no estan seleccionados
        currentRolePermissions.stream()
                .filter(rolePermission -> !permissionIds.contains(rolePermission.getPermission().getId()))
                .forEach(rolePermission -> rolePermissionRepository.delete(rolePermission));

        //Agregar los permisos nuevos
        List<Integer> currentPermissionIds = currentRolePermissions.stream()
                .map(rolePermission -> rolePermission.getPermission().getId())
                .toList();
        permissionIds.stream()
                .filter(permissionId -> !currentPermissionIds.contains(permissionId))
                .forEach(permissionId -> {
                    RolePermissionId id = new RolePermissionId();
                    id.setRoleId(roleId);
                    id.setPermissionId(permissionId);

                    RolePermission rolePermission = new RolePermission();
                    rolePermission.setId(id);
                    rolePermission.setRole(roleRepository.getReferenceById(roleId));
                    rolePermission.setPermission(permissionRepository.getReferenceById(permissionId));
                    rolePermissionRepository.save(rolePermission);
                });
    }
}
