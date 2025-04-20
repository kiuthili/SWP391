<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order List</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/orderlist.css">

        <!-- CSS bổ sung -->
        <style>
            /* Cố định Header */
            .fixed-header {
                position: fixed;
                top: 0;
                left: 260px; /* Điều chỉnh để tránh che sidebar */
                width: calc(100% - 250px); /* Chiều rộng trừ đi sidebar */
                background-color: white;
                z-index: 1050;
                padding: 10px 10px;
                /*box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);*/
            }

            /* Cố định Sidebar */
            .sidebar-container {
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                height: 100vh;
                background-color: white;
                z-index: 1100;
                padding-top: 60px; /* Tạo khoảng cách tránh bị header che */
            }

            /* Điều chỉnh khoảng cách để tránh che nội dung */
            .main-layout {
                display: flex;
            }

            .content {
                flex-grow: 1;
                margin-left: 260px; /* Khoảng cách để không bị chồng lên sidebar */
                margin-top: 160px;
                padding: 10px;
            }

            /* Căn chỉnh layout header */
            .header-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;
                gap: 20px;
            }

            /* Căn chỉnh phần tìm kiếm */
            .search-container {
                display: flex;
                align-items: center;
                gap: 10px;
                flex-grow: 1; /* Giúp phần tìm kiếm chiếm không gian linh hoạt */
                max-width: 600px;
            }

            .search-container input {
                flex: 1;
            }

            /* Đưa tiêu đề về phía bên phải */
            .header-title {
                white-space: nowrap;
                font-size: 1.5rem;
                font-weight: bold;
            }

            .search-container {
                display: flex;
                align-items: center;
                width: 100%;
                max-width: 300px; /* Giảm kích thước tối đa */
                background: white;
                border-radius: 13px; /* Bo góc mềm hơn */
                overflow: hidden;
                border: 2px solid #7D69FF;
                margin-bottom: 15px;
                margin-top: 10px;
            }

            .search-input {
                flex: 1;
                border: none;
                outline: none;
                padding: 8px 12px; /* Giảm padding để nhỏ hơn */
                font-size: 14px; /* Giảm kích thước chữ */
                color: #555;
            }

            .search-button {
                border: none;
                padding: 8px 12px; /* Giảm padding của nút */
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 14px;
            }

            .search-button:hover {
                background: #6454cc;
            }

            /* Định dạng bảng */
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 30px;
            }

            .order-table th, .order-table td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }

            .order-table th {
                background-color: #f5f5f5;
                font-weight: bold;
            }

            .order-status {
                text-align: center;
            }

            .status {
                padding: 5px 10px;
                border-radius: 5px;
            }

            .waiting {
                background-color: #ffeb3b;
            }

            .packaging {
                background-color: #ff9800;
            }

            .waiting-delivery {
                background-color: #2196f3;
            }

            .delivered {
                background-color: #4caf50;
                color: white;
            }

            .cancelled {
                background-color: #f44336;
                color: white;
            }
            .notifi {
                font-weight: bold;
                margin: 20px
            }
        </style>
    </head>
    <body>
        <div class="sidebar-container">
            <jsp:include page="SidebarDashboard.jsp"></jsp:include>
            </div>

            <div class="main-layout">
                <div class="fixed-header">
                <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                    <form action="ViewOrderListServlet" method="GET" class="search-container">
                        <input type="text" name="search" id="searchInput" value="${searchQuery}" 
                           placeholder="Search by Name, Phone..." class="search-input">
                    <button type="submit" class="search-button">
                        🔍
                    </button>
                </form>
                <h3  font-weight="Bold">ORDER</h3>
            </div>

            <div class="content">
                <c:if test="${param.success == 'created'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> Updating Order successfully!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

               
                <c:if test="${empty data}">
                    <h3 class="notifi" >Have No Order</h3>
                </c:if>

                <div class="order-container">
                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Total Amount</th>
                                <th>Order Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${data}" var="order">
                                <tr>
                                    <td>#${order.orderID}</td>
                                    <td>${order.fullName}</td>
                                    <td>${order.phone}</td>
                                    <td>${order.address}</td>
                                    <td>${order.totalAmount}</td>
                                    <td>${order.orderDate}</td>
                                    <td class="order-status">
                                        <c:choose>
                                            <c:when test="${order.status == 1}">
                                                <span class="status waiting">
                                                    <i class="fa-solid fa-hourglass-half"></i> Waiting For Acceptance
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 2}">
                                                <span class="status packaging">
                                                    <i class="fa-solid fa-box"></i> Packaging
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 3}">
                                                <span class="status waiting-delivery">
                                                    <i class="fa-solid fa-truck"></i> Waiting For Delivery
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 4}">
                                                <span class="status delivered">
                                                    <i class="fa-solid fa-check-circle"></i> Delivered
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status cancelled">
                                                    <i class="fa-solid fa-times-circle"></i> Cancelled
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <a href="ViewOrderDetailServlet?orderID=${order.orderID}" class="btn btn-outline-info btn-sm">
                                                <i class="fa-solid fa-eye"></i> View Details
                                            </a>
                                            <a href="UpdateOrderServlet?orderID=${order.orderID}" class="btn btn-primary btn-sm">
                                                <i class="fa-solid fa-pen-to-square"></i> Update Order
                                            </a>
                                        </div>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
