package com.inventory.controller.web;

//import com.inventory.service.CategoryService;
import com.inventory.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/products")
@RequiredArgsConstructor
public class ProductControllerWeb {
    
    private final ProductService productService;
//    private final CategoryService categoryService;
    
    @GetMapping
    public String products(Model model) {
        model.addAttribute("products", productService.getAllProducts());
//        model.addAttribute("categories", categoryService.getAllCategories());
        return "products";
    }
}