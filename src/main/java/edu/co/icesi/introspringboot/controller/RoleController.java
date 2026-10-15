package edu.co.icesi.introspringboot.controller;

import edu.co.icesi.introspringboot.service.PermissionService;
import edu.co.icesi.introspringboot.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;
    @Autowired
    private PermissionService permissionService;

    @GetMapping
    public String listRoles(Model model) {
        model.addAttribute("roles", roleService.findAll());
        return "role/index";
    }

    @GetMapping("/{id}/permissions")
    public String rolePermissions(
            Model model,
            @PathVariable Integer id,
            @RequestParam(required = false) String status
    ) {
        if ("saved".equals(status)) {
            model.addAttribute("message", "Permisos actualizados correctamente");
        }
        model.addAttribute("assignedPermissionIds", roleService.findPermissionIdsByRoleId(id));
        model.addAttribute("role", roleService.findById(id).orElseThrow());
        model.addAttribute("permissions", permissionService.findAll());
        return "role/edit";
    }

    @PostMapping("/{id}/permissions")
    public String updatePermissions(
            @PathVariable Integer id,
            @RequestParam(required = false) List<Integer> permissionIds
    ) {
        roleService.updatePermissions(id, permissionIds == null ? List.of() : permissionIds);
        return "redirect:/role/" + id + "/permissions?status=saved";
    }
}
