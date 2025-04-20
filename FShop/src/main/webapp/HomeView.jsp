<%-- 
    Document   : index.jsp
    Created on : Dec 4, 2024, 3:16:00 PM
    Author     : KienBTCE180180
--%>

<%@page import="java.util.List"%>
<%@page import="DAOs.ProductDAO"%>
<%@page import="Models.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>F Shop</title>
        <!--<link rel="stylesheet" href="assets/css/bootstrap.css"/>-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
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
            .banner-content {
                position: relative;
                overflow: hidden;
            }

            #banner {
                display: block;
                transition: opacity 0.5s ease-in-out;
                border-radius: 10px;
            }

            .title-content{
                font-weight: bold;
            }

            .section-content{
                display: flex;
                align-items: center;
                /*justify-content: space-around;*/
            }

            .star-rating {
                display: flex;
                align-items: center;
                color: #ffcc00;
                height: 30px;
            }

            .title-content a {
                font-family: Arial, sans-serif;
                font-weight: bold;
                text-transform: uppercase;
                font-size: 26px;
                letter-spacing: 2px;
                color: white;
                text-shadow: 0 0 5px red, 0 0 10px red, 0 0 20px red;
                animation: neonColorChange 2s infinite linear;
                text-decoration: none;
                margin-left: 2%;
            }

            @keyframes neonColorChange {
                0% {
                    text-shadow: 0 0 5px red, 0 0 10px red, 0 0 20px red;
                }
                25% {
                    text-shadow: 0 0 5px blue, 0 0 10px blue, 0 0 20px blue;
                }
                50% {
                    text-shadow: 0 0 5px green, 0 0 10px green, 0 0 20px green;
                }
                75% {
                    text-shadow: 0 0 5px purple, 0 0 10px purple, 0 0 20px purple;
                }
                100% {
                    text-shadow: 0 0 5px red, 0 0 10px red, 0 0 20px red;
                }
            }



            .title-content a:hover{
                color: white;
                opacity: 0.7;
                text-decoration: none;
            }

            @keyframes blink-move {
                0% {
                    transform: translateY(-50%) scale(1);
                    opacity: 1;
                }
                50% {
                    transform: translateY(-50%) scale(1.1);
                    opacity: 0.7;
                }
                100% {
                    transform: translateY(-50%) scale(1);
                    opacity: 1;
                }
            }
            .arrow-btn {
                animation: blink-move 1s infinite alternate;
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background: transparent;
                color: lightblue;
                font-weight: bold;
                border: none;
                width: 45px;
                height: 45px;
                border-radius: 50%;
                font-size: 24px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 40px;
                transition: background 0.3s, transform 0.2s;
            }

            .arrow-btn:hover {
                transform: translateY(-50%) scale(1.1);
            }
            .hi {
                display: flex;
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container">
                <div class="hi">
                    <div class="row">
                        <div class="banner-content" style="position: relative; width: fit-content; overflow: hidden;">
                            <img id="banner" src="assets/imgs/Banners/1.jpg" alt="alt" style="width: 100%; display: block; transition: opacity 0.5s ease-in-out;" />
                            <button id="prev" onclick="prevBanner()" class="arrow-btn" style="left: 10px;">‹</button>
                            <button id="next" onclick="nextBanner()" class="arrow-btn" style="right: 10px;">›</button>
                        </div>
                    </div>
                </div>
                <script>
                    const images = [
                        "assets/imgs/Banners/1.jpg",
                        "assets/imgs/Banners/2.png",
                        "assets/imgs/Banners/3.png"
                    ];
                    let currentIndex = 0;
                    let interval;

                    function updateBanner() {
                        const banner = document.getElementById("banner");
                        banner.style.opacity = 0; // Làm mờ trước khi đổi ảnh
                        setTimeout(() => {
                            banner.src = images[currentIndex];
                            banner.style.opacity = 1; // Hiện ảnh lên mượt mà
                        }, 300);
                    }

                    function nextBanner() {
                        currentIndex = (currentIndex + 1) % images.length;
                        updateBanner();
                        resetAutoSlide();
                    }

                    function prevBanner() {
                        currentIndex = (currentIndex - 1 + images.length) % images.length;
                        updateBanner();
                        resetAutoSlide();
                    }

                    function autoSlide() {
                        interval = setInterval(nextBanner, 3000);
                    }

                    function resetAutoSlide() {
                        clearInterval(interval);
                        autoSlide();
                    }

                    autoSlide(); // Bắt đầu tự động chạy
                </script>
                <br>
                <div class="gap-section">
                    <h2 class="title-content" ><a href="Laptop">Laptop</a></h2>
                    <div class="row">

                        <div class=" section-content">

                        <c:set var="count" value="0" scope="page"></c:set>
                        <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                            <c:if test="${count < 5 and p.getCategoryId() == 1}">
                                <c:set var="count" value="${count + 1}" scope="page"></c:set>
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
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="gap-section">
                <h2 class="title-content" ><a href="Smartphone">Smartphone</a></h2>
                <div class="row">

                    <div class=" section-content">
                        <c:set var="count" value="0" scope="page"></c:set>
                        <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                            <c:if test="${count < 5 and p.getCategoryId() == 2}">
                                <c:set var="count" value="${count + 1}" scope="page"></c:set>
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
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="gap-section">
                <h2 class="title-content" ><a href="Accessory Headphone">Headphone</a></h2>
                <div class="row">
                    <div class=" section-content">
                        <c:set var="count" value="0" scope="page"></c:set>
                        <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                            <c:if test="${count < 5 and p.getCategoryId() == 4}">
                                <c:set var="count" value="${count + 1}" scope="page"></c:set>
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

                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="gap-section">
                <h2 class="title-content" ><a href="Accessory Mouse">Mouse</a></h2>
                <div class="row">
                    <div class=" section-content">
                        <c:set var="count" value="0" scope="page"></c:set>
                        <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                            <c:if test="${count < 5 and p.getCategoryId() == 3}">
                                <c:set var="count" value="${count + 1}" scope="page"></c:set>
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
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>


            <div class="gap-section">
                <h2 class="title-content" ><a href="Accessory Charger">Charger</a></h2>
                <div class="row">

                    <div class=" section-content">
                        <c:set var="count" value="0" scope="page"></c:set>
                        <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                            <c:if test="${count < 5 and p.getCategoryId() == 5}">
                                <c:set var="count" value="${count + 1}" scope="page"></c:set>
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
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="gap-section">
                <h2 class="title-content" ><a href="Accessory Cable">Cable</a></h2>
                <div class="row">

                    <div class=" section-content">
                        <c:set var="count" value="0" scope="page"></c:set>
                        <c:forEach items="${dataMap.products}" var="p" varStatus="status">
                            <c:if test="${count < 5 and p.getCategoryId() == 6}">
                                <c:set var="count" value="${count + 1}" scope="page"></c:set>
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
                                </a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div style="margin-bottom: 20px;">
                <div>
                    <h5 style="font-size: 18px; font-weight: bold; margin-bottom: 10px;">
                        Follow us on Instagram for News, Offers & More
                    </h5>

                    <div style="display: flex; flex-wrap: wrap; gap: 30px;">
                        <div style="width: 235px;">
                            <img src="assets/imgs/Magazines/news-1.svg" width="235px" height="150px" alt="alt"/>
                            <p style="text-align: justify; hyphens: auto; margin-top: 5px;">
                                If you’ve recently made a desktop PC or laptop purchase, you might want to consider adding peripherals to enhance your home office setup, your gaming rig, or your business workspace...
                            </p>
                        </div>
                        <div style="width: 235px;">
                            <img src="assets/imgs/Magazines/news-2.svg" width="235px" height="150px" alt="alt"/>
                            <p style="width: 100%; text-align: justify; hyphens: auto;">
                                As a gamer, superior sound counts for a lot. You need to hear enemies tiptoeing up behind you for a sneak attack atmospheric music signaling a new challenge or task...
                            </p>
                        </div>
                        <div style="width: 235px;">
                            <img src="assets/imgs/Magazines/news-3.svg" width="235px" height="150px" alt="alt"/>
                            <p style="text-align: justify; hyphens: auto; margin-top: 5px;">
                                If you’ve recently made a desktop PC or laptop purchase, you might want to consider adding peripherals to enhance your home office setup, your gaming rig, or your business workspace...
                            </p>
                        </div>
                        <div style="width: 235px;">
                            <img src="assets/imgs/Magazines/news-4.svg" width="235px" height="150px" alt="alt"/>
                            <p style="text-align: justify; hyphens: auto; margin-top: 5px;">
                                If you’ve recently made a desktop PC or laptop purchase, you might want to consider adding peripherals to enhance your home office setup, your gaming rig, or your business workspace...
                            </p>
                        </div>
                        <div style="width: 235px;">
                            <img src="assets/imgs/Magazines/news-5.svg" width="235px" height="150px" alt="alt"/>
                            <p style="text-align: justify; hyphens: auto; margin-top: 5px;">
                                If you’ve recently made a desktop PC or laptop purchase, you might want to consider adding peripherals to enhance your home office setup, your gaming rig, or your business workspace...
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div style=""><jsp:include page="footer.jsp"></jsp:include></div>

        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
