package com.inventory.controller.web;

import com.inventory.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/customers")
@RequiredArgsConstructor
public class CustomerControllerWeb {
    
    private final CustomerService customerService;
    
    @GetMapping
    public String customers(Model model) {
        model.addAttribute("customers", customerService.getAllCustomers());
        return "customers";
    }
}