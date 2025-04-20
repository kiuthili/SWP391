<%-- 
    Document   : ShopManagerDashboard
    Created on : 02-Mar-2025, 00:52:25
    Author     : ThyLTKCE181577
--%>

<%@page import="java.util.List, java.util.Map"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    List<Map<String, Object>> newProducts = (List<Map<String, Object>>) request.getAttribute("newProducts");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
        <style>
            body {
                display: flex;
            }
            .content {
                flex-grow: 1;
                padding: 12px;
                margin-left: 250px;
            }
            .header {
                position: fixed;
                top: 0;
                left: 260px; 
                right: 10px;
                margin-top: 10px;
                z-index: 1000;
            }
            .card {
                background: linear-gradient(135deg, #ff9a9e, #fad0c4);
                color: white;
                text-align: center;
                border: none;
            }
            .card:hover {
                transform: translateY(-5px);
            }
            .chart-container {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 20px;
            }
            .chart-box {
                width: 32%;
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
            }
            .table-container {
                margin-top: 20px;
            }

            .container{
                margin-top: 15px;
            }

            .table-container1 {
                margin-top: 35px;
            }
            .content {
                display: flex;
                flex-direction: column; 
                align-items: center; 
                margin-top: 60px;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="SidebarDashboard.jsp"></jsp:include>
            <div class="content">
            <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                <div class="container">
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="card p-3">
                                <h5>Total Customers</h5>
                                <h3><%= stats.get("totalCustomers")%> Customers</h3>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card p-3">
                            <h5>Total Products</h5>
                            <h3><%= stats.get("totalProducts")%> Products</h3>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card p-3">
                            <h5>Total Orders</h5>
                            <h3><%= stats.get("totalOrders")%> Orders</h3>
                        </div>
                    </div>
                </div>

                <div class="table-container">
                    <h4>New Products</h4>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Added Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Map<String, Object> product : newProducts) {%>
                            <tr>
                                <td><%= product.get("name")%></td>
                                <td><%= product.get("category")%></td>
                                <td><%= new java.text.DecimalFormat("#,###").format(Double.parseDouble(product.get("price").toString())).replace(",", ".")%></td>
                                <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(product.get("added_date"))%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

                <%
                    List<Map<String, Object>> newCustomers = (List<Map<String, Object>>) request.getAttribute("newCustomers");
                %>

                <div class="table-container1">
                    <h4 >New Customers</h4>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Map<String, Object> customer : newCustomers) {%>
                            <tr>
                                <td><%= customer.get("name")%></td>
                                <td><%= customer.get("email")%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </body>
</html>
