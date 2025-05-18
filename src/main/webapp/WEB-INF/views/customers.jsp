<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers - Inventory Management System</title>
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
                        <h5 class="mb-0">Customers</h5>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                            <i class="bi bi-plus"></i> Add Customer
                        </button>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Code</th>
                                        <th>Company Name</th>
                                        <th>Contact Person</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${customers}" var="customer">
                                        <tr>
                                            <td>${customer.customerCode}</td>
                                            <td>${customer.companyName}</td>
                                            <td>${customer.contactPerson}</td>
                                            <td>${customer.email}</td>
                                            <td>${customer.phone}</td>
                                            <td>
                                                <button class="btn btn-sm btn-info" onclick="editCustomer(${customer.id})">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <button class="btn btn-sm btn-danger" onclick="deleteCustomer(${customer.id})">
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

    <!-- Add Customer Modal -->
    <div class="modal fade" id="addCustomerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addCustomerForm">
                        <div class="mb-3">
                            <label class="form-label">Customer Code</label>
                            <input type="text" class="form-control" name="customerCode" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Company Name</label>
                            <input type="text" class="form-control" name="companyName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contact Person</label>
                            <input type="text" class="form-control" name="contactPerson" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <textarea class="form-control" name="address" rows="3"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">City</label>
                                <input type="text" class="form-control" name="city">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">State</label>
                                <input type="text" class="form-control" name="state">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Country</label>
                                <input type="text" class="form-control" name="country">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Postal Code</label>
                                <input type="text" class="form-control" name="postalCode">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="saveCustomer()">Save Customer</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editCustomer(id) {
            fetch(`/api/customers/${id}`)
                .then(response => response.json())
                .then(customer => {
                    // Populate form with customer data
                    const form = document.getElementById('addCustomerForm');
                    form.customerCode.value = customer.customerCode;
                    form.companyName.value = customer.companyName;
                    form.contactPerson.value = customer.contactPerson;
                    form.email.value = customer.email;
                    form.phone.value = customer.phone;
                    form.address.value = customer.address || '';
                    form.city.value = customer.city || '';
                    form.state.value = customer.state || '';
                    form.country.value = customer.country || '';
                    form.postalCode.value = customer.postalCode || '';
                    
                    // Show modal
                    const modal = new bootstrap.Modal(document.getElementById('addCustomerModal'));
                    modal.show();
                })
                .catch(error => alert('Error loading customer data: ' + error.message));
        }
        
        function deleteCustomer(id) {
            if (confirm('Are you sure you want to delete this customer?')) {
                fetch(`/api/customers/${id}`, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        throw new Error('Failed to delete customer');
                    }
                })
                .catch(error => alert('Error deleting customer: ' + error.message));
            }
        }
        
        function saveCustomer() {
            const form = document.getElementById('addCustomerForm');
            const formData = new FormData(form);
            const customerData = Object.fromEntries(formData.entries());

            fetch('/api/customers', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(customerData)
            })
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw new Error(err.message || 'Failed to save customer'); });
                }
                return response.json();
            })
            .then(() => {
                const modal = bootstrap.Modal.getInstance(document.getElementById('addCustomerModal'));
                modal.hide();
                window.location.reload();
            })
            .catch(error => alert('Error saving customer: ' + error.message));
        }
    </script>
</body>
</html>