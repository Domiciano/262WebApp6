package edu.co.icesi.introspringboot.service.impl;

import edu.co.icesi.introspringboot.entity.User;
import edu.co.icesi.introspringboot.repo.UserRepository;
import edu.co.icesi.introspringboot.repo.UserRoleRepository;
import edu.co.icesi.introspringboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserRoleRepository userRoleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @Override
    @PreAuthorize("hasAuthority('READ_USER')")
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    @PreAuthorize("hasAuthority('READ_USER')")
    public Optional<User> findById(Integer id) {
        return userRepository.findById(id);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('CREATE_USER')")
    public User save(User user) {
        String hashedPass = passwordEncoder.encode(user.getPassword());
        user.setPassword(hashedPass);
        return userRepository.save(user);
    }

    @Override
    @Transactional
    @PreAuthorize("hasAuthority('DELETE_USER')")
    public void deleteById(Integer id) {
        userRepository.deleteById(id);
        userRoleRepository.deleteByUser_Id(id);
    }

    @Override
    public User findByUsername(String username) {
        Optional<User> foundUser = userRepository.findByUsername(username);
        return foundUser.orElseThrow( ()-> new RuntimeException("User not found!") );

    }
}
