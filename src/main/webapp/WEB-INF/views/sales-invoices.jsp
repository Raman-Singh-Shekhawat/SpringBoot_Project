<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Invoices - Inventory Management System</title>
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
                        <h5 class="mb-0">Sales Invoices</h5>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addSalesInvoiceModal">
                            <i class="bi bi-plus"></i> Create Sales Invoice
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Invoice #</th>
                                        <th>Customer</th>
                                        <th>Date</th>
                                        <th>Due Date</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${salesInvoices}" var="invoice">
                                        <tr>
                                            <td>${invoice.invoiceNumber}</td>
                                            <td>${invoice.customer.companyName}</td>
                                            <td>${invoice.invoiceDate}</td>
                                            <td>${invoice.dueDate}</td>
                                            <td>$${invoice.totalAmount}</td>
                                            <td>
                                                <span class="status-badge bg-${invoice.paymentStatus == 'PAID' ? 'success' : 
                                                                               invoice.paymentStatus == 'PARTIAL' ? 'warning' : 'danger'}">
                                                    ${invoice.paymentStatus}
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="viewInvoice(${invoice.id})">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <c:if test="${invoice.paymentStatus != 'PAID'}">
                                                    <button class="btn btn-sm btn-success" onclick="recordPayment(${invoice.id})">
                                                        <i class="bi bi-cash"></i>
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

    <!-- Add Sales Invoice Modal -->
    <div class="modal fade" id="addSalesInvoiceModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Create Sales Invoice</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addSalesInvoiceForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Customer</label>
                                <select class="form-select" name="customerId" required>
                                    <c:forEach items="${customers}" var="customer">
                                        <option value="${customer.id}">${customer.companyName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Due Date</label>
                                <input type="date" class="form-control" name="dueDate" required>
                            </div>
                        </div>
                        
                        <div id="invoiceItems">
                            <div class="invoice-item border rounded p-3 mb-3">
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
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Unit Price</label>
                                        <input type="number" class="form-control" name="items[0].unitPrice" step="0.01" required>
                                    </div>
                                    <div class="col-md-2 mb-3">
                                        <label class="form-label">Discount %</label>
                                        <input type="number" class="form-control" name="items[0].discountPercentage" step="0.01">
                                    </div>
                                    <div class="col-md-1 mb-3">
                                        <label class="form-label">Tax %</label>
                                        <input type="number" class="form-control" name="items[0].taxPercentage" step="0.01">
                                    </div>
                                    <div class="col-md-1 mb-3 d-flex align-items-end">
                                        <button type="button" class="btn btn-danger btn-sm" onclick="removeInvoiceItem(this)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <button type="button" class="btn btn-secondary btn-sm" onclick="addInvoiceItem()">
                            <i class="bi bi-plus"></i> Add Item
                        </button>
                        
                        <div class="row mt-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Notes</label>
                                <textarea class="form-control" name="notes" rows="2"></textarea>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Additional Discount</label>
                                    <input type="number" class="form-control" name="discountAmount" step="0.01">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Additional Tax</label>
                                    <input type="number" class="form-control" name="taxAmount" step="0.01">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="saveSalesInvoice()">Create Invoice</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Record Payment Modal -->
    <div class="modal fade" id="recordPaymentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Record Payment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="recordPaymentForm">
                        <input type="hidden" name="invoiceId" id="paymentInvoiceId">
                        <div class="mb-3">
                            <label class="form-label">Payment Amount</label>
                            <input type="number" class="form-control" name="amount" step="0.01" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="submitPayment()">Record Payment</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewInvoice(id) {
            window.location.href = `/sales-invoices/${id}`;
        }
        
        function recordPayment(id) {
            document.getElementById('paymentInvoiceId').value = id;
            const modal = new bootstrap.Modal(document.getElementById('recordPaymentModal'));
            modal.show();
        }
        
        function submitPayment() {
            const form = document.getElementById('recordPaymentForm');
            const invoiceId = form.invoiceId.value;
            const amount = form.amount.value;

            fetch(`/api/sales-invoices/${invoiceId}/payment?amount=${amount}`, {
                method: 'POST'
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to record payment');
                }
                return response.json();
            })
            .then(() => {
                const modal = bootstrap.Modal.getInstance(document.getElementById('recordPaymentModal'));
                modal.hide();
                window.location.reload();
            })
            .catch(error => alert('Error recording payment: ' + error.message));
        }
        
        function addInvoiceItem() {
            const itemsContainer = document.getElementById('invoiceItems');
            const itemCount = itemsContainer.children.length;
            
            const itemTemplate = `
                <div class="invoice-item border rounded p-3 mb-3">
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
                        <div class="col-md-2 mb-3">
                            <label class="form-label">Unit Price</label>
                            <input type="number" class="form-control" name="items[${itemCount}].unitPrice" step="0.01" required>
                        </div>
                        <div class="col-md-2 mb-3">
                            <label class="form-label">Discount %</label>
                            <input type="number" class="form-control" name="items[${itemCount}].discountPercentage" step="0.01">
                        </div>
                        <div class="col-md-1 mb-3">
                            <label class="form-label">Tax %</label>
                            <input type="number" class="form-control" name="items[${itemCount}].taxPercentage" step="0.01">
                        </div>
                        <div class="col-md-1 mb-3 d-flex align-items-end">
                            <button type="button" class="btn btn-danger btn-sm" onclick="removeInvoiceItem(this)">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
            
            itemsContainer.insertAdjacentHTML('beforeend', itemTemplate);
        }
        
        function removeInvoiceItem(button) {
            button.closest('.invoice-item').remove();
        }
        
        function saveSalesInvoice() {
            const form = document.getElementById('addSalesInvoiceForm');
            const formData = new FormData(form);
            const invoiceData = {
                customerId: formData.get('customerId'),
                dueDate: formData.get('dueDate'),
                notes: formData.get('notes'),
                discountAmount: formData.get('discountAmount'),
                taxAmount: formData.get('taxAmount'),
                items: []
            };

            // Get all invoice items
            const itemDivs = document.querySelectorAll('.invoice-item');
            itemDivs.forEach((div, index) => {
                invoiceData.items.push({
                    productId: formData.get(`items[${index}].productId`),
                    quantity: parseInt(formData.get(`items[${index}].quantity`)),
                    unitPrice: parseFloat(formData.get(`items[${index}].unitPrice`)),
                    discountPercentage: parseFloat(formData.get(`items[${index}].discountPercentage`) || 0),
                    taxPercentage: parseFloat(formData.get(`items[${index}].taxPercentage`) || 0)
                });
            });

            fetch('/api/sales-invoices', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(invoiceData)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw new Error(err.message || 'Failed to save invoice'); });
                }
                return response.json();
            })
            .then(() => {
                const modal = bootstrap.Modal.getInstance(document.getElementById('addSalesInvoiceModal'));
                modal.hide();
                window.location.reload();
            })
            .catch(error => alert('Error saving invoice: ' + error.message));
        }
    </script>
</body>
</html>