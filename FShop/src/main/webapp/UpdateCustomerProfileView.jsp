<%-- 
    Document   : UpdateCustomerProfileView
    Created on : Mar 19, 2025, 8:38:35 PM
    Author     : TuongMPCE180644
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Customer</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            .profile-content {
                flex: 1;
                padding: 30px;
                background: white;
                margin: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .avatar-preview {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
            }

            .profile {
                background: white;
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                justify-content: space-between;
                padding: 20px;
            }

            .info {
                width: 50%;
                min-width: 400px;
            }

            .avatar {
                width: 50%;
                min-width: 400px;
                text-align: center;
                padding: 20px;
            }

            /* CSS cho Modal */
            .phone {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
            }
            .phone-content {
                background-color: white;
                margin: 10% auto;
                padding: 20px;
                width: 300px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.3);
                text-align: center;
            }
            .close-phone {
                float: right;
                font-size: 24px;
                cursor: pointer;
            }
            #phoneError{
                color: red;
                display: none;
            }

        </style>
    </head>
    <body>
        <form action="updateCustomerProfile" method="post" enctype="multipart/form-data">
            <div class="profile" style="box-shadow: 2px 2px 2px 2px lightgray; border-radius: 10px ; ">
                <div class="info">
                    <h3>My Profile</h3>
                    <p class="text-muted">Manage your profile information to secure your account</p>

                    <div class="mb-3">
                        <label class="form-label">Email:</label>
                        <p>${sessionScope.customer.getEmail()}</p>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Name:</label>
                        <input type="text" class="form-control" name="fullname" value="${sessionScope.customer.getFullName()}" >
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Phone Number:</label>
                        <p>
                            ********<span id="phoneDisplay">${sessionScope.customer.getPhoneNumber() != null && sessionScope.customer.getPhoneNumber() != '' ? sessionScope.customer.getPhoneNumber().substring(sessionScope.customer.getPhoneNumber().length()-2) : '**'}</span> 
                            <a style="color: blue;" onclick="openModal()">Change</a>
                        </p>
                        <input id="phoneInput" name="phoneNumber" type="tel" value="${sessionScope.customer.getPhoneNumber()}" hidden>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Gender:</label>
                        <div>
                            <input type="radio" name="gender" value="Male" ${sessionScope.customer.getGender().trim().equalsIgnoreCase("Male") ? 'checked' : ''}> Male
                            <input type="radio" name="gender" value="Female" ${sessionScope.customer.getGender().trim().equalsIgnoreCase("Female") ? 'checked' : ''}> Female
                            <input type="radio" name="gender" value="Other" ${sessionScope.customer.getGender().trim().equalsIgnoreCase("Other") ? 'checked' : ''}> Other
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Date of Birth:</label>

                        <div class="row">
                            <div class="col">
                                <select class="form-select" name="day">
                                    <option>Day</option>
                                    <c:forEach var="i" begin="1" end="31">
                                        <option ${!sessionScope.customer.getBirthday().equals('') && sessionScope.customer.getBirthday().split("-")[2].equals(String.format("%02d", i)) ? 'selected' : ''}>${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col">
                                <select class="form-select" name="month">
                                    <option>Month</option>
                                    <c:forEach var="i" begin="1" end="12">
                                        <c:set var="formattedMonth" value="${String.format('%02d', i)}" />
                                        <option value="${formattedMonth}" ${!sessionScope.customer.getBirthday().equals('') && sessionScope.customer.getBirthday().split('-')[1] == formattedMonth ? 'selected' : ''}>${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col">
                                <select class="form-select" name="year">
                                    <option>Year</option>
                                    <c:forEach var="i" begin="1900" end="2024">
                                        <option ${!sessionScope.customer.getBirthday().equals('') && sessionScope.customer.getBirthday().split("-")[0].equals(String.valueOf(i)) ? 'selected' : ''}>${i}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mb-3 avatar">
                    <label class="form-label">Avatar:</label>
                    <div class="d-block align-items-center">
                        <c:if test="${sessionScope.customer.getAvatar().equals('') == true}">
                            <c:if test="${sessionScope.customer.getAvatar().equals('') == true}">
                                <img id="avatarPreview" class="avatar-preview mb-3" src="assets/imgs/CustomerAvatar/defaut.jpg" alt="default">
                            </c:if>   
                            <c:if test="${sessionScope.customer.getAvatar().equals('') == false}">
                                <img id="avatarPreview" class="avatar-preview mb-3"  src="assets/imgs/CustomerAvatar/${sessionScope.customer.getAvatar()}" alt="default">
                            </c:if>
                        </c:if>   
                        <c:if test="${sessionScope.customer.getAvatar().equals('') == false}">
                            <img id="avatarPreview" class="avatar-preview mb-3" src="assets/imgs/CustomerAvatar/${sessionScope.customer.getAvatar()}" alt="default">
                        </c:if>

                        <br>
                        <input type="file" accept="image/*" class="form-control" name="avatar" onchange="previewImage(event)" >
                    </div>
                </div>
                <div class="d-flex justify-content-sm-between w-100">
                    <a href="viewCustomerProfile" class="btn btn-lg btn-warning">Cancel</a>
                    <button type="submit" class="btn btn-lg btn-primary">Save</button>
                </div>
            </div>
        </form>


        <!-- Phone Number Update Modal -->
        <div id="phoneModal" class="phone">
            <div class="phone-content">
                <span class="close-phone" onclick="closeModal()">&times;</span>
                <h3>Update Phone Number</h3>
                <input type="tel" id="newPhoneNumber" name="phoneNumber" class="form-control" placeholder="Enter new phone number" onchange="validatePhone()">

                <small id="phoneError">Invalid phone number!</small>
                <button onclick="updatePhone()" class="mt-2 btn btn-primary" id="saveButton" disabled>Save</button>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let phoneInput = document.getElementById("newPhoneNumber");
                if (phoneInput) {
                    phoneInput.addEventListener("input", validatePhone);
                }
            });

            function validatePhone() {
                console.log("validatePhone function is loaded!");
                let phoneInput = document.getElementById("newPhoneNumber");
                let phoneError = document.getElementById("phoneError");
                let saveButton = document.getElementById("saveButton");

                let phonePattern = /^0[2-9][0-9]{8}$/;  // Chỉ chấp nhận 10-11 số
                if (phonePattern.test(phoneInput.value)) {
                    console.log("none");
                    phoneError.style.display = "none";
                    saveButton.disabled = false;
                } else {
                    console.log("block");
                    phoneError.style.display = "block";
                    saveButton.disabled = true;
                }
            }
            
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="./assets/js/profile.js"></script>
    </body>
</html>
