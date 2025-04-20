<%-- 
    Document   : UpdateProductView
    Created on : 25-Feb-2025, 10:49:02
    Author     : kiuth
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            .product-image {
                max-width: 80px;
            }
            .content {
                flex-grow: 1;
                padding: 12px;
                display: flex;
                flex-direction: column;
                gap: 20px;
                margin-left: 250px;
                margin-top: 80px;
            }
            .error-message {
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .error-message .close-btn {
                background-color: transparent;
                border: none;
                color: #721c24;
                font-size: 20px;
                cursor: pointer;
            }

            .error-message .close-btn:hover {
                color: #f5c6cb;
            }
            .header {
                position: fixed;
                top: 0;
                left: 260px; 
                right: 10px;
                margin-top: 10px;
                z-index: 1000;
            }

            .hi {
                position: fixed;
                top: 0;
                left: 267px;
                right: 0;
                background: white;
                z-index: 1000;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                padding: 18px;
                border: 5px;
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
        </style>
    </head>
    <body>
        <jsp:include page="SidebarDashboard.jsp"></jsp:include>
            <div class="content">
                <div class="hi">
                <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                </div>
            <c:choose>
                <c:when test="${product != null}">
                    <div class="container-fluid">
                        <%
                            String error = (String) session.getAttribute("error");
                            if (error != null) {
                        %>
                        <div class="error-message">
                            <span><%= error%></span>
                            <button class="close-btn" onclick="this.parentElement.style.display = 'none'">&times;</button>
                        </div>
                        <%
                                session.removeAttribute("error"); // Xóa thông báo sau khi hi?n th?
                            }
                        %>
                        <div class="card shadow border-primary">
                            <div class="card-header">
                                <h3>Update Product</h3>
                            </div>
                            <div class="card-body">
                                <form action="UpdateProductServlet" method="post" enctype="multipart/form-data">
                                    <!-- Hidden Fields -->
                                    <input type="hidden" name="id" value="${product.productId}" />
                                    <input type="hidden" name="currentImage" value="${product.image}" />

                                    <!-- Row 1: Category, Brand, Full Name -->
                                    <div class="row g-3 align-items-center">
                                        <div class="col-md-4">
                                            <label class="form-label">Category</label>
                                            <select class="form-select" disabled>
                                                <c:forEach var="cat" items="${categories}">
                                                    <option value="${cat}" ${cat == product.categoryName ? 'selected' : ''}>${cat}</option>
                                                </c:forEach>
                                            </select>
                                            <input type="hidden" name="categoryName" value="${product.categoryName}" />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Brand</label>
                                            <select class="form-select" name="brandName">
                                                <c:forEach var="brand" items="${brands}">
                                                    <option value="${brand}" ${brand == product.brandName ? 'selected' : ''}>${brand}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Full Name</label>
                                            <input type="text" class="form-control" name="fullName" value="${product.fullName}" required />
                                        </div>
                                    </div>

                                    <!-- Row 3: Price and Is Deleted -->
                                    <div class="row g-3 mt-2">
                                        <div class="col-md-4">                                      
                                            <label class="form-label">Price</label>
                                            <input type="number" class="form-control" name="price" value="${product.price}" required />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Is Deleted</label>
                                            <select class="form-select" name="isDeleted">
                                                <option value="0" ${product.deleted == 0 ? 'selected' : ''}>No</option>
                                                <option value="1" ${product.deleted == 1 ? 'selected' : ''}>Yes</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Model</label>
                                            <input type="text" class="form-control" name="model" value="${product.model}" required />
                                        </div>
                                    </div>
                                    <!-- Row 2: Description -->
                                    <div class="row g-3 mt-2">
                                        <div class="col-md-12">
                                            <label class="form-label">Description</label>
                                            <textarea class="form-control" name="description" rows="3" required>${product.description}</textarea>
                                        </div>
                                    </div>

                                    <!-- Row 4: Attributes -->
                                    <div class="row g-3 mt-2">
                                        <div class="col-md-12">
                                            <label class="form-label">Attributes</label>
                                            <c:if test="${not empty product.attributeDetails}">
                                                <div class="border p-3 rounded">
                                                    <c:forEach var="attr" items="${product.attributeDetails}">
                                                        <div class="row align-items-center mb-2">
                                                            <div class="col-md-4">
                                                                <label class="form-label fw-bold">${attr.attributeName}</label>
                                                                <input type="hidden" name="attributeId" value="${attr.attributeId}" />
                                                            </div>
                                                            <div class="col-md-8">
                                                                <input type="text" class="form-control" name="attributeInfor_${attr.attributeId}" 
                                                                       value="${attr.attributeInfor}" placeholder="Enter ${attr.attributeName}" />
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                            <c:if test="${empty product.attributeDetails}">
                                                <p class="text-danger">No attributes available for selected category.</p>
                                            </c:if>
                                        </div>
                                    </div>
                                    <!-- Row 5: Images Upload -->
                                    <div class="row g-3 mt-2">
                                        <!-- Image 1 -->
                                        <div class="col-md-3">
                                            <label class="form-label">Current Image</label>
                                            <c:if test="${not empty product.image}">
                                                <div class="mb-2">
                                                    <img id="currentImage1" src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image}" 
                                                         class="product-image img-thumbnail" alt="${product.fullName}">
                                                </div>
                                            </c:if>
                                            <c:if test="${empty product.image}">
                                                <p>No image uploaded.</p>
                                            </c:if>
                                            <input type="file" class="form-control" name="txtPPic" accept="image/*" onchange="previewImage(event, 'currentImage1')"/>
                                        </div>

                                        <!-- Image 2 -->
                                        <div class="col-md-3">
                                            <label class="form-label">Current Image</label>
                                            <c:if test="${not empty product.image1}">
                                                <div class="mb-2">
                                                    <img id="currentImage2" src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image1}" 
                                                         class="product-image img-thumbnail" alt="${product.fullName}">
                                                </div>
                                            </c:if>
                                            <c:if test="${empty product.image1}">
                                                <p>No image uploaded.</p>
                                            </c:if>
                                            <input type="file" class="form-control" name="txtPPic1" accept="image/*" onchange="previewImage(event, 'currentImage2')"/>
                                        </div>

                                        <!-- Image 3 -->
                                        <div class="col-md-3">
                                            <label class="form-label">Current Image</label>
                                            <c:if test="${not empty product.image2}">
                                                <div class="mb-2">
                                                    <img id="currentImage3" src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image2}" 
                                                         class="product-image img-thumbnail" alt="${product.fullName}">
                                                </div>
                                            </c:if>
                                            <c:if test="${empty product.image2}">
                                                <p>No image uploaded.</p>
                                            </c:if>
                                            <input type="file" class="form-control" name="txtPPic2" accept="image/*" onchange="previewImage(event, 'currentImage3')"/>
                                        </div>

                                        <!-- Image 4 -->
                                        <div class="col-md-3">
                                            <label class="form-label">Current Image</label>
                                            <c:if test="${not empty product.image3}">
                                                <div class="mb-2">
                                                    <img id="currentImage4" src="${pageContext.request.contextPath}/assets/imgs/Products/${product.image3}" 
                                                         class="product-image img-thumbnail" alt="${product.fullName}">
                                                </div>
                                            </c:if>
                                            <c:if test="${empty product.image3}">
                                                <p>No image uploaded.</p>
                                            </c:if>
                                            <input type="file" class="form-control" name="txtPPic3" accept="image/*" onchange="previewImage(event, 'currentImage4')"/>
                                        </div>
                                    </div>

                                    <script>
                                        function previewImage(event, imgId) {
                                            const file = event.target.files[0];
                                            if (file) {
                                                const reader = new FileReader();
                                                reader.onload = function (e) {
                                                    document.getElementById(imgId).src = e.target.result;
                                                }
                                                reader.readAsDataURL(file);
                                            }
                                        }
                                    </script>

                                    <!-- Row 6: Submit Buttons -->
                                    <div class="row g-3 mt-3">
                                        <div class="col-md-12 text-end">
                                            <div class="d-flex gap-3 justify-content-end">
                                                <button type="submit" class="btn btn-primary">Update Product</button>
                                                <a href="ProductListServlet" class="btn btn-secondary">Cancel</a>
                                            </div>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-danger">Product not found.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
