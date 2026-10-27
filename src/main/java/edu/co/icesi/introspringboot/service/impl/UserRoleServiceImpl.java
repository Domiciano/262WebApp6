package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.entity.UserRole;
import edu.co.icesi.introspringboot.entity.keys.UserRoleId;
import edu.co.icesi.introspringboot.repo.RoleRepository;
import edu.co.icesi.introspringboot.repo.UserRepository;
import edu.co.icesi.introspringboot.repo.UserRoleRepository;
import edu.co.icesi.introspringboot.service.UserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UserRoleServiceImpl implements UserRoleService {

    @Autowired
    private UserRoleRepository userRoleRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public List<UserRole> findAll() {
        return userRoleRepository.findAll();
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public Optional<UserRole> findById(UserRoleId id) {
        return userRoleRepository.findById(id);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public UserRole save(UserRole userRole) {
        return userRoleRepository.save(userRole);
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void deleteById(UserRoleId id) {
        userRoleRepository.deleteById(id);
    }

    @Override
    @PreAuthorize("hasRole('ADMIN')")
    public List<Integer> findRoleIdsByUserId(Integer userId) {
        return userRoleRepository.findByUser_Id(userId).stream()
                .map(userRole -> userRole.getRole().getId())
                .toList();
    }

    @Override
    @Transactional
    @PreAuthorize("hasRole('ADMIN')")
    public void assignRoles(Integer userId, List<Integer> roleIds) {
        List<UserRole> currentUserRoles = userRoleRepository.findByUser_Id(userId);

        //Quitar los roles que ya no estan seleccionados
        currentUserRoles.stream()
                .filter(userRole -> !roleIds.contains(userRole.getRole().getId()))
                .forEach(userRole -> userRoleRepository.delete(userRole));

        //Agregar los roles nuevos
        List<Integer> currentRoleIds = currentUserRoles.stream()
                .map(userRole -> userRole.getRole().getId())
                .toList();
        roleIds.stream()
                .filter(roleId -> !currentRoleIds.contains(roleId))
                .forEach(roleId -> {
                    UserRoleId id = new UserRoleId();
                    id.setUserId(userId);
                    id.setRoleId(roleId);

                    UserRole userRole = new UserRole();
                    userRole.setId(id);
                    userRole.setUser(userRepository.getReferenceById(userId));
                    userRole.setRole(roleRepository.getReferenceById(roleId));
                    userRoleRepository.save(userRole);
                });
    }
}
