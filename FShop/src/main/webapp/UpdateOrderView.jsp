<%-- 
    Document   : UpdateOrderView
    Created on : Mar 24, 2025, 6:37:16 AM
    Author     : HP
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html> 
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Details</title>

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="assets/css/orderDetail.css">

        <!-- CSS bổ sung để điều chỉnh thứ tự chồng -->
        <style>
            /* Bọc header với z-index thấp */
            .fixed-header {
                position: fixed;
                top: 0;
                left: 250px; /* Điều chỉnh để tránh che sidebar */
                width: calc(100% - 250px); /* Chiều rộng trừ đi sidebar */
                /*background-color: white;*/
                z-index: 1050;
                padding: 10px 20px;
                /*box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);*/
            }

            /* Bọc sidebar với z-index cao hơn để chồng lên header */
            .sidebar-container {
                position: relative;
                z-index: 2000;
            }

            .main-layout {
                display: flex;
            }

            .main-content {
                flex-grow: 1;
                margin-left: 250px; /* Khoảng cách để không bị chồng lên sidebar */
                margin-top: 120px;
                padding: 20px;
            }

            .order-layout {
                display: flex;
                gap: 20px;
            }

            .left-section, .right-section {
                flex: 1;
            }

            .order-info, .customer-info, .manage-order {
                background-color: #fff;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .manage-order {
                margin-top: 20px;
            }

            .manage-order select {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 5px;
                border: 1px solid #ddd;
                font-size: 16px;
            }

            .manage-order button {
                width: 100%;
                padding: 12px;
                background-color: #28a745;
                border: none;
                border-radius: 5px;
                color: white;
                font-size: 16px;
            }

            .manage-order button:hover {
                background-color: #218838;
            }

            /* Điều chỉnh khoảng cách giữa các thành phần */
            .dropdown {
                margin-bottom: 20px; /* Thêm khoảng cách giữa dropdown và nút update */
            }

            .order-details {
                margin-top: 15px;
            }

            .order-details span {
                display: block;
                margin-bottom: 8px;
            }

            .status-1 {
                color: #ffeb3b;
            }

            .status-2 {
                color: #ff9800;
            }

            .status-3 {
                color: #2196f3;
            }

            .status-4 {
                color: #4caf50;
            }

            .status-5 {
                color: #f44336;
            }

        </style>
    </head>
    <body>
        <div class="fixed-header"><jsp:include page="HeaderDashboard.jsp"></jsp:include>
                <p></p>

            </div>

            <div class="main-layout">
                <div class="sidebar-container">
                <jsp:include page="SidebarDashboard.jsp"></jsp:include>
                </div>

                <div class="main-content">
                    <h2><i class="fa-solid fa-receipt"></i> Update Order</h2>
                    <div class="container">
                    <c:if test="${param.success == 'created'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> Update Order successfully!
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${param.success == 'deleted'}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fa-solid fa-circle-check me-2"></i> Update Order Unsuccessfully
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <div class="order-layout">
                        <!-- Left: Order Information & Items -->
                        <div class="left-section">
                            <div class="order-info">
                                <h3><i class="fa-solid fa-info-circle"></i> Order Information</h3>
                                <p><strong>Order ID:</strong> <span>${data.orderID}</span></p>
                                <p><strong>Order Date:</strong> <span>${data.orderDate}</span></p>
                                <p><strong>Order Status:</strong> <span class="status-${data.status}">
                                        <c:if test="${data.status == 1}">Waiting For Acceptance</c:if>
                                        <c:if test="${data.status == 2}">Packaging</c:if>
                                        <c:if test="${data.status == 3}">Waiting For Delivery</c:if>
                                        <c:if test="${data.status == 4}">Delivered</c:if>
                                        <c:if test="${data.status == 5}">Cancel</c:if>
                                        </span>
                                    </p>
                                    <p><strong>Total Amount:</strong> <span>${data.totalAmount}</span></p>
                                <p><strong>Discount:</strong> <span>${data.discount}</span></p>
                            </div>

                            <h3><i class="fa-solid fa-box"></i> Order Items</h3>
                            <div class="order-details">
                                <c:forEach items="${dataDetail}" var="detail">
                                    <div>
                                        <span><i class="fa-solid fa-cube"></i> ${detail.productName}</span>
                                        <span><i class="fa-solid fa-cart-plus"></i> ${detail.quantity}</span>
                                        <span><i class="fa-solid fa-dollar-sign"></i> ${detail.price}</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Right: Customer Info & Manage Order -->
                        <div class="right-section">
                            <div class="customer-info">
                                <h3><i class="fa-solid fa-user"></i> Customer Information</h3>
                                <p><strong>Name:</strong> <span>${data.fullName}</span></p>
                                <p><strong>Phone:</strong> <span>${data.phone}</span></p>
                                <p><strong>Address:</strong> <span>${data.address}</span></p>
                            </div>

                            <div class="manage-order">
                                <h3><i class="fa-solid fa-cogs"></i> Manage Order</h3>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">
                                        ${errorMessage}
                                    </div>
                                </c:if>

                                <form action="UpdateOrderServlet" method="POST">
                                    <input type="hidden" name="orderID" value="${data.orderID}" />
                                    <div class="dropdown">
                                        <!--<select name="update" id="orderStatus" onchange="disableOptions()">-->
                                        <select name="update" id="orderStatus" data-current="${data.status}">

                                            <option value="1" <c:if test="${data.status == 1}">selected</c:if>>Waiting For Acceptance</option>
                                            <option value="2" <c:if test="${data.status == 2}">selected</c:if>>Packaging</option>
                                            <option value="3" <c:if test="${data.status == 3}">selected</c:if>>Waiting For Delivery</option>
                                            <option value="4" <c:if test="${data.status == 4}">selected</c:if>>Delivered</option>
                                            <option value="5" <c:if test="${data.status == 5}">selected</c:if>>Cancel</option>
                                            </select>
                                        </div>
                                        <!--<button type="submit" class="btn btn-success"><i class="fa-solid fa-pen"></i> Update</button>-->
                                        <button type="submit" class="btn btn-success" 
                                        <c:if test="${data.status == 4 || data.status == 5}">disabled</c:if>>
                                        <i class="fa-solid fa-pen"></i> Update
                                    </button>

                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!-- JavaScript -->
        <script>

            function disableOptions() {
                const select = document.getElementById('orderStatus');
                const currentStatus = parseInt(select.getAttribute('data-current')); // Trạng thái hiện tại
                const options = select.options;

                // Reset tất cả
                for (let i = 0; i < options.length; i++) {
                    options[i].disabled = false;
                }

                // Logic theo từng trạng thái hiện tại
                switch (currentStatus) {
                    case 1:
                        // Trạng thái 5 (Cancel) chỉ cho phép khi đang ở 1 ⇒ hợp lệ
                        break; // không disable gì cả
                    case 2:
                        options[0].disabled = true; // Không được chọn lại trạng thái 1
                        break;
                    case 3:
                        options[0].disabled = true; // Không được chọn lại trạng thái 1
                        options[1].disabled = true; // Không được chọn lại trạng thái 2
                        break;
                    case 4:
                        options[0].disabled = true;
                        options[1].disabled = true;
                        options[2].disabled = true;
                        options[4].disabled = true; // Cancel
                        break;
                    case 5:
                        options[0].disabled = true;
                        options[1].disabled = true;
                        options[2].disabled = true;
                        options[3].disabled = true;
                        break;
                }

                // Ngoài ra, nếu trạng thái hiện tại khác 1 thì không cho phép chọn Cancel (5)
                if (currentStatus !== 1) {
                    options[4].disabled = true;
                }
            }

// Gọi disableOptions() khi trang tải
//            document.addEventListener('DOMContentLoaded', function () {
//                disableOptions();
//            });
            document.addEventListener('DOMContentLoaded', function () {
                disableOptions();
            });


        </script>
    </body>
</html>

