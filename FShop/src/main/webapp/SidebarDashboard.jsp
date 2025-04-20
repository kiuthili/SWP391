<%-- 
    Document   : WarehouseDashboard
    Created on : Feb 27, 2025, 12:28:28 PM
    Author     : KienBTCE180180
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>F Shop</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <style>
            body {
                display: flex;

            }

            .sidebar {
                width: 250px;
                height: 98%;
                background: #FFFFFF;
                color: black;
                padding-top: 20px;
                box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
                transform: translateZ(0);
                position: relative;
                border-radius: 10px;
                margin-top: 10px;
                position: fixed;
            }

            .sidebar a {
                color: #7A7D90;
                text-decoration: none;
                padding: 10px;
                display: block;
            }

            .sidebar a:hover {
                background: #7D69FF;
                color: white;
                width: 100%;
                font-weight: bold;

                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }

            .header {
                display: flex;
                justify-content: right;
                align-items: center;
                padding: 10px;
                background: #FFFFFF;
                box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
                border-radius: 10px;
                height: 85px;
            }

            .logo-side-bar {
                margin-left: 5%;
                margin-bottom: 3%;
            }


        </style>
    </head>
    <body>
        <div class="sidebar">
            <img src="assets/imgs/Dashboard/Group 1521.svg" class="logo-side-bar">
            <c:if test="${sessionScope.employee.getRoleId() == 1}">
                <h6 style="margin-left: 60px;  color: #7A7D90;">Admin</h6>
                <a href="StatisticManagementServlet">Statistic Management</a>
                <a href="ViewEmployeeServlet">Employee Management</a>              
            </c:if>

            <c:if test="${sessionScope.employee.getRoleId() == 2}">
                <h6>
                    <a href="ShopDashboardServlet">
                        <i class="fas fa-store"></i> Shop Management
                    </a>
                </h6>
                <a href="CustomerListServlet">
                    <i class="fas fa-users"></i> Customer Management
                </a>
                <a href="ProductListServlet">
                    <i class="fas fa-box-open"></i> Product Management
                </a>
                <a href="ProductStatisticServlet">
                    <i class="fas fa-chart-bar"></i> Product Statistic
                </a>
            </c:if>

            <c:if test="${sessionScope.employee.getRoleId() == 3}">
                <h6><a href="ViewOrderListServlet"> <i class="fas fa-box-open"></i>Order Management</a></h6>
                <a href="ViewListNewFeedbackServlet"><i class="bi bi-chat-left-text"></i>Feedback Management</a>
<!--                <a href="ViewOrderListServlet">
                    <i class="fas fa-box-open"></i>Order</a>-->
                    <a href="ViewVoucherListServlet"> <i class="fa-solid fa-ticket"></i>
                    Voucher Management</a>
                <a href="CustomerListServlet"> <i class="bi bi-person"></i>
                    Customer Management</a>
                <a href="DeleteOrder.jsp"><i class="bi bi-trash"></i> Delete Order</a>
            </c:if>
            <c:if test="${sessionScope.employee.getRoleId() == 4}">
                <h6><a href="Warehouse"><i class="fas fa-store"></i> Warehouse Management</a></h6>
                <a href="ImportOrder"><i class="fas fa-box-open"></i> Import Stock Management</a>
                <a href="Supplier"><i class="fas fa-users"></i> Supplier Management</a>
                <!--<a href="#">Product Management</a>-->
                <a href="ImportStatistic"><i class="fas fa-chart-bar"></i> Statistic Management</a>
                <a href="#" class="export-btn" onclick="document.getElementById('exportForm').submit(); return false;"><i class="bi bi-download"></i> Export to Excel</a>
<form id="exportForm" action="ExportStock" method="POST" style="display: none;"></form>

            </c:if>
            <a style="margin-top: auto; color: red;" href="Logout" onclick="return confirm('Are you sure to logout?')"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
        <script>

            function toggleDropdown() {
                var dropdownMenu = event.target.nextElementSibling;
                dropdownMenu.style.display = (dropdownMenu.style.display === "block") ? "none" : "block";
            }

            function confirmLogout() {
                if (confirm("Are you sure you want to log out?")) {
                    fetch('<%= request.getContextPath()%>/Logout', {
                        method: 'GET'
                    }).then(response => {
                        if (response.redirected) {
                            window.location.href = response.url;
                        }
                    }).catch(error => console.error('Logout failed:', error));
                }
            }
        </script>
    </body>
</html>