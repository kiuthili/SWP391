<%-- 
    Document   : viewLaptop
    Created on : Dec 12, 2024, 7:20:22 PM
    Author     : KienBTCE180180
--%>

<%@page import="Models.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--<link rel="stylesheet" href="assets/css/bootstrap.css"/>-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>

            .banner-content img{
                width: 100%;
            }
            .title-content{
                color: black;
                font-weight: bold;
            }
            .section-content{
                display: flex;
                align-items: center;
                /*justify-content: space-around;*/
            }
            .gap-section {
                margin-bottom: 50px;
                background: #f83f5e;
                background-size: cover;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            .frame-represent {
                display: flex;
                flex-direction: column;
                width: 234px;
                height: 346px;
                text-align: center;
                margin: 15px;
                background: white;
                border: 1px solid #ddd;
                border-radius: 10px;
                align-items: center;
                justify-content: center;
                text-decoration: none;
                color: inherit;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .frame-represent:hover {
                transform: scale(1.05);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
                background-color: white !important;
                opacity: 1; /* Đảm bảo không bị mờ */
                text-decoration: none !important;
            }

            .productImg {
                transition: transform 0.3s ease;
                border-radius: 10px;
            }

            .productImg:hover {
                transform: scale(1.1);
            }

            .view-content{
                display: flex;
                align-content: space-between;
            }

            .filter-table{
                width: 100%;
                height: 100%;
                background-color: #F5F7FF;
                margin-top: 1%;
            }

            .section-btn{
                width: 100%;
                display: flex;
                justify-content: center;
                margin-bottom: 10px;
            }
            .filter-btn{
                border: 0;
                border-radius: 50px;
                width: 100%;
                background-color: #F5F7FF;
                border: 2px lightgrey solid;
            }
            .filter-btn h6{
                color: lightgrey;
                text-align: center;
                font-weight: bold;
                margin: 6px 0 6px 0;
            }

            .filter-form label{
                user-select: none;
            }
            .filter-form label:hover{
                /*font-weight: bold;*/
            }
            fieldset{
                display: flex;
                flex-direction: column;
            }
            .star-rating {
                display: flex;
                align-items: center;
                color: #ffcc00;
            }

            .title-content a{
                text-decoration: none;
                color: black;
                font-weight: bold;
            }
            .title-content a:hover{
                color: black;
                opacity: 0.7;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <main>
                <div class="container">
                    <div class="row">
                        <!--<div class="gap-section banner-content">
                            <img src="assets/imgs/Banners/banner-laptop.svg" alt="alt"/>
                        </div>-->
                    </div>
                    <div class="row">
                        <h4 class="title-content">${uri}</h4>
                </div>
                <div class="container mt-4 d-flex justify-content-end">
                    <c:if test="${uri == null || uri == ''}">
                        <form id="sortForm">
                            <select name="sort" id="sortSelect" class="form-select" style="width: 110px; font-size: 14px; padding: 5px;" onchange="sortProducts()">
                                <option value="asc">Ascending</option>
                                <option value="desc">Descending</option>
                            </select>
                        </form>
                    </c:if>
                </div>
                <div class="view-content">
                    <c:if test="${uri != null and uri != ''}">
                        <div class="filter-table col-md-2">
                            <h6 style="text-align: center; margin-top: 8px;; font-weight: bold;">Filters</h6>
                            <div class="section-btn">
                                <button class="filter-btn"><h6>Clear Filter</h6></button>
                            </div>

                            <form class="filter-form">
                                <fieldset>
                                    <legend style="font-size: 100%; font-weight: bold; cursor: pointer;" > <!--onclick="toggleFilter('brandFilter')"-->
                                        Brands <span id="brandArrow">▼</span>
                                    </legend>
                                    <div id="brandFilter" style="display: block;">
                                        <c:forEach items="${brands}" var="b">
                                            <label><input type="checkbox" name="brand" value="${b}" <c:if test="${fn:contains(filters, b)}">checked</c:if> >${b}</label>
                                            </c:forEach>
                                    </div>
                                </fieldset>
                                <fieldset>
                                    <legend style="font-size: 100%; font-weight: bold; cursor: pointer;"> <!-- onclick="toggleFilter('priceFilter')"-->
                                        Price <span id="priceArrow">▼</span>
                                    </legend>
                                    <c:if test="${uri == 'Laptop'}">
                                        <div id="priceFilter" style="display: block">
                                            <label><input type="checkbox" name="price" value="20-25" <c:if test="${fn:contains(filters, '20-25')}">checked</c:if> >20 - 25 million</label>
                                            <label><input type="checkbox" name="price" value="25-30" <c:if test="${fn:contains(filters, '25-30')}">checked</c:if> >25 - 30 million</label>
                                            <label><input type="checkbox" name="price" value="30-over" <c:if test="${fn:contains(filters, '30-over')}">checked</c:if> >Over 30 million</label>
                                            </div>
                                    </c:if>
                                    <c:if test="${uri == 'Smartphone'}">
                                        <div id="priceFilter" style="display: block">
                                            <label><input type="checkbox" name="price" value="5-15" <c:if test="${fn:contains(filters, '5-15')}">checked</c:if> >5 - 15 million</label>
                                            <label><input type="checkbox" name="price" value="15-25" <c:if test="${fn:contains(filters, '15-25')}">checked</c:if> >15 - 25 million</label>
                                            <label><input type="checkbox" name="price" value="25-30" <c:if test="${fn:contains(filters, '25-30')}">checked</c:if> >25 - 30 million</label>
                                            <label><input type="checkbox" name="price" value="30-over" <c:if test="${fn:contains(filters, '30-over')}">checked</c:if> >Over 30 million</label>
                                            </div>
                                    </c:if>
                                    <c:if test="${uri != 'Smartphone' && uri != 'Laptop' && fn:length(uri) > 0}">
                                        <div id="priceFilter" style="display: block">
                                            <label><input type="checkbox" name="price" value="100-500" <c:if test="${fn:contains(filters, '100-500')}">checked</c:if> >100 - 500 hundred</label>
                                            <label><input type="checkbox" name="price" value="500-1" <c:if test="${fn:contains(filters, '500-1')}">checked</c:if> >500 hundred - 1 million</label>
                                            <label><input type="checkbox" name="price" value="1-5" <c:if test="${fn:contains(filters, '1-5')}">checked</c:if> >1 - 5 million</label>
                                            <label><input type="checkbox" name="price" value="5-15" <c:if test="${fn:contains(filters, '5-15')}">checked</c:if> >5 - 15 million</label>
                                            <label><input type="checkbox" name="price" value="15-25" <c:if test="${fn:contains(filters, '15-25')}">checked</c:if> >15 - 25 million</label>
                                            <label><input type="checkbox" name="price" value="25-30" <c:if test="${fn:contains(filters, '25-30')}">checked</c:if> >25 - 30 million</label>
                                            <label><input type="checkbox" name="price" value="30-over" <c:if test="${fn:contains(filters, '30-over')}">checked</c:if> >Over 30 million</label>
                                            </div>
                                    </c:if>
                                </fieldset>
                            </form>

                        </div>
                    </c:if>

                    <div class="show-product row col-md-10">
                        <!--===================================================-->
                        <div class="container">
                            <div class="row">
                                <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                                    <div class="col-md-3"> <!-- 4 sản phẩm mỗi dòng -->
                                        <a class="frame-represent" href="ProductDetailServlet?id=${p.getProductId()}">
                                            <img class="productImg" src="assets/imgs/Products/${p.getImage()}" width="150px" height="150px" alt="alt"/>
                                            <h6 style="height: 40px; margin-top: 20px;">${p.getFullName()}</h6>
                                            <p style="font-weight: bold; color: red;">${p.getPriceFormatted()}</p>
                                            <div class="star-rating" >
                                                <c:forEach var="i" begin="1" end="5">
                                                    <c:choose>
                                                        <c:when test="${dataMap.stars != null and dataMap.stars.size() > 0 and i <= dataMap.stars[status.index].getStar()}">
                                                            <i class="fa fa-star"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-star text-muted"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>

                                            </div>
                                            <c:if test="${dataMap.stars[status.index].getStar()==0}">
                                                <small>
                                                    Not reviews yet.
                                                </small>
                                            </c:if>
                                            <c:if test="${dataMap.stars[status.index].getStar()!=0}">
                                                <small>
                                                    <br>
                                                </small>
                                            </c:if>
                                            <c:if test="${p.getStock() < 0}">
                                                <p style="color: red; font-weight: bold;">SOLD OUT</p>
                                            </c:if>
                                        </a>
                                    </div>

                                    <!-- Xuống dòng sau mỗi 4 sản phẩm -->
                                    <c:if test="${(status.index + 1) % 4 == 0}">
                                    </div>
                                    <div class="row">
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>

                        <!--===================================================-->
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="footer.jsp"></jsp:include>

        <script>
            function sortProducts() {
                let sortValue = document.getElementById("sortSelect").value;
                let currentUrl = new URL(window.location.href);

                currentUrl.searchParams.set("sort", sortValue);

                window.location.href = currentUrl.toString();
            }

            window.onload = function () {
                let urlParams = new URLSearchParams(window.location.search);
                let sortValue = urlParams.get("sort") || "desc"; // Mặc định là "asc" nếu không có giá trị

                document.getElementById("sortSelect").value = sortValue;
            };
        </script>
        <script>
            const pathname = window.location.pathname;
            let customPath = pathname;
            let clrBtn = document.querySelector('.filter-btn');
            let clrTxt = clrBtn.querySelector('h6');

            /* ========================================================================================== */

            function updateSelectedValues() {
                customPath = pathname;
                const selectedBrands = Array.from(document.querySelectorAll('input[name="brand"]:checked')).map(checkbox => checkbox.value);

                const selectedPrices = Array.from(document.querySelectorAll('input[name="price"]:checked')).map(checkbox => checkbox.value);

                if (selectedBrands.length !== 0 && !customPath.includes("?")) {
                    customPath += "?brand=";
                    for (var i = 0; i < selectedBrands.length; i++) {
                        if (i === 0) {
                            customPath += selectedBrands[i];
                        } else {
                            customPath += "%2C" + selectedBrands[i];
                        }
                    }

                    clrBtn.style.border = '2px solid #D10000';
                    clrTxt.style.color = '#D10000';
                }

                if (selectedPrices.length !== 0 && !customPath.includes("?") && !window.location.search.includes('name')) {
                    customPath += "?price=";
                    for (var i = 0; i < selectedPrices.length; i++) {
                        if (i === 0) {
                            customPath += selectedPrices[i];
                        } else {
                            customPath += "%2C" + selectedPrices[i];
                        }
                    }

                    clrBtn.style.border = '2px solid #D10000';
                    clrTxt.style.color = '#D10000';
                } else if (selectedPrices.length !== 0 && !window.location.search.includes('name')) {
                    customPath += "&price=";
                    for (var i = 0; i < selectedPrices.length; i++) {
                        if (i === 0) {
                            customPath += selectedPrices[i];
                        } else {
                            customPath += "%2C" + selectedPrices[i];
                        }
                    }

                    clrBtn.style.border = '2px solid #D10000';
                    clrTxt.style.color = '#D10000';
                } /*else if (selectedPrices.length !== 0 && window.location.search.includes('name')) {
                 customPath += window.location.search;
                 customPath += "&price=";
                 for (var i = 0; i < selectedPrices.length; i++) {
                 if (i === 0) {
                 customPath += selectedPrices[i];
                 } else {
                 customPath += "%2C" + selectedPrices[i];
                 }
                 }
                 
                 clrBtn.style.border = '2px solid #D10000';
                 clrTxt.style.color = '#D10000';
                 }*/

                if (!window.location.search.includes('name') && !window.location.search.includes('sort')) {
                    if (customPath !== (window.location.pathname + window.location.search)) {

                        /*const urlParams = new URLSearchParams(window.location.search);
                         const sortValue = urlParams.get('sort');
                         let final = 'sort=' + sortValue);
                         
                         customPath.replace(final, '');*/

                        window.location.href = customPath.toString();
                    }
                } /*else if (window.location.search.includes('name')) {
                 console.log(2);
                 if (customPath !== (window.location.pathname + window.location.search)) {
                 console.log(customPath);
                 console.log(window.location.pathname);
                 console.log(window.location.search);
                 //                        window.location.href = customPath;
                 }
                 }*/
            }

            document.querySelectorAll('input[name="brand"], input[name="price"]').forEach(checkbox => {
                checkbox.addEventListener("change", updateSelectedValues);
            });

            updateSelectedValues();

            /* ========================================================================================== */

            document.querySelector('.filter-btn').addEventListener('click', function () {
                document.querySelectorAll('.filter-form input[type="checkbox"]').forEach(input => {
                    input.checked = false;
                });

                updateSelectedValues();
            });

            function toggleFilter(id) {
                let filterDiv = document.getElementById(id);
                let arrow = document.getElementById(id.replace('Filter', 'Arrow'));


                /*=====================================================*/
                const selectedBrands = Array.from(document.querySelectorAll('input[name="brand"]:checked')).map(checkbox => checkbox.value);
                const selectedPrices = Array.from(document.querySelectorAll('input[name="price"]:checked')).map(checkbox => checkbox.value);

                /*=====================================================*/


                if (filterDiv.style.display === "none") {
                    filterDiv.style.display = "block";
                    arrow.innerHTML = "▲";
                } else {
                    filterDiv.style.display = "none";
                    arrow.innerHTML = "▼";
                }
            }
        </script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
