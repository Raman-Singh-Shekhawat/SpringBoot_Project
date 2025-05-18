package com.inventory.controller.web;

import com.inventory.service.CustomerService;
import com.inventory.service.ProductService;
import com.inventory.service.SalesInvoiceService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sales-invoices")
@RequiredArgsConstructor
public class SalesInvoiceControllerWeb {
    
    private final SalesInvoiceService salesInvoiceService;
    private final CustomerService customerService;
    private final ProductService productService;
    
    @GetMapping
    public String salesInvoices(Model model) {
        model.addAttribute("salesInvoices", salesInvoiceService.getAllSalesInvoices());
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("products", productService.getAllProducts());
        return "sales-invoices";
    }
}