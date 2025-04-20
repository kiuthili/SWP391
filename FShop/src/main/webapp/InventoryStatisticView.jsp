<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory Statistic</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom@1.0.1/dist/chartjs-plugin-zoom.min.js"></script>
        <style>
            body {
                display: flex;
            }

            .sidebar {
                width: 250px;
                height: 97vh;
                background: #FFFFFF;
                color: black;
                padding-top: 20px;
                box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
                transform: translateZ(0);
                position: relative;
                z-index: 10;
                border-radius: 10px;
                margin-top: 10px;
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
                width: 90%;
                font-weight: bold;
                border-top-right-radius: 10px;
                border-bottom-right-radius: 10px;
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }

            .content {
                flex-grow: 1;
                padding: 12px;
                margin-left: 250px;
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

            .icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
            }

            .logo-side-bar {
                margin-left: 5%;
                margin-bottom: 3%;
            }

            .rounded-table {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
            }


            /*Table*/
            .table-container {
                max-height: 400px;
                overflow-y: auto;
                border-radius: 10px;
                border: 1px solid #ddd;
            }
            .table-container thead {
                position: sticky;
                top: 0;
                background-color: #f8f9fa;
                z-index: 10;
            }

            .table-navigate {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            /* Search */

            .search-form {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .search-form input {
                border-radius: 25px;
                padding: 10px 15px;
                border: 1px solid #ccc;
                width: 250px;
                font-size: 14px;
                margin-right: 10px;
                outline: none;
            }

            .search-form button {
                background-color: #007bff;
                border: none;
                border-radius: 25px;
                padding: 10px 15px;
                cursor: pointer;
            }

            .search-form button:hover {
                background-color: #0056b3;
            }

            .search-form input:focus {
                border-color: #0056b3;
            }
            /*Chart*/

            .chart-container {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 15px;
                background-color: #fff;
                box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.15);
                margin: 10px auto;
                width: 80%;
            }

            canvas {
                max-width: 100%;
                height: 100%;
            }

            .hearderChart{
                text-align: center;
            }


            /* Nút */

            .nav-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
                margin-top: 10px;
            }
            .nav-buttons button {
                border: none;
                background: transparent;
                font-size: 24px;
                cursor: pointer;
                color: #4F8CF7;
            }
            .nav-buttons button:hover {
                color: #8C52FF;
            }
        </style>
    </head>
    <body>
        <jsp:include page="SidebarDashboard.jsp"></jsp:include>
            <div class="content">
            <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                <div class="container mt-2">   

                    <div class="table-navigate">
                        <form action="SearchInventoryServlet" method="GET" class="search-form">
                            <input type="text" name="query" value="${searchQuery}" placeholder="Search by Name...">
                        <button type="submit"><i class="bx bx-search"></i></button>
                    </form>
                </div>
                <div class="table-container rounded-table">                         
                    <table class="table table-striped">
                        <thead class="table-success">
                            <tr>
                                <th>Category Name</th>
                                <th>Brand Name</th>
                                <th>Model</th>
                                <th>Product Name</th>
                                <th>Stock Quantity</th>
                                <th>Supplier</th>
                                <th>Import Date</th>
                                <th>Import Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listI}" var="i">
                                <tr>
                                    <td>${i.categoryName}</td>
                                    <td>${i.brandName}</td>
                                    <td>${i.model}</td>
                                    <td>${i.fullName}</td>
                                    <td>${i.stockQuantity}</td>
                                    <td>${i.supplierName}</td>
                                    <td><fmt:formatDate value="${i.importDate}" pattern="dd/MM/yyyy" /></td>
                                    <td>${i.productImportPrice}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="row mt-4 g-2">
                    <div class="col-md-5 chart-container">
                        <h5 class="hearderChart">Inventory - Laptops</h5>
                        <canvas id="inventoryLaptopChart" class="inventory-laptop-chart"></canvas>
                        <div class="nav-buttons">
                            <button id="prevPageLaptop"><i class='bx bx-chevron-left'></i></button>
                            <button id="nextPageLaptop"><i class='bx bx-chevron-right'></i></button>
                        </div>
                    </div>
                    <div class="col-md-5 chart-container">
                        <h5 class="hearderChart">Inventory - Phones</h5>
                        <canvas id="inventoryPhoneChart"></canvas>
                        <div class="nav-buttons">
                            <button id="prevPagePhone"><i class='bx bx-chevron-left'></i></button>
                            <button id="nextPagePhone"><i class='bx bx-chevron-right'></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                //Laptop
                var productNamesLaptop = [];
                var stockQuantitiesLaptop = [];
                <c:forEach items="${listInventoryLaptop}" var="item">
                productNamesLaptop.push('${item.modelName}');
                stockQuantitiesLaptop.push('${item.stockQuantity}');
                </c:forEach>

                var currentPage = 0;
                var itemsPerPage = 4;

                function updateChart() {
                    var start = currentPage * itemsPerPage;
                    var end = start + itemsPerPage;
                    var pagedLabels = productNamesLaptop.slice(start, end);
                    var pagedData = stockQuantitiesLaptop.slice(start, end);

                    while (pagedLabels.length < itemsPerPage) {
                        pagedLabels.push(" ");
                        pagedData.push(0);
                    }

                    inventoryLaptopChart.data.labels = pagedLabels;
                    inventoryLaptopChart.data.datasets[0].data = pagedData;
                    inventoryLaptopChart.update();
                }

                var ctx = document.getElementById("inventoryLaptopChart").getContext("2d");
                var inventoryLaptopChart = new Chart(ctx, {
                    type: "bar",
                    data: {
                        labels: [],
                        datasets: [{
                                label: "Inventory Laptop",
                                data: [],
                                backgroundColor: '#75A05C'
                            }]
                    }
                });

                updateChart();

                document.getElementById("prevPageLaptop").addEventListener("click", function () {
                    if (currentPage > 0) {
                        currentPage--;
                        updateChart();
                    }
                });

                document.getElementById("nextPageLaptop").addEventListener("click", function () {
                    if ((currentPage + 1) * itemsPerPage < productNamesLaptop.length) {
                        currentPage++;
                        updateChart();
                    }
                });

                // Phone
                var productNamesPhone = [];
                var stockQuantitiesPhone = [];
                <c:forEach items="${listInventoryPhone}" var="item">
                productNamesPhone.push('${item.modelName}');
                stockQuantitiesPhone.push('${item.stockQuantity}');
                </c:forEach>
                var currentPagePhone = 0;
                var itemsPerPagePhone = 4;
                function updatePhoneChart() {
                    var start = currentPagePhone * itemsPerPagePhone;
                    var end = start + itemsPerPagePhone;
                    var pagedLabelsPhone = productNamesPhone.slice(start, end);
                    var pagedDataPhone = stockQuantitiesPhone.slice(start, end);
                    while (pagedLabelsPhone.length < itemsPerPagePhone) {
                        pagedLabelsPhone.push(" ");
                        pagedDataPhone.push(0);
                    }
                    inventoryPhoneChart.data.labels = pagedLabelsPhone;
                    inventoryPhoneChart.data.datasets[0].data = pagedDataPhone;
                    inventoryPhoneChart.update();
                }

                var ctxPhone = document.getElementById("inventoryPhoneChart").getContext("2d");
                var inventoryPhoneChart = new Chart(ctxPhone, {
                    type: "bar",
                    data: {
                        labels: [],
                        datasets: [{
                                label: "Inventory Phone",
                                data: [],
                                backgroundColor: '#2596be'

                            }]
                    }
                });

                updatePhoneChart();

                document.getElementById("prevPagePhone").addEventListener("click", function () {
                    if (currentPagePhone > 0) {
                        currentPagePhone--;
                        updatePhoneChart();
                    }
                });

                document.getElementById("nextPagePhone").addEventListener("click", function () {
                    if ((currentPagePhone + 1) * itemsPerPagePhone < productNamesPhone.length) {
                        currentPagePhone++;
                        updatePhoneChart();
                    }
                });
            </script>
        </div>
    </body>
</html>
