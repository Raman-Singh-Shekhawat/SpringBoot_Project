package com.inventory.controller.web;

import com.inventory.service.ProductService;
import com.inventory.service.PurchaseOrderService;
import com.inventory.service.VendorService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/purchase-orders")	
@RequiredArgsConstructor
public class PurchaseOrderControllerWeb {
    
    private final PurchaseOrderService purchaseOrderService;
    private final VendorService vendorService;
    private final ProductService productService;
    
    @GetMapping
    public String purchaseOrders(Model model) {
        model.addAttribute("purchaseOrders", purchaseOrderService.getAllPurchaseOrders());
        model.addAttribute("vendors", vendorService.getAllVendors());
        model.addAttribute("products", productService.getAllProducts());
        return "purchase-orders";
    }
}