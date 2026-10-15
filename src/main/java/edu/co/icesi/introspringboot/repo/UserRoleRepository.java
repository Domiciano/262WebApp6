package edu.co.icesi.introspringboot.repo;

import edu.co.icesi.introspringboot.entity.UserRole;
import edu.co.icesi.introspringboot.entity.keys.UserRoleId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface UserRoleRepository extends JpaRepository<UserRole, UserRoleId> {

    List<UserRole> findByUser_Id(Integer userId);

    @Transactional
    void deleteByUser_Id(Integer userId);

    @Transactional
    void deleteByRole_Id(Integer roleId);
}
