<%-- 
    Document   : AccessoryListView
    Created on : Mar 14, 2025, 1:50:19 PM
    Author     : KienBTCE180180
--%>

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
            .gap-section{
                margin-bottom: 50px;
            }
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
            .frame-represent{
                display: flex;
                flex-direction: column;
                width: 234px;
                height: 346px;
                text-align: center;
                margin: 15px;
                background: white;
                border: 1px solid #F5F5F9;
                border-radius: 10px;
                align-items: center;
                justify-content: center;

                text-decoration: none;
                color: inherit;
                transition: 0.3s;
            }

            .frame-represent:hover {
                opacity: 0.8;
                text-decoration: none;
                color: inherit;
                transition: 0.3s;
            }

            .filter-table{
                width: 100%;
                height: 500px;
                background-color: #F5F7FF;
            }
            .view-content{
                display: flex;
                align-content: space-between;
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
                <div class="view-content">

                    <div class="filter-table col-md-2">
                        <h6 style="text-align: center; margin-top: 8px;; font-weight: bold;">Filters</h6>
                        <div class="section-btn">
                            <button class="filter-btn"><h6>Clear Filter</h6></button>
                        </div>

                        <form class="filter-form">
                            <fieldset>
                                <legend style="font-size: 100%; font-weight: bold; cursor: pointer;" onclick="toggleFilter('brandFilter')">
                                    Brands <span id="brandArrow">▼</span>
                                </legend>
                                <div id="brandFilter" style="display: none;">
                                    <c:forEach items="${brands}" var="b">
                                        <label><input type="checkbox" name="brand" value="${b}" <c:if test="${fn:contains(filters, b)}">checked</c:if> >${b}</label>
                                        </c:forEach>
                                </div>
                            </fieldset>
                            <fieldset>
                                <legend style="font-size: 100%; font-weight: bold; cursor: pointer;" onclick="toggleFilter('priceFilter')">
                                    Price <span id="priceArrow">▼</span>
                                </legend>
                                <div id="priceFilter" style="display: none">
                                    <label><input type="checkbox" name="price" value="20-25" <c:if test="${fn:contains(filters, '20-25')}">checked</c:if> >20 - 25 million</label>
                                    <label><input type="checkbox" name="price" value="25-30" <c:if test="${fn:contains(filters, '25-30')}">checked</c:if> >25 - 30 million</label>
                                    <label><input type="checkbox" name="price" value="30-over" <c:if test="${fn:contains(filters, '30-over')}">checked</c:if> >Over 30 million</label>
                                    </div>
                                </fieldset>
                            </form>


                        </div>

                        <div class="show-product row col-md-10">
                            <!--===================================================-->
                            <div class="section-content">
                                <div class="row">
                                <c:forEach items="${products}" var="p">
                                    <div class="col-md-3 mb-4">
                                        <a class="frame-represent" href="ProductDetailServlet?id=${p.getProductId()}">
                                            <img src="assets/imgs/Products/${p.getImage()}" width="150px" height="150px" alt="alt"/>
                                            <div class="star-rating">
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
                                            <h6>${p.getFullName()}</h6>
                                            <p>${p.getPriceFormatted()}</p>
                                        </a>
                                    </div>
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

                if (selectedPrices.length !== 0 && !customPath.includes("?")) {
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
                } else if (selectedPrices.length !== 0) {
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
                }


                if (customPath !== (window.location.pathname + window.location.search)) {
                    window.location.href = customPath;
                }
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
