<%-- 
    Document   : CustomerDetailView
    Created on : 25-Feb-2025, 11:05:04
    Author     : kiuth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Customer Details & Purchase History</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #e9ecef;
            }
            .card {
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
            .card-header {
                background-color: #6f42c1;
                color: #fff;
                font-size: 1.25rem;
                text-align: center;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                padding: 1rem;
            }
            .card-body {
                padding: 1.5rem;
            }
            .avatar {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #6f42c1;
            }
            .detail-label {
                font-weight: 600;
            }
            .table thead {
                background-color: #6f42c1;
                color: #fff;
            }
            .btn-back {
                background-color: #6f42c1;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                text-decoration: none;
            }
            .btn-back:hover {
                background-color: #593196;
            }
            .content {
                flex-grow: 1;
                display: flex;
                flex-direction: column;

                margin-left: 250px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="SidebarDashboard.jsp"></jsp:include>

            <div class="content">
            <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                <div class="container my-4">
                    <!-- Customer Details Card -->
                    <div class="card">
                        <div class="card-header">
                            Customer Details
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-md-4 text-center">
                                    <img src="assets/imgs/CustomerAvatar/${customer.getAvatar()}" alt="Avatar" class="avatar mb-3">
                            </div>
                            <div class="col-md-8">
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">ID:</div>
                                    <div class="col-sm-8">${customer.getId()}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">Name:</div>
                                    <div class="col-sm-8">${customer.getFullName()}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">Birthday:</div>
                                    <div class="col-sm-8">${customer.getBirthday()}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">Gender:</div>
                                    <div class="col-sm-8">${customer.getGender()}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">Phone:</div>
                                    <div class="col-sm-8">${customer.getPhoneNumber()}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">Email:</div>
                                    <div class="col-sm-8">${customer.getEmail()}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 detail-label">Created:</div>
                                    <div class="col-sm-8">${customer.getCreateAt()}</div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-4 detail-label">Status:</div>
                                    <div class="col-sm-8">
                                        <span class="badge ${customer.getIsBlock() == 0 ? 'bg-success' : 'bg-danger'}">
                                            ${customer.getIsBlock() == 1 ? 'Deleted' : 'Activate'}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Purchase History Card -->
                <div class="card">
                    <div class="card-header">
                        Purchase History
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty purchaseHistory}">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Order ID</th>
                                            <th>Date</th>
                                            <th>Total Amount</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${purchaseHistory}">
                                            <tr>
                                                <td>${order.orderID}</td>
                                                <td>${order.orderDate}</td>
                                                <td>${order.totalAmount}</td>
                                                <td>${order.status}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                        <c:if test="${empty purchaseHistory}">
                            <p class="text-center mb-0">No purchase history available.</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
