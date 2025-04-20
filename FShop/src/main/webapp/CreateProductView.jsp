<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Product</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .content {
                flex-grow: 1;
                padding: 12px;
                display: flex;
                flex-direction: column;
                gap: 20px;
                margin-left: 250px;
                margin-top: 80px;
            }

            .header {
                position: fixed;
                top: 0;
                left: 260px;
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
                left: 267px;
                right: 0;
                background: white;
                z-index: 1000;
                display: flex;
                align-items: flex-start;
                padding: 15px;
                border: 5px;
            }

            .error{
                color: red;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <jsp:include page="SidebarDashboard.jsp"></jsp:include>
            <div class="content">
                <div class="hi">
                <jsp:include page="HeaderDashboard.jsp"></jsp:include>
                </div>
                <div class="container-fluid">
                    <div class="card shadow border-primary">
                        <div class="card-header">
                            <h3>Create New Product</h3>
                        </div>
                        <div class="card-body">
                            <form action="CreateProductServlet" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="categoryName" value="${categoryName}" />
                            <!-- Horizontal Form Layout -->
                            <div class="container-fluid">
                                <!-- Row 1: Category, Brand, Model -->
                                <div class="row g-3 align-items-center">
                                    <div class="col-md-4">
                                        <label class="form-label">Category</label>
                                        <select class="form-select" name="categoryName" id="categoryName" required>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="CreateProductServlet?name=${category}" ${category == categoryName ? 'selected' : ''}>${category}</option>
                                            </c:forEach>
                                        </select>
                                        <p></p>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Brand</label>
                                        <select class="form-select" name="brandName" required>
                                            <c:forEach var="brand" items="${brands}">
                                                <option value="${brand}" ${brand == brandName ? 'selected' : ''} >${brand}</option>
                                            </c:forEach>
                                        </select>
                                        <p></p>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Model</label>
                                        <input type="text" class="form-control" name="model" value="${model != null ? model : ''}" required />
                                        <p class="error">${errorMsg1}</p>
                                    </div>                                       
                                </div>
                                <!-- Row 2: Full Name, Price, Is Deleted -->
                                <div class="row g-3 align-items-center mt-2">
                                    <div class="col-md-4">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" class="form-control" name="fullname" value="${fullname != null ? fullname : ''}" required />
                                        <p class="error">${errorMsg2}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Price</label>
                                        <input type="number" class="form-control" name="price" value="${price != null ? price : ''}" required />
                                        <p class="error">${errorMsg3}</p>                        
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Disable</label>
                                        <select class="form-select" name="isDeleted">
                                            <option value="1">Yes</option>
                                        </select>
                                        <p></p>
                                    </div>
                                </div>
                                <!-- Row 3: Description -->
                                <div class="row g-3 mt-2">
                                    <div class="col-md-12">
                                        <label class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3" required>${description != null ? description : ''}</textarea>
                                    </div>
                                </div>
                                <!-- Row 4: Attributes -->
                                <div class="row g-3 mt-2">
                                    <div class="col-md-12">
                                        <label class="form-label">Attributes</label>
                                        <c:if test="${not empty attributes}">
                                            <div class="border p-3 rounded">
                                                <c:forEach var="attr" items="${attributes}">
                                                    <div class="row align-items-center mb-2">
                                                        <div class="col-md-4">
                                                            <label class="form-label fw-bold">${attr.attributeName}</label>
                                                            <input type="hidden" name="attributeId" value="${attr.attributeId}" />
                                                        </div>
                                                        <div class="col-md-8">
                                                            <input type="text" class="form-control" name="attributeInfor_${attr.attributeId}" 
                                                                   placeholder="Enter ${attr.attributeName}" value="${attributeMap[attr.attributeId] != null ? attributeMap[attr.attributeId] : ''}" required />
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                        <c:if test="${empty attributes}">
                                            <p class="text-danger">No attributes available for the selected category.</p>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- Row 5: Image Uploads -->
                                <div class="row g-3 mt-2">
                                    <div class="col-md-3">
                                        <label class="form-label">Image 1</label>
                                        <input type="file" class="form-control" name="txtP1" value="${image1 != null ? image1 : ''}" accept="image/*" required />
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Image 2</label>
                                        <input type="file" class="form-control" name="txtP2" accept="image/*" />
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Image 3</label>
                                        <input type="file" class="form-control" name="txtP3" accept="image/*" />
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">Image 4</label>
                                        <input type="file" class="form-control" name="txtP4" accept="image/*" />
                                    </div>
                                </div>
                                <!-- Submit Button -->
                                <div class="row g-3 mt-3">
                                    <div class="col-md-12 text-end">
                                        <button type="submit" class="btn btn-primary">Create Product</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>   
        <script>
            document.getElementById("categoryName").addEventListener("change", function () {
                let url = this.value;
                if (url) {
                    window.location.href = url;
                }
            });
        </script>
    </body>
</html>
