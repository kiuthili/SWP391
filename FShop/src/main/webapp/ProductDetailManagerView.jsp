<%-- 
    Document   : ProductDetailManagerView
    Created on : 25-Feb-2025, 10:56:39
    Author     : kiuth
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Product Detail</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome & Google Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Montserrat', sans-serif;

            }
            /* Tạo khung sản phẩm đẹp và rõ ràng */
            .product-card {
                margin-top: 300px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                padding: 60px;
                margin: 40px auto;
                max-width: 1200px;
                margin-left: 300px;
            }

            /* Khung thông tin sản phẩm */
            .card-body {
                padding: 20px;
            }

            .product-content {
                margin-left: 250px;
                display: flex;
                flex-wrap: wrap;
            }

            /* Hình ảnh sản phẩm */
            .product-images {
                flex: 1 1 40%;
                padding: 10px;
                text-align: center;
            }

            .main-image {
                width: 100%;
                max-width: 500px;
                border: 2px solid #ddd;
                border-radius: 8px;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }

            .main-image:hover {
                transform: scale(1.05);
            }

            .product-gallery {
                display: flex;
                justify-content: center;
                gap: 10px;
                flex-wrap: wrap;
            }

            .product-gallery img {
                width: 70px;
                height: 70px;
                object-fit: cover;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                transition: transform 0.2s ease, border-color 0.2s ease;
            }

            .product-gallery img:hover {
                transform: scale(1.1);
                border-color: #7D69FF;
            }

            /* Thông tin sản phẩm */
            .product-info {
                flex: 1 1 60%;
                padding: 20px;
            }

            .product-info h2 {
                font-size: 2.2rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 20px;
                text-transform: capitalize;
            }

            /* Định dạng thông tin thuộc tính */
            .info-item {
                background-color: #f9f9f9;
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 10px;
                transition: background-color 0.3s ease;
            }

            /* Thuộc tính quan trọng (giá, trạng thái) */
            .info-item.important {
                background-color: #e7f1ff;
                border-left: 5px solid #007bff;
            }

            .info-item.important:hover {
                background-color: #d1e7ff;
            }

            /* Các thuộc tính phụ (như mô tả, category) */
            .info-item.secondary {
                background-color: #f4f4f4;
                border-left: 5px solid #6c757d;
            }

            .info-item.secondary:hover {
                background-color: #e9ecef;
            }

            /* Các thông tin chi tiết */
            .info-label {
                font-weight: 600;
                color: #555;
            }

            .info-value {
                color: #333;
            }

            /* Thuộc tính danh sách (Attributes) */
            .info-item ul {
                list-style-type: none;
                padding-left: 0;
            }

            .info-item ul li {
                background-color: #f1f1f1;
                padding: 8px 15px;
                border-radius: 8px;
                margin-bottom: 8px;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .info-item ul li:hover {
                background-color: #7D69FF;
                color: white;
                transform: scale(1.05);
            }

            /* Mobile responsive */
            @media (max-width: 768px) {
                .product-content {
                    flex-direction: column;
                }

                .product-images,
                .product-info {
                    flex: 1 1 100%;
                }
            }
            /* Phần hiển thị thuộc tính */
            .info-item ul {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            .info-item ul li {
                background-color: #f1f1f1; /* Màu nền nhẹ */
                padding: 8px 15px;
                border-radius: 8px;
                margin-bottom: 8px;
                transition: background-color 0.3s ease, transform 0.3s ease; /* Thêm hiệu ứng hover */
            }

            .info-item ul li:hover {
                background-color: #7D69FF; /* Màu nền khi hover */
                color: white; /* Đổi màu chữ khi hover */
                transform: scale(1.05); /* Tăng kích thước một chút khi hover */
            }

            .info-item ul li strong {
                color: #333;
                font-weight: bold;
            }

            .info-item ul li span {
                color: #555;
            }

            /* Giữ header cố định */
            .header {
                position: fixed;
                top: 0;
                left: 260px; /* vì sidebar chiếm 250px */
                right: 10px;
                margin-top: 10px;
                z-index: 1000;
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
            /* ========================================================= */
            .hi {

                position: fixed;
                top: 0;
                left: 267px;  /* điều chỉnh theo sidebar */
                right: 0;
                background: white;
                z-index: 1000;
                display: flex;
                align-items: flex-start; /* hoặc center, tùy ý mày */
                padding: 15px;
                border: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="SidebarDashboard.jsp"></jsp:include>

            <div class="content">
                <div class="hi">
                <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                </div>
                <!-- Product Detail Card -->
                <div class="product-card">
                    <div class="card-body">
                        <div class="product-content row">
                            <!-- Left: Product Images -->
                            <div class="col-md-5 product-images">
                            <c:if test="${not empty product.image}">
                                <img id="mainImage" class="main-image" 
                                     src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image}" 
                                     alt="${product.fullName} - Main Image">
                            </c:if>
                            <div class="product-gallery">
                                <c:if test="${not empty product.image1}">
                                    <img src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image1}" 
                                         alt="${product.fullName} - Image 1" onclick="swapImage(this)">
                                </c:if>
                                <c:if test="${not empty product.image2}">
                                    <img src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image2}" 
                                         alt="${product.fullName} - Image 2" onclick="swapImage(this)">
                                </c:if>
                                <c:if test="${not empty product.image3}">
                                    <img src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image3}" 
                                         alt="${product.fullName} - Image 3" onclick="swapImage(this)">
                                </c:if>
                            </div>
                        </div>
                        <!-- Right: Product Information -->
                        <div class="col-md-7 product-info">
                            <h2>${product.fullName}</h2>
                            <div class="info-item">
                                <span class="info-label">Product ID:</span>
                                <span class="info-value">${product.productId}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Category:</span>
                                <span class="info-value">${product.categoryName}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Brand:</span>
                                <span class="info-value">${product.brandName}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Model:</span>
                                <span class="info-value">${product.model}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Attributes:</span>
                                <c:if test="${not empty product.attributeDetails}">
                                    <ul class="list-unstyled">
                                        <c:forEach var="attr" items="${product.attributeDetails}">
                                            <li><strong>${attr.attributeName}:</strong> ${attr.attributeInfor}</li>
                                            </c:forEach>
                                    </ul>
                                </c:if>
                                <c:if test="${empty product.attributeDetails}">
                                    <span class="text-danger">No attributes found</span>
                                </c:if>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Stock:</span>
                                <span class="info-value">${product.stock}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Price:</span>
                                <span class="info-value">${product.getPriceFormatted()}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Description:</span>
                                <span class="info-value">${product.description}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Status:</span>
                                <span class="badge ${product.deleted == 1 ? 'bg-danger' : 'bg-success'}">
                                    ${product.deleted == 1 ? 'Deleted' : 'Active'}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript: Swap Main Image -->
        <script>
            function swapImage(img) {
                const mainImg = document.getElementById("mainImage");
                const tempSrc = mainImg.src;
                mainImg.src = img.src;
                img.src = tempSrc;
            }
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
