<%-- 
    Document   : ProductDetailView
    Created on : 25-Feb-2025, 10:56:52
    Author     : kiuth
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="vi_VN" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Detail</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Google Font (optional) -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./assets/css/popup.css"/>
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f5f5f5;
                color: #333;
            }
            .product-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                padding: 20px;
                margin-top: 20px;
            }
            /* Gallery */
            .product-gallery {
                margin-bottom: 20px;
            }
            /* Larger main image */
            .product-gallery .main-image {
                width: 100%;
                max-width: 450px; /* increased size */
                border: 2px solid #ddd;
                border-radius: 8px;
                display: block;
                margin: 0 auto; /* center the image */
            }
            .sub-images {
                display: flex;
                gap: 10px;
                margin-top: 15px;
                justify-content: center; /* center the sub-images */
            }
            .sub-images img {
                width: 70px;
                height: 70px;
                object-fit: cover;
                border: 2px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                transition: transform 0.2s, border-color 0.2s;
            }
            .sub-images img:hover {
                transform: scale(1.05);
                border-color: #ff5722;
            }

            /* Product Info */
            .product-info {
                background: #fafafa; /* subtle background for emphasis */
                border-radius: 8px;
                padding: 20px;
            }
            .product-info h1 {
                font-size: 2rem; /* larger title */
                margin-bottom: 10px;
                font-weight: 700;
                line-height: 1.2;
            }
            .rating {
                color: #f59e0b; /* yellow star color */
                font-size: 1.25rem; /* slightly bigger stars */
            }
            .text-secondary {
                font-size: 0.95rem;
            }
            /* Highlight price */
            .price {
                color: #d0011b;
                font-size: 2rem; /* larger price font */
                font-weight: 700;
                margin-bottom: 15px;
            }
            /* Buttons */
            .btn-buy-now {
                background-color: #d0011b;
                border: none;
                color: #fff;
                font-weight: 600;
                padding: 12px 20px;
                border-radius: 6px;
                font-size: 1rem;
            }
            .btn-buy-now:hover {
                background-color: #b60015;
            }
            .btn-add-cart {
                background-color: #ff5722;
                border: none;
                color: #fff;
                font-weight: 600;
                padding: 12px 20px;
                border-radius: 6px;
                font-size: 1rem;
            }
            .btn-add-cart:hover {
                background-color: #e64a19;
            }
            /* Quantity Controls */
            .quantity-controls {
                display: inline-flex;
                align-items: center;
                margin-left: 15px;
            }
            .quantity-controls input {
                width: 60px;
                text-align: center;
                border: 1px solid #ccc;
                margin: 0 5px;
                border-radius: 4px;
                font-size: 1rem;
            }
            .quantity-controls button {
                background: #fff;
                border: 1px solid #ccc;
                width: 34px;
                height: 34px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 1.2rem;
                line-height: 1;
            }
            .quantity-controls button:hover {
                background: #f0f0f0;
            }
            /* Shipping Info */
            .shipping-info {
                background: #fff;
                border: 1px solid #eee;
                border-radius: 6px;
                padding: 15px;
                margin-top: 20px;
            }
            .shipping-info p {
                margin: 0 0 6px;
                font-size: 0.95rem;
            }
            .action-buttons .btn {
                margin-right: 10px;
            }
            .share-like a {
                margin-right: 15px;
                color: #666;
                text-decoration: none;
                font-weight: 500;
            }
            .share-like a:hover {
                color: #333;
            }
            /* Table for attributes */
            .product-attributes {
                margin-top: 20px;
            }
            .product-attributes h5 {
                font-weight: 700;
                margin-bottom: 15px;
            }
            /* Responsive */
            @media (max-width: 768px) {
                .product-container {
                    padding: 10px;
                }
                .product-gallery,
                .product-info {
                    width: 100%;
                }
                .product-gallery .main-image {
                    max-width: 100%;
                }
                .feedback-container {
                    min-height: auto;
                }
            }
            main {
                /*min-height: auto;*/
                padding-bottom: 50px;
            }

            .profile {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            .profile img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin-right: 10px;
            }
            .star-icon {
                font-size: 20px;
                color: #ccc;
            }
            .checked {
                color: #ffcc00;
            }
            .review-card {
                background: #fff;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
            }
            .reply-container {
                margin-left: 30px;
                padding: 10px;
                background: #f1f1f1;
                border-radius: 5px;
            }
            .star-rating {
                display: flex;
                flex-direction: row-reverse;
                justify-content: center;
                font-size: 24px;
                margin-bottom: 10px;
            }
            .star-rating input {
                display: none;
            }
            .star-rating label {
                cursor: pointer;
                color: #ccc;
            }
            .star-rating label:hover,
            .star-rating label:hover ~ label,
            .star-rating input:checked ~ label {
                color: #ffcc00;
            }
            textarea {
                width: 100%;
                height: 100px;
                padding: 10px;
                border-radius: 5px;
                margin-top: 10px;
            }
            button {
                background-color: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
            }
            button:hover {
                background-color: #218838;
            }

            .star-rating i {
                color: #FFD700;
            }
            /* ========== Quantity Controls ========== */
            .quantity-controls {
                display: inline-flex;
                align-items: center;
                border: 1px solid #ced4da;
                border-radius: 4px;
                overflow: hidden;
            }

            .quantity-controls button {
                background-color: #f8f9fa;
                border: none;
                width: 40px;
                height: 40px;
                font-size: 1.2rem;
                color: #495057;
                cursor: pointer;
                transition: background-color 0.3s, border-color 0.3s;
            }

            .quantity-controls button:hover {
                background-color: #e2e6ea;
            }

            .quantity-controls input {
                width: 60px;
                height: 40px;
                text-align: center;
                border: none;
                font-size: 1rem;
            }

            /* ========== Action Buttons with Pastel Colors ========== */
            /* Container ch?a 2 form n?t */
            .action-buttons {
                display: flex;
                gap: 1rem; /* kho?ng c?ch gi?a 2 n?t */
                margin-top: 1rem;
            }

            /* ?p d?ng flex cho m?i form: form ??u ti?n (Add to Cart) c? flex:1, form th? hai (Buy Now) c? flex:3 */
            .action-buttons form {
                margin: 0;
            }
            .action-buttons form:first-child {
                flex: 1;
            }
            .action-buttons form:last-child {
                flex: 3;
            }

            /* Cho n?t b?n trong form chi?m to?n b? chi?u r?ng c?a form */
            .action-buttons form button {
                display: block;
                width: 100%;
            }

            /* N?t Add to Cart: nh?, n?n tr?ng, vi?n ?? v? ch? ?? */
            button.btn-add-cart {
                background-color: #ffffff !important;
                border: 1px solid #d0011b !important;
                color: #d0011b !important;
                padding: 12px 20px !important;  /* k?ch th??c nh? h?n */
                font-size: 14px !important;
                border-radius: 4px !important;
                transition: background-color 0.3s ease, transform 0.3s ease !important;
            }
            button.btn-add-cart:hover {
                background-color: #ffe6e6 !important;
                transform: scale(1.03) !important;
            }

            /* N?t Buy Now: l?n, n?n ??, ch? tr?ng */
            button.btn-buy-now {
                background-color: #d0011b !important;
                border: none !important;
                color: #ffffff !important;
                padding: 12px 20px !important;  /* k?ch th??c l?n h?n */
                font-size: 16px !important;
                border-radius: 4px !important;
                transition: background-color 0.3s ease, transform 0.3s ease !important;
            }
            button.btn-buy-now:hover {
                background-color: #b60015 !important;
                transform: scale(1.03) !important;
            }





            /* =================== Feedback Section Container =================== */
            .feedback-section {
                margin-top: 40px;
            }

            /* =================== Review Card =================== */
            .review-card {
                background: #fff;
                padding: 15px;
                margin-bottom: 15px;
                border-top: 1px solid #ddd;
                border-bottom: 1px solid #ddd;
                border-left: none;
                border-right: none;
            }
            .review-card:hover {
                /*box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);*/
            }

            /* Profile Info */
            .review-card .profile {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            .review-card .profile img {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                margin-right: 15px;
                border: 1px solid #ddd;
            }
            .review-card h4 {
                font-size: 1rem;
                font-weight: 600;
                margin: 0;
                color: #333;
            }
            .review-card small {
                color: #888;
                font-size: 0.85rem;
            }

            /* Star Rating */
            .star-icon {
                margin-bottom: 1%;
                margin-left: 5%;
            }
            .star-icon i {
                font-size: 1rem;
                color: #ccc;
                margin-right: 2px;
            }
            .star-icon i.checked {
                color: #ffcc00;
            }

            /* Review Text */
            .review-card p {
                font-size: 0.95rem;
                line-height: 1.5;
                color: #555;
                margin: 0;
            }
            .rateComment {
                font-size: 1rem !important;
                color: #555 !important;
                line-height: 1.5 !important;
                font-style: italic !important;
                margin-left: 5%! important;

            }

            /* =================== Reply Container =================== */
            .reply-container {
                background: #f7f7f7;
                border-left: 3px solid #007bff;
                padding: 15px;
                margin-left: 7%;
                margin-top: 15px;
                border-radius: 4px;
                font-size: 0.9rem;
                color: #555;
            }
            .reply-container strong {
                display: block;
                margin-bottom: 8px;
                color: #333;
            }

            /* =================== Review Form =================== */
            #reviewForm {
                background: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                margin-top: 30px;
            }
            #reviewForm label.rating-label {
                font-weight: 600;
                margin-bottom: 10px;
                display: block;
                font-size: 1rem;
                color: #333;
            }

            /* Star Rating in Form */
            .star-rating {
                margin-bottom: 15px;
            }
            .star-rating input {
                display: none;
            }
            .star-rating label {
                font-size: 1.5rem;
                color: #ccc;
                cursor: pointer;
                margin-right: 5px;
                transition: color 0.2s ease;
            }
            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #ffcc00;
            }

            /* Textarea */
            #reviewForm textarea {
                width: 100%;
                height: 120px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 0.95rem;
                resize: vertical;
                margin-bottom: 15px;
            }

            /* Submit Button */
            #reviewForm button[type="submit"] {
                background: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                font-size: 1rem;
                cursor: pointer;
                transition: background 0.3s ease;
            }
            #reviewForm button[type="submit"]:hover {
                background: #0056b3;
            }


            .feedback-container {
                background-color: #fff;
                /*border-radius: 10px;*/
                /*box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);*/
                padding: 25px;
                margin-top: 40px;
                width: 70%;
                min-height: 500px;
            }


            .feedback-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 20px;
                text-align: center;
                color: #333;
            }


            .review-card {
                background: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 15px;
                transition: all 0.3s ease;
            }

            .review-card:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .profile {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .profile img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                margin-right: 10px;
            }


            .star-icon {
                font-size: 20px;
                color: #ffcc00;
                margin-bottom: 10px;
            }


            .review-card p {
                font-size: 1rem;
                color: #555;
            }


            .reply-container {
                background: #f1f1f1;
                border-left: 3px solid #007bff;
                padding: 10px;
                margin-top: 10px;
                border-radius: 5px;
                font-size: 0.9rem;
                color: #555;
            }


            #reviewForm {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin-top: 30px;
            }

            .rating-label {
                font-weight: 600;
                display: block;
                margin-bottom: 10px;
            }

            .star-rating {
                display: flex;
                justify-content: center;
                margin-bottom: 10px;
            }

            .star-rating input {
                display: none;
            }

            .star-rating label {
                font-size: 1.5rem;
                color: #ccc;
                cursor: pointer;
                margin-right: 5px;
                transition: color 0.2s ease;
            }

            .star-rating input:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: #ffcc00;
            }

            textarea {
                width: 100%;
                height: 100px;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                margin-top: 10px;
            }

            button {
                background-color: #007bff;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
                width: 100%;
            }

            button:hover {
                background-color: #0056b3;
            }
            .feedback-container {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                padding: 35px;
                margin-top: 40px;
                /*                max-width: 800px;*/
                width: 100%;

            }

            .hethang{
                color: red;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <main>
                <div class="container">
                <c:choose>
                    <c:when test="${product != null}">

                        <div class="product-container row">

                            <!-- Image section -->
                            <div class="col-md-6 product-gallery d-flex flex-column align-items-center">
                                <c:set var="mainImage" value="${product.image}" />
                                <img id="mainImage" 
                                     class="main-image" 
                                     src="<c:out value='${pageContext.request.contextPath}'/>/assets/imgs/Products/<c:out value='${mainImage}'/>" 
                                     alt="${product.fullName}"/>
                                <div class="sub-images">
                                    <!-- Sub-image 1 -->
                                    <c:if test="${not empty product.image1}">
                                        <img src="<c:out value='${pageContext.request.contextPath}'/>/assets/imgs/Products/${product.image1}" 
                                             alt="sub1" 
                                             onclick="swapImage(this)">
                                    </c:if>
                                    <!-- Sub-image 2 -->
                                    <c:if test="${not empty product.image2}">
                                        <img src="<c:out value='${pageContext.request.contextPath}'/>/assets/imgs/Products/${product.image2}" 
                                             alt="sub2" 
                                             onclick="swapImage(this)">
                                    </c:if>
                                    <!-- Sub-image 3 -->
                                    <c:if test="${not empty product.image3}">
                                        <img src="<c:out value='${pageContext.request.contextPath}'/>/assets/imgs/Products/${product.image3}" 
                                             alt="sub3" 
                                             onclick="swapImage(this)">
                                    </c:if>
                                </div>
                            </div>

                            <!-- Product info section -->
                            <div class="col-md-6 product-info">
                                <h1>${product.fullName}</h1>

                                <div class="d-flex align-items-center">
                                    <h3 class="mb-0 me-2">${star}</h3>
                                    <div class="star-rating">
                                        <c:forEach begin="${star + 1}" end="5" var="i">
                                            <i class="far fa-star"></i> 
                                        </c:forEach>
                                        <c:forEach begin="1" end="${star}" var="i">
                                            <i class="fas fa-star"></i> 
                                        </c:forEach>

                                    </div>
                                </div>

                                <!-- Price -->
                                <div class="price">
                                    ${product.getPriceFormatted()}
                                </div>

                                <!-- Technical Specifications in a table -->
                                <div class="product-attributes">
                                    <h5>Technical Specifications</h5>
                                    <table class="table table-striped">
                                        <tbody>
                                            <c:forEach var="attr" items="${product.attributeDetails}">
                                                <tr>
                                                    <th style="width: 35%;">${attr.attributeName}</th>
                                                    <td>${attr.attributeInfor}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Shipping info / Policy -->
                                <div class="shipping-info">
                                    <c:if test="${product.stock<=0}">
                                        <h5 class="hethang">Product is temporarily out of stock</h5>
                                    </c:if>
                                    <p><strong>Shipping:</strong> Free nationwide shipping</p>
                                    <p><strong>Warranty:</strong> 12 months</p>
                                    <p><strong>Return Policy:</strong> 15 days if defective</p>
                                </div>
                                <c:if test="${not empty product.stock and product.stock>0 and product.deleted==0}"> 
                                    <!-- Quantity Control -->
                                    <div class="my-3 d-flex align-items-center">
                                        <label for="quantity" class="me-2 fw-bold">Quantity:</label>
                                        <div class="quantity-controls">
                                            <button type="button" onclick="decreaseQuantity()">-</button>
                                            <input type="number" id="quantity" name="quantity" value="1" min="1" 
                                                   max="${product.getStock()}" oninput="validateQuantity()">
                                            <button type="button" onclick="increaseQuantity()">+</button>
                                        </div>
                                    </div>
                                </c:if>
                                <!-- Bootstrap Modal -->
                                <div class="modal fade" id="quantityWarningModal" tabindex="-1" aria-labelledby="warningModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-danger" id="warningModalLabel">Warning</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body text-dark">
                                                You are allowed to buy a maximum quantity of <b>5</b>! 
                                                <br>
                                                Or if you want to buy more, contact us at: 
                                                <a href="mailto:kieuthy@gmail.com" class="text-primary">kieuthy@gmail.com</a>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">OK</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Bootstrap Modal -->
                                <div class="modal fade" id="stockLimit" tabindex="-1" aria-labelledby="warningModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title text-danger" id="warningModalLabel">Warning</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body text-dark">
                                                Current quantity is not enough!
                                                <br>
                                                You can contact us by email:
                                                <a href="mailto:kieuthy@gmail.com" class="text-primary">kieuthy@gmail.com</a>
                                                to reserve.
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">OK</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty product.stock and product.stock>0 and product.deleted==0}">      
                                    <!-- Action Buttons -->
                                    <div class="action-buttons">
                                        <!-- Add to Cart form -->
                                        <form action="AddToCart?productID=${product.productId}" method="POST">
                                            <input type="hidden" name="quantity" id="quantityInputHidden" value="1">
                                            <button id="addToCartBtn" type="submit" class="btn btn-add-cart">
                                                <i class="fas fa-shopping-cart me-1"></i> Add to Cart
                                            </button>
                                        </form>
                                        <!-- Buy Now form -->
                                        <form action="order" method="POST">
                                            <input type="hidden" name="quantity" id="quantityInputHiddenBuyNow" value="1">
                                            <input type="hidden" name="orderUrl" value="buyNow">
                                            <input type="hidden" name="productSelected" value="${product.productId}">
                                            <input type="hidden" name="buyProductAction" value="checkout">
                                            <button id="buyNowBtn" type="submit" class="btn btn-buy-now">
                                                <i class="fas fa-bolt me-1"></i> Buy Now
                                            </button>
                                        </form>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-center mt-5">Product not found.</p>
                    </c:otherwise>
                </c:choose>



                <div id="feedbackContainer" class="feedback-section">
                    <div class="feedback-container">
                        <h3 class="feedback-title">PRODUCT REVIEW</h3>
                        <c:if test="${param.success == 'created'}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fa-solid fa-circle-check me-2"></i> Creating Feedback successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                           <c:if test="${empty dataRating}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fa-solid fa-circle-check me-2"></i>This product has no reviews yet. Be the first to share your experience!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${param.success == 'deleted'}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fa-solid fa-circle-check me-2"></i> Creating Feedback successfully!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <c:if test="${isOk}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fa-solid fa-triangle-exclamation me-2"></i> Reminder: Only one comment is allowed per product!!!
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>

                            <form id="reviewForm" method="POST" action="ProductDetailServlet">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <input type="hidden" name="customerId" value="${customerId}">
                                <label class="rating-label">Share your experience:</label>
                                <div class="star-rating">
                                    <input required type="radio" name="star" value="5" id="star5"><label for="star5" class="fa fa-star"></label>
                                    <input required type="radio" name="star" value="4" id="star4"><label for="star4" class="fa fa-star"></label>
                                    <input required type="radio" name="star" value="3" id="star3"><label for="star3" class="fa fa-star"></label>
                                    <input required type="radio" name="star" value="2" id="star2"><label for="star2" class="fa fa-star"></label>
                                    <input required type="radio" name="star" value="1" id="star1"><label for="star1" class="fa fa-star"></label>
                                </div>
                                <textarea required name="comment" placeholder="Write your review..."></textarea>
                                <button type="submit">Submit Review</button>
                            </form>
                        </c:if>
                        <c:forEach var="rate" items="${dataRating}">
                            <div class="review-card">
                                <div class="profile">
                                    <img src="assets/imgs/icon/person.jpg" alt="Avatar">
                                    <div>
                                        <h4>${rate.fullName}</h4>
                                        <small>${rate.createdDate}</small>
                                    </div>
                                </div>
                                <div class="star-icon">
                                    <c:forEach var="i" begin="1" end="5">
                                        <c:choose>
                                            <c:when test="${i <= rate.star}">
                                                <i class="fa fa-star checked"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa fa-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <p class="rateComment">${rate.isDeleted ? "\"This feedback was hidden for some reason.\"" : rate.comment}</p>
                                <c:forEach var="reply" items="${dataReplies}">
                                    <c:if test="${reply.rateID == rate.rateID}">
                                        <div class="reply-container">
                                            <strong>Shop Manager:</strong> ${reply.answer}
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>


                        </c:forEach>


                    </div>


                    <!-- Bootstrap Modal -->
                    <div class="modal fade" id="updatePopup" tabindex="-1" aria-labelledby="updatePopupLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <c:choose>
                                        <c:when test="${sessionScope.message.contains('add your address') ||
                                                        sessionScope.message.contains('add your phone number') ||
                                                        sessionScope.message.contains('Go to your cart')}">
                                                <h5 class="modal-title text-danger">Notification</h5>
                                        </c:when>
                                        <c:otherwise>
                                            <h5 class="modal-title text-danger">Warning</h5>
                                        </c:otherwise>
                                    </c:choose>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body text-dark">
                                    <c:choose>
                                        <c:when test="${sessionScope.message.contains('a maximum')}">
                                            <p> You are allowed to buy a maximum quantity of <b>5</b>! 
                                                <br>
                                                Or if you want to buy more, contact us at: 
                                                <a href="mailto:kieuthy@gmail.com" class="text-primary">kieuthy@gmail.com</a>
                                            </p>
                                        </c:when>
                                        <c:when test="${sessionScope.message.contains('total amount too big')}">
                                            <p> You can buy product online with the total amount <br> under <b><fmt:formatNumber value="100000000" type="currency" /></b>! 
                                                <br>
                                                Or if you want to buy, contact us at: 
                                                <a href="mailto:kieuthy@gmail.com" class="text-primary">kieuthy@gmail.com</a>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${sessionScope.message}</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="modal-footer">
                                    <c:choose>
                                        <c:when test="${sessionScope.message.contains('add your address')}">
                                            <a class="btn btn-primary text-white" href="ViewShippingAddress">OK</a>
                                            <a class="btn btn-secondary text-white" onclick='closePopup()'>Cancel</a>
                                        </c:when>
                                        <c:when test="${sessionScope.message.contains('add your phone number')}">
                                            <a class="btn btn-primary text-white" href="viewCustomerProfile">OK</a>
                                            <a class="btn  btn-secondary text-white" onclick='closePopup()'>Cancel</a>
                                        </c:when>
                                        <c:when test="${sessionScope.message.contains('Go to your cart')}">
                                            <a class="btn btn-primary text-white" href="cart">OK</a>
                                            <a class="btn btn-secondary text-white" onclick='closePopup()'>Cancel</a>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">OK</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>



        </main>
        <jsp:include page="footer.jsp"></jsp:include>
            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                                                window.onload = function () {
            <% if (session.getAttribute("message") != null) { %>
                                                    showMessage(true);
            <% }%>
                                                };
                                                function showMessage(show) {
                                                    if (show) {
                                                        var warningModal = new bootstrap.Modal(document.getElementById('updatePopup'));
                                                        warningModal.show();
                                                    }
                                                }
                                                // Swap main and sub images
                                                function swapImage(img) {
                                                    const mainImg = document.getElementById("mainImage");
                                                    const tempSrc = mainImg.src;
                                                    mainImg.src = img.src;
                                                    img.src = tempSrc;
                                                }
                                                function getMaxQuantity() {
                                                    const stockQuantity = parseInt("${product.getStock()}");
                                                    return Math.min(stockQuantity, 5);
                                                }

                                                function increaseQuantity() {
                                                    const quantityInput = document.getElementById('quantity');
                                                    const maxQuantity = getMaxQuantity();
                                                    let currentVal = parseInt(quantityInput.value);

                                                    if (currentVal < maxQuantity) {
                                                        quantityInput.value = currentVal + 1;
                                                        showWarning(false);
                                                    } else {
                                                        showWarning(true, maxQuantity === 5 ? 'quantityWarningModal' : 'stockLimit');
                                                    }
                                                    validateButtons();
                                                    syncHiddenInputs();
                                                }

                                                function decreaseQuantity() {
                                                    const quantityInput = document.getElementById('quantity');
                                                    let currentVal = parseInt(quantityInput.value);

                                                    if (currentVal > 1) {
                                                        quantityInput.value = currentVal - 1;
                                                        showWarning(false);
                                                    }
                                                    validateButtons();
                                                    syncHiddenInputs();
                                                }

                                                function validateQuantity() {
                                                    const quantityInput = document.getElementById('quantity');
                                                    const maxQuantity = getMaxQuantity();
                                                    let currentVal = parseInt(quantityInput.value);

                                                    if (isNaN(currentVal) || currentVal < 1) {
                                                        currentVal = 1;
                                                    } else if (currentVal > maxQuantity) {
                                                        currentVal = maxQuantity;
                                                        showWarning(true, maxQuantity === 5 ? 'quantityWarningModal' : 'stockLimit');
                                                    }

                                                    quantityInput.value = currentVal;
                                                    syncHiddenInputs();
                                                    validateButtons();
                                                }

                                                function validateButtons() {
                                                    const quantityInput = document.getElementById('quantity');
                                                    const maxQuantity = getMaxQuantity();
                                                    const addToCartBtn = document.getElementById('addToCartBtn');
                                                    const buyNowBtn = document.getElementById('buyNowBtn');

                                                    const isDisabled = parseInt(quantityInput.value) > maxQuantity;
                                                    addToCartBtn.disabled = isDisabled;
                                                    buyNowBtn.disabled = isDisabled;
                                                }

                                                function showWarning(show, modalId = 'quantityWarningModal') {
                                                    if (show) {
                                                        var warningModal = new bootstrap.Modal(document.getElementById(modalId));
                                                        warningModal.show();
                                                }
                                                }

                                                function syncHiddenInputs() {
                                                    const quantity = document.getElementById("quantity").value;
                                                    document.getElementById("quantityInputHidden").value = quantity;
                                                    document.getElementById("quantityInputHiddenBuyNow").value = quantity;
                                                }
                                                function closePopup() {
                                                    var warningModal = bootstrap.Modal.getInstance(document.getElementById('updatePopup'));
                                                    if (warningModal) {
                                                        warningModal.hide();
                                                    }
                                                }


                                                // When user manually changes the quantity input
                                                document.getElementById("quantity")?.addEventListener("input", function () {
                                                    document.getElementById("quantityInputHidden").value = this.value;
                                                    document.getElementById("quantityInputHiddenBuyNow").value = this.value;
                                                });



        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    <c:if test="${not empty sessionScope.message}">
        <c:remove var="message" scope="session"/>
    </c:if>
</html>
