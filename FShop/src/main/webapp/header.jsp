<%-- 
    Document   : header
    Created on : Dec 8, 2024, 11:37:14 AM
    Author     : KienBTCE180180
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="assets/css/bootstrap.css"/>
        <link href="assets/fonts/themify-icons/themify-icons.css" rel="stylesheet">
        <style>
            i{
                margin: 5px;
            }

            header{
                width: 100%;
                height: 44px;
                background-color: #e9efff;

                top: 0;
                left: 0;
                z-index: 1000; /* Đảm bảo header nằm trên */
                padding: 10px 0; /* Điều chỉnh padding nếu cần */
            }
            .header-container{
                height: 100%;
            }
            .header-infor{
                background-color: #e9efff;
                padding: 0 !important;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .infor-content{
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .text-header{
                color: #000b68;
                font-weight: bold;
            }
            .infor-content p{
                margin: 0;
            }
            .infor-content:nth-child(1){
                justify-content: left;
            }
            .infor-content:nth-child(3){
                justify-content: right;
            }
            .infor-content:nth-child(3) *{
                margin-left: 5px
            }
            .infor-content a, .nav-infor-content a{
                text-decoration: none;
                color: white;
            }
            .infor-content a:hover, .nav-infor-content a:hover{
                color: white;
                opacity: 0.6;
                text-decoration: none;
            }

            nav{
                width: 100%;
                height: 72px;
                border-bottom: 1.5px solid rgba(0, 0, 1, 0.1);
                background: #d10000;
                top: 40px; /* Cách header một khoảng (tùy chỉnh) */
                left: 0;
                z-index: 999;
            }
            .nav-container{
                height: 100%;
            }
            .nav-infor{
                padding: 0 !important;
                height: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .nav-infor-content{
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .nav-infor-content:nth-child(1){
                flex-basis: 100px;
            }
            .nav-infor-content:nth-child(2){
                flex-basis: 50%;
            }
            .nav-infor-content:nth-child(3){
                flex-basis: 400px;
            }
            .nav-infor-content:nth-child(3) *{
                margin-left: 5px
            }
            .list-cat{
                flex-direction: column;
            }
            .list-categories{
                margin: 0px ;
                padding: 0;
                width: 100%;
                height: 100%;
                list-style: none;
                display: flex;
                justify-content: space-around;
            }
            li a{
                font-size: 19px;
                text-decoration: none;
                color: white;
                font-weight: bold;
            }
            li a:hover{
                color: white;
                opacity: 0.7;
                text-decoration: none;
            }
            .search-box {
                width: 100%; /* Để thanh tìm kiếm rộng bằng danh mục */
                margin-top: 12px;
            }
            #searchIcon{
                cursor: pointer;
            }
            nav.navbar-custom .nav-icons .btn-notif {
                background: none;
                border: none;
                padding: 0;
                cursor: pointer;
            }
            .btn-notif {
                background: none !important;
                border: none !important;
                padding: 5px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .btn-notif i {
                font-size: 20px;
                color: #333;
                transition: color 0.3s ease-in-out;
            }

            .btn-notif:hover i {
                color: #d10000;
            }
            body {
                padding-top: 110px; /* Tạo khoảng trống để tránh header che mất nội dung */
            }

            @media all and (max-width: 1000px) {
                .header-container .time-head, .phone-head {
                    display: none;
                }

                .nav-infor{
                    padding: 0 !important;
                    height: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                }
                .list-cat {
                    display: none;
                }
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <header style="position: fixed;">
            <div class="header-container container">
                <div class="header-infor row">
                    <div class="infor-content time-head col-md-4">
                        <p class="text-header">Mon-Thu 9:00AM - 5:30PM</p>
                    </div>
                    <div class="infor-content address-head col-md-4">
                        <p class="text-header">Nguyen Van Cu, Ninh Kieu, Can Tho</p>
                    </div>
                    <div class="infor-content phone-head col-md-4">
                        <p class="text-header">Call Us: (+84) 12 345 6789</p>
                        <a href="#"><img src="assets/imgs/HeaderImgs/facebook.png" alt="Facebook" style="width: 23px; height: 23px;"></a>
                        <a href="#"><img src="assets/imgs/HeaderImgs/instagram.png" alt="Instagram" style="width: 23px; height: 23px;"></a>
                    </div>
                </div>
            </div>
        </header>
        <nav style="position: fixed;">
            <div class="nav-container container">
                <div class="nav-infor row">
                    <div class="nav-infor-content col-md-4">
                        <a href="/">
                            <div style="display: flex; column-gap: 10px; margin: 15px 0px 0px 0px">
                                <svg width="34" height="41" viewBox="0 0 34 41" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M17.0331 0.945374L0.296875 10.8637V23.0708L17.0331 32.9891L30.4588 25.3596V28.9836L17.0331 36.9946L0.296875 26.8855V31.2725L17.0331 41L33.7693 31.2725V19.0653L20.3435 26.8855V23.0708L33.7693 15.0599V10.8637L17.0331 0.945374Z" fill="white"/>
                                </svg>
                                <p class="tieuDeHeader" style="color: white; font-size: 30px">FShop</p>
                            </div>
                        </a>
                    </div>
                    <div class="nav-infor-content list-cat col-md-4">
                        <ul class="list-categories">
                            <li>
                                <a href="Laptop">Laptop</a>
                            </li>
                            <li>
                                <a href="Smartphone">Smartphone</a>
                            </li>
                            <li>
                                <a href="Accessory">Accessories</a>
                            </li>
                        </ul>
                        <!--<input type="text" id="searchInput" class="form-control search-box" placeholder="Find by name ..." value="${searchValue}">-->
                    </div>
                    <div class="nav-infor-content col-md-4">
                        <a><i class="ti-search" style="font-size: 150%; color: white; margin-right: 10px;" id="searchIcon"></i></a>
                        <input style="display: flex; align-items: center; margin: 0" type="text" id="searchInput" class="form-control search-box" placeholder="Find by name ..." value="">
                        <div style="display: flex; align-items: center" onclick="">
                            <button type="button" class="btn-notif" data-bs-toggle="modal" data-bs-target="#notificationModal">
                                <i class="ti-bell" style="color: white;"></i>
                            </button>
                            <!--<i class="ti-search" style="font-size: 150%; color: black;"></i>-->
                            <div style="display: flex; align-items: center">
                                <c:if test="${sessionScope.customer == null}">
                                    <a href="cart"><i class="ti-shopping-cart" style="font-size: 150%; color: white;"></i></a>
                                    </c:if>
                                    <c:if test="${sessionScope.customer != null}">
                                    <a href="cart"><i class="ti-shopping-cart" style="font-size: 150%; color: white;"></i></a>
                                    <p style="color: white;">${sessionScope.numOfProCartOfCus}</p>
                                </c:if>
                            </div>
                            <div style="display: flex; align-items: center; font-size: 12px">
                                <c:if test="${sessionScope.customer != null}">
                                    <a href="viewCustomerProfile">
                                        <c:if test="${sessionScope.customer.getAvatar().equals('') == true}">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                            </svg>
                                        </c:if>   
                                        <c:if test="${sessionScope.customer.getAvatar().equals('') == false}">
                                            <img style="border-radius: 50%;" width="40px" height="40px" src="assets/imgs/CustomerAvatar/${sessionScope.customer.getAvatar()}" alt="default">
                                        </c:if>
                                    </a>
                                </c:if>
                                <c:if test="${sessionScope.customer == null}">
                                    <a class="text-white" href="customerLogin" style="">
                                        <div style="display: flex; align-items: center; height: 50px; flex-direction: row; flex-wrap: wrap; padding-bottom: 10px; padding-top: 5px;">
                                            <div style="">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                                </svg>
                                            </div>
                                            <p style="color: white; font-size: 15px;">
                                                Login
                                            </p>
                                        </div>
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </nav>

        <div class="modal fade" id="notificationModal" tabindex="-1" aria-labelledby="notificationModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="notificationModalLabel">New Reply From FShop</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="list-group" id="notificationList">
                            <p class="text-muted">Loading...</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/js/bootstrap.min.js"></script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Hàm xử lý tìm kiếm
                function searchProduct() {
                    let searchValue = document.getElementById("searchInput").value.trim();
                    if (searchValue !== "") {
                        window.location.href = "SearchProduct?name=" + encodeURIComponent(searchValue);
                    }
                }

                // Khi nhấn Enter trong input
                document.getElementById("searchInput").addEventListener("keypress", function (event) {
                    if (event.key === "Enter") {
                        event.preventDefault();
                        searchProduct();
                    }
                });

                // Khi nhấn vào icon tìm kiếm
                document.getElementById("searchIcon").addEventListener("click", function () {
                    searchProduct();
                });
            });

            document.addEventListener("DOMContentLoaded", function () {
                // Hàm lấy giá trị của tham số từ URL
                function getParameterByName(name) {
                    let urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(name) || "";
                }

                // Lấy giá trị của tham số "name" và đặt vào input
                document.getElementById("searchInput").value = getParameterByName("name");
            });
        </script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const notifBtn = document.querySelector('.btn-notif');
                notifBtn.addEventListener('click', function () {
                    fetch('NotificationServlet?ajax=true')
                            .then(response => response.json())
                            .then(data => {
                                console.log("Received data:", data); // Kiểm tra JSON trong console
                                const notificationList = document.getElementById("notificationList");
                                notificationList.innerHTML = "";

                                if (data.replies && Array.isArray(data.replies) && data.replies.length > 0) {
                                    data.replies.forEach((reply, index) => {
                                        let product = data.product[index] || "";
                                        console.log("Product data:", product.fullName);

                                        // Tạo thẻ <a> để hiển thị thông báo
                                        const aElem = document.createElement('a');
                                        aElem.href = "ProductDetailServlet?id=" + product.productId;
                                        aElem.classList.add('list-group-item', 'list-group-item-action');
                                        aElem.innerHTML = `
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">New reply on ` + product.fullName + `</h6>
          

                            </div>
                            <p class="mb-1">${reply.answer}</p>
                        `;

                                        aElem.addEventListener('click', function (event) {
                                            event.preventDefault();

                                            fetch("NotificationServlet", {
                                                method: "POST",
                                                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                                                body: "repliesID=" + reply.replyID
                                            }).then(response => response.text())
                                                    .then(() => {
                                                        window.location.href = "ProductDetailServlet?id=" + product.productId;
                                                    })
                                                    .catch(error => console.error("Error updating reply status:", error));
                                        });

                                        notificationList.appendChild(aElem);
                                    });
                                } else {
                                    notificationList.innerHTML = '<p class="text-muted">No new comments.</p>';
                                }
                            })
                            .catch(error => {
                                console.error('Error fetching unread replies:', error);
                                document.getElementById("notificationList").innerHTML = '<p class="text-muted">Error loading data</p>';
                            });
                });
            });
            document.addEventListener("DOMContentLoaded", function () {
                // Hàm lấy giá trị của tham số từ URL
                function getParameterByName(name) {
                    let urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(name) || "";
                }

                // Lấy giá trị của tham số "name" và đặt vào input
                document.getElementById("searchInput").value = getParameterByName("name");
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>