<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Orders - Inventory Management System</title>
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
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Purchase Orders</h5>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPurchaseOrderModal">
                            <i class="bi bi-plus"></i> Create Purchase Order
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Order #</th>
                                        <th>Vendor</th>
                                        <th>Order Date</th>
                                        <th>Expected Delivery</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${purchaseOrders}" var="po">
                                        <tr>
                                            <td>${po.orderNumber}</td>
                                            <td>${po.vendor.companyName}</td>
                                            <td>${po.orderDate}</td>
                                            <td>${po.expectedDeliveryDate}</td>
                                            <td>$${po.totalAmount}</td>
                                            <td>
                                                <span class="status-badge bg-${po.status == 'PENDING' ? 'warning' : 
                                                                               po.status == 'APPROVED' ? 'info' :
                                                                               po.status == 'RECEIVED' ? 'success' :
                                                                               po.status == 'CANCELLED' ? 'danger' : 'secondary'}">
                                                    ${po.status}
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewPurchaseOrder(${po.id})">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <c:if test="${po.status == 'PENDING'}">
                                                    <button class="btn btn-sm btn-warning" onclick="editPurchaseOrder(${po.id})">
                                                        <i class="bi bi-pencil"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-danger" onclick="cancelPurchaseOrder(${po.id})">
                                                        <i class="bi bi-x-circle"></i>
                                                    </button>
                                                </c:if>
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

    <!-- Add Purchase Order Modal -->
    <div class="modal fade" id="addPurchaseOrderModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Create Purchase Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addPurchaseOrderForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Vendor</label>
                                <select class="form-select" name="vendorId" required>
                                    <c:forEach items="${vendors}" var="vendor">
                                        <option value="${vendor.id}">${vendor.companyName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Expected Delivery Date</label>
                                <input type="date" class="form-control" name="expectedDeliveryDate" required>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Notes</label>
                            <textarea class="form-control" name="notes" rows="2"></textarea>
                        </div>
                        
                        <h6 class="mt-4">Order Items</h6>
                        <div id="orderItems">
                            <div class="order-item border rounded p-3 mb-3">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Product</label>
                                        <select class="form-select" name="items[0].productId" required>
                                            <c:forEach items="${products}" var="product">
                                                <option value="${product.id}">${product.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Quantity</label>
                                        <input type="number" class="form-control" name="items[0].quantity" required>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label class="form-label">Unit Price</label>
                                        <input type="number" class="form-control" name="items[0].unitPrice" step="0.01" required>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Discount %</label>
                                        <input type="number" class="form-control" name="items[0].discountPercentage" step="0.01">
                                    </div>
                                    <div class="col-md-1 mb-3 d-flex align-items-end">
                                        <button type="button" class="btn btn-danger btn-sm" onclick="removeOrderItem(this)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <button type="button" class="btn btn-secondary btn-sm" onclick="addOrderItem()">
                            <i class="bi bi-plus"></i> Add Item
                        </button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="savePurchaseOrder()">Create Order</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewPurchaseOrder(id) {
            // Implement view functionality
        }
        
        function editPurchaseOrder(id) {
            // Implement edit functionality
        }
        
        function cancelPurchaseOrder(id) {
            if (confirm('Are you sure you want to cancel this purchase order?')) {
                // Implement cancel functionality
            }
        }
        
        function addOrderItem() {
            const itemsContainer = document.getElementById('orderItems');
            const itemCount = itemsContainer.children.length;
            
            const itemTemplate = `
                <div class="order-item border rounded p-3 mb-3">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Product</label>
                            <select class="form-select" name="items[${itemCount}].productId" required>
                                <c:forEach items="${products}" var="product">
                                    <option value="${product.id}">${product.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-2 mb-3">
                            <label class="form-label">Quantity</label>
                            <input type="number" class="form-control" name="items[${itemCount}].quantity" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label">Unit Price</label>
                            <input type="number" class="form-control" name="items[${itemCount}].unitPrice" step="0.01" required>
                        </div>
                        <div class="col-md-2 mb-3">
                            <label class="form-label">Discount %</label>
                            <input type="number" class="form-control" name="items[${itemCount}].discountPercentage" step="0.01">
                        </div>
                        <div class="col-md-1 mb-3 d-flex align-items-end">
                            <button type="button" class="btn btn-danger btn-sm" onclick="removeOrderItem(this)">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
            
            itemsContainer.insertAdjacentHTML('beforeend', itemTemplate);
        }
        
        function removeOrderItem(button) {
            button.closest('.order-item').remove();
        }
        
        function savePurchaseOrder() {
            // Implement save functionality
        }
    </script>
</body>
</html>