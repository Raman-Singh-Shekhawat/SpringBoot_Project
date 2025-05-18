package com.inventory.controller.web;

import com.inventory.service.VendorService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vendors")
@RequiredArgsConstructor
public class VendorControllerWeb {
    
    private final VendorService vendorService;
    
    @GetMapping
    public String vendors(Model model) {
        model.addAttribute("vendors", vendorService.getAllVendors());
        return "vendors";
    }
}