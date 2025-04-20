<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Revenue Statistic</title>
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

            /*Table*/

            .rounded-table {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
            }

            .table-container {
                height: 300px;
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

            /*Filter*/

            .filter-form {
                display: flex;
                justify-content: left;
                align-items: center;
                margin-top: 20px;
                padding: 10px;
                border-radius: 20px;
            }

            .filter-form select, .filter-form button {
                border-radius: 25px;
                padding: 12px 20px;
                font-size: 16px;
                border: 1px solid #ddd;
                margin-right: 10px;
            }

            .filter-form select {
                width: 200px;
                background-color: #fff;
                color: #555;
                transition: border-color 0.3s ease;
            }

            .filter-form select:focus {
                outline: none;
                border-color: #007bff;
            }

            .filter-form button {
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .filter-form button:hover {
                background-color: #0056b3;
            }

            .filter-form label {
                font-size: 16px;
                margin-right: 10px;
                font-weight: bold;
                color: #333;
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
                    <div class="filter-form">
                        <form action="RevenueStatisticServlet" method="GET" id="timePeriodForm">
                            <label for="timePeriod">Select Time Period:</label>
                            <select name="timePeriod" id="timePeriod">
                                <option value="day" ${time == 'day' ? 'selected' : ''}>By Day</option>
                            <option value="month" ${time == 'month' ? 'selected' : ''}>By Month</option>
                            <option value="year" ${time == 'year' ? 'selected' : ''} >By Year</option>
                        </select>
                        <button tyle="submit">Filter</button>
                    </form>
                </div>
                <div class="table-container rounded-table">
                    <table class="table table-striped">
                        <thead class="table-success">
                            <tr>
                                <th>Time Period</th>                               
                                <th>Total Orders</th>
                                <th>Total Products Sold</th>
                                <th>Total Revenue</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${revenueData}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty data.orderDate}">
                                                <fmt:formatDate value="${data.orderDate}" pattern="dd/MM/yyyy" />
                                            </c:when>
                                            <c:when test="${not empty data.orderMonth and not empty data.orderYear}">
                                                ${data.orderMonth}/${data.orderYear}
                                            </c:when>
                                            <c:when test="${not empty data.orderYear}">
                                                ${data.orderYear}   
                                            </c:when>
                                            <c:otherwise>  

                                            </c:otherwise>
                                        </c:choose>
                                    </td>                              
                                    <td>${data.totalOrder}</td>
                                    <td>${data.totalProductsSold}</td>
                                    <td><fmt:formatNumber value="${data.totalRevenue}" pattern="#,##0" /> ₫</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="row mt-4 g-2">
                    <div class="col-md-5 chart-container">
                        <h5>Revenue - Laptops (Monthly)</h5>
                        <canvas id="laptopRevenueChart"></canvas>
                        <div class="nav-buttons">
                            <button id="prevPageLaptop1"><i class='bx bx-chevron-left'></i></button>
                            <button id="nextPageLaptop1"><i class='bx bx-chevron-right'></i></button>
                        </div>
                    </div>
                    <div class="col-md-5 chart-container">
                        <h5>Revenue - Phones (Monthly)</h5>
                        <canvas id="phoneRevenueChart"></canvas>
                        <div class="nav-buttons">
                            <button id="prevPagePhone1"><i class='bx bx-chevron-left'></i></button>
                            <button id="nextPagePhone1"><i class='bx bx-chevron-right'></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Laptop Revenue
            var monthLaptop = [];
            var revenueLaptop = [];
            <c:forEach items="${listRevenueLaptop}" var="item">
            monthLaptop.push('${item.month}');
            revenueLaptop.push('${item.revenue}');
            </c:forEach>
            var monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];
            var itemsPerPageLaptop = 6;
            var currentPageLaptop = 0;
            var revenueMapping = {};
            for (var i = 0; i < monthLaptop.length; i++) {
                var m = parseInt(monthLaptop[i]);
                revenueMapping[m] = revenueLaptop[i];
            }

            function updateLaptopChart() {
                var startMonth = currentPageLaptop * itemsPerPageLaptop + 1; // ví dụ trang 0: 1; trang 1: 7
                var endMonth = startMonth + itemsPerPageLaptop; // không bao gồm endMonth
                var pagedLabelsLaptop = [];
                var pagedDataLaptop = [];

                for (var m = startMonth; m < endMonth; m++) {
                    pagedLabelsLaptop.push(monthNames[m - 1]);
                    pagedDataLaptop.push(revenueMapping[m] ? revenueMapping[m] : 0);
                }
                laptopRevenueChart.data.labels = pagedLabelsLaptop;
                laptopRevenueChart.data.datasets[0].data = pagedDataLaptop;
                laptopRevenueChart.update();
            }

            var ctxLaptop = document.getElementById("laptopRevenueChart").getContext("2d");
            var laptopRevenueChart = new Chart(ctxLaptop, {
                type: "bar",
                data: {
                    labels: [],
                    datasets: [{
                            label: "Laptop Revenue (VND)",
                            data: [],
                            backgroundColor: "#A25665"
                        }]
                }
            });

            updateLaptopChart();

            document.getElementById("prevPageLaptop1").addEventListener("click", function () {
                if (currentPageLaptop > 0) {
                    currentPageLaptop--;
                    updateLaptopChart();
                }
            });

            document.getElementById("nextPageLaptop1").addEventListener("click", function () {
                if ((currentPageLaptop + 1) * itemsPerPageLaptop < 12) {
                    currentPageLaptop++;
                    updateLaptopChart();
                }
            });


            // Phone Revenue
            var monthPhone = [];
            var revenuePhone = [];
            <c:forEach items="${listRevenuePhone}" var="item">
            monthPhone.push('${item.month}');
            revenuePhone.push('${item.revenue}');
            </c:forEach>
            var monthNames = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];
            var itemsPerPagePhone1 = 6;
            var currentPagePhone1 = 0;
            var revenueMappingPhone = {};
            for (var i = 0; i < monthPhone.length; i++) {
                // Chuyển giá trị tháng sang số nguyên
                var m = parseInt(monthPhone[i]);
                revenueMappingPhone[m] = revenuePhone[i];
            }
            function updatePhoneChart1() {
                var startMonth = currentPagePhone1 * itemsPerPagePhone1 + 1;
                var endMonth = startMonth + itemsPerPagePhone1;
                var pagedLabelsPhone = [];
                var pagedDataPhone = [];

                // Duyệt qua 6 tháng của trang hiện tại
                for (var m = startMonth; m < endMonth; m++) {
                    pagedLabelsPhone.push(monthNames[m - 1]);  // Vì mảng monthNames bắt đầu từ 0
                    // Nếu có dữ liệu doanh thu của tháng m, dùng giá trị đó; nếu không thì là 0
                    pagedDataPhone.push(revenueMappingPhone[m] ? revenueMappingPhone[m] : 0);
                }

                // Cập nhật dữ liệu cho biểu đồ
                phoneRevenueChart.data.labels = pagedLabelsPhone;
                phoneRevenueChart.data.datasets[0].data = pagedDataPhone;
                phoneRevenueChart.update();
            }

            var ctxPhone = document.getElementById("phoneRevenueChart").getContext("2d");
            var phoneRevenueChart = new Chart(ctxPhone, {
                type: "bar",
                data: {
                    labels: [],
                    datasets: [{
                            label: "Phone Revenue (VND)",
                            data: [],
                            backgroundColor: "#A29256"
                        }]
                }
            });

            updatePhoneChart1();

            document.getElementById("prevPagePhone1").addEventListener("click", function () {
                if (currentPagePhone1 > 0) {
                    currentPagePhone1--;
                    updatePhoneChart1();
                }
            });

            document.getElementById("nextPagePhone1").addEventListener("click", function () {
                if ((currentPageLaptop + 1) * itemsPerPageLaptop < 12) {
                    currentPagePhone1++;
                    updatePhoneChart1();
                }
            });
        </script>
    </body>
</html>
