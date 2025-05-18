<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - Inventory Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;700&family=Source+Sans+Pro:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Source Sans Pro', sans-serif;
            background-color: #f5f5f7;
        }
        
        .navbar-brand {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }
        
        .card {
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .table th {
            font-weight: 600;
        }
        
        .btn-primary {
            background-color: #1A73E8;
            border-color: #1A73E8;
        }
        
        .btn-primary:hover {
            background-color: #1557b0;
            border-color: #1557b0;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Products</h5>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="bi bi-plus"></i> Add Product
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Category</th>
                                        <th>Stock</th>
                                        <th>Price</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${products}" var="product">
                                        <tr>
                                            <td>${product.productCode}</td>
                                            <td>${product.name}</td>
                                            <td>${product.category.name}</td>
                                            <td>${product.currentQuantity}</td>
                                            <td>$${product.sellingPrice}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.currentQuantity <= product.reorderLevel}">
                                                        <span class="badge bg-danger">Low Stock</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">In Stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="editProduct(${product.id})">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.id})">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addProductForm">
                        <div class="mb-3">
                            <label class="form-label">Product Code</label>
                            <input type="text" class="form-control" name="productCode" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Category</label>
                            <select class="form-select" name="categoryId" >
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Purchase Price</label>
                                <input type="number" class="form-control" name="purchasePrice" step="0.01" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Selling Price</label>
                                <input type="number" class="form-control" name="sellingPrice" step="0.01" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Initial Stock</label>
                                <input type="number" class="form-control" name="currentQuantity" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Reorder Level</label>
                                <input type="number" class="form-control" name="reorderLevel" required>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="saveProduct()">Save Product</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editProduct(id) {
            // Implement edit functionality
        }
        
        function deleteProduct(id) {
            if (confirm('Are you sure you want to delete this product?')) {
                // Implement delete functionality
            }
        }
        
		function saveProduct() {
		        const form = document.getElementById('addProductForm');
		        const formData = new FormData(form);
		        const productData = {
		            productCode: formData.get('productCode'),
		            name: formData.get('name'),
		            categoryId: Number(formData.get('categoryId')),
		            description: formData.get('description'),
		            purchasePrice: Number(formData.get('purchasePrice')),
		            sellingPrice: Number(formData.get('sellingPrice')),
		            currentQuantity: Number(formData.get('currentQuantity')),
		            reorderLevel: Number(formData.get('reorderLevel'))
		        };

		        fetch('/api/products', {
		            method: 'POST',
		            headers: {
		                'Content-Type': 'application/json'
		            },
		            body: JSON.stringify(productData)
		        })
		        .then(response => {
		            if (!response.ok) {
		                return response.json().then(err => { throw new Error(err.message || 'Failed to save product'); });
		            }
		            return response.json();
		        })
		        .then(data => {
		            // Close the modal
		            const modal = bootstrap.Modal.getInstance(document.getElementById('addProductModal'));
		            modal.hide();
		            
		            // Refresh the page to show the new product
		            window.location.reload();
		            
		            // Alternatively, you could dynamically append the new product to the table:
		            // appendProductToTable(data);
		        })
		        .catch(error => {
		            alert('Error saving product: ' + error.message);
		        });
		    }

		    // Optional: Function to dynamically append product to table
		    function appendProductToTable(product) {
		        const tableBody = document.querySelector('table tbody');
		        const row = document.createElement('tr');
		        row.innerHTML = `
		            <td>${product.productCode}</td>
		            <td>${product.name}</td>
		            <td>${product.category.name}</td>
		            <td>${product.currentQuantity}</td>
		            <td>$${product.sellingPrice}</td>
		            <td>
		                ${product.currentQuantity <= product.reorderLevel 
		                    ? '<span class="badge bg-danger">Low Stock</span>' 
		                    : '<span class="badge bg-success">In Stock</span>'}
		            </td>
		            <td>
		                <button class="btn btn-sm btn-info" onclick="editProduct(${product.id})">
		                    <i class="bi bi-pencil"></i>
		                </button>
		                <button class="btn btn-sm btn-danger" onclick="deleteProduct(${product.id})">
		                    <i class="bi bi-trash"></i>
		                </button>
		            </td>
		        `;
		        tableBody.appendChild(row);
		    }
    </script>
</body>
</html>