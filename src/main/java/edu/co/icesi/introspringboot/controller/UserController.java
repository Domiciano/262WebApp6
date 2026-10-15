package edu.co.icesi.introspringboot.controller;

import edu.co.icesi.introspringboot.entity.User;
import edu.co.icesi.introspringboot.service.RoleService;
import edu.co.icesi.introspringboot.service.UserRoleService;
import edu.co.icesi.introspringboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private UserRoleService userRoleService;

    @GetMapping
    public String listUsers(
            Model model,
            @RequestParam(required = false) String status
    ) {
        if ("created".equals(status)) {
            model.addAttribute("message", "Usuario creado correctamente");
        }
        model.addAttribute("users", userService.findAll());
        return "user/index";
    }

    @GetMapping("/new")
    public String newUser(Model model) {
        model.addAttribute("user", new User());
        return "user/new";
    }

    @PostMapping
    public String createUser(@ModelAttribute User user) {
        userService.save(user);
        return "redirect:/user?status=created";
    }

    @PostMapping("/{id}/delete")
    public String deleteUser(@PathVariable Integer id) {
        userService.deleteById(id);
        return "redirect:/user";
    }

    @GetMapping("/{id}/roles")
    public String userRoles(
            Model model,
            @PathVariable Integer id,
            @RequestParam(required = false) String status
    ) {
        if ("saved".equals(status)) {
            model.addAttribute("message", "Roles actualizados correctamente");
        }
        model.addAttribute("assignedRoleIds", userRoleService.findRoleIdsByUserId(id));
        model.addAttribute("user", userService.findById(id).orElseThrow());
        model.addAttribute("roles", roleService.findAll());
        return "user/roles";
    }

    @PostMapping("/{id}/roles")
    public String assignRoles(
            @PathVariable Integer id,
            @RequestParam(required = false) List<Integer> roleIds
    ) {
        userRoleService.assignRoles(id, roleIds == null ? List.of() : roleIds);
        return "redirect:/user/" + id + "/roles?status=saved";
    }

    @GetMapping("/login")
    public String login(){
        return "user/login";
    }


}
