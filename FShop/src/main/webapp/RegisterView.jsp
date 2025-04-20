<%-- 
    Document   : register
    Created on : Jan 26, 2025, 10:59:55 PM
    Author     : TuongMPCE180644
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .input-group {
                position: relative;
            }
            .input-label {
                position: absolute;
                left: 12px;
                top: 50%;
                transform: translateY(-50%);
                transition: all 0.3s ease;
                color: gray;
                font-size: 16px;
            }
            .input-field:focus + .input-label,
            .input-field:not(:placeholder-shown) + .input-label {
                padding: 0px 5px 0px 5px;
                background-color: white;
                top: 0px;
                left: 10px;
                font-size: 12px;
                color: blue;
            }
            .input-field:focus {
                outline: none;
                border-color: black;
                box-shadow: none;
            }
            .error-message {
                color: red;
                font-size: 0.9em;
                margin-top: -10px;
                margin-bottom: 10px;
            }
            .features {
                width: 100%;
                padding: 50px 0px;
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                background-color: #f5f7ff;
            }
            .feature-box {
                display: inline-block;
                text-align: center;
                padding: 10px 60px;
                width: 33.33%;
                max-width: 400px;
            }

            .feature-box img{
                text-align: center;
                width: 25%;
                height: auto;
                background-color: #f5f7ff;
                border-radius: 50%;
                margin: 10px;
            }

            .feature-box h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #333;
            }
            .feature-box p {
                font-size: 14px;
                color: #666;
            }
            /* Mobile Styles */
            @media screen and (max-width: 800px) {
                .features {
                    width: 100%;
                    padding: 50px 0px;
                    display: block;
                    justify-content: center;
                    background-color: #f5f7ff;
                }
                .feature-box {
                    width: 100%;
                    max-width: none;
                }
                .form-box{
                    width: 100%;
                    min-width: 0px;
                }
            }
            /* Popup styles */
            .popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }
            .popup-content {
                background-color: white;
                padding: 30px;
                border-radius: 8px;
                text-align: center;
                width: 300px;
            }
            .popup button {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .popup button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <main>
                <div class="bg-gray-100 flex items-center justify-center">
                    <div class="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md" style="margin: 50px 0 50px 0;">
                        <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Create an Account</h2>
                        <form id="register" action="register" method="POST" class="space-y-6">
                            <div class="input-group">
                                <input type="text" name="fullname" id="fullname" required placeholder=" " class="input-field w-full p-3 border rounded-lg">
                                <label for="fullname" class="input-label">Full Name</label>
                            </div>
                            <div class="input-group">
                                <input type="email" name="email" id="email" required placeholder=" " class="input-field w-full p-3 border rounded-lg">
                                <label for="email" class="input-label">Email Address</label>
                            </div>
                            <!--                    <div class="input-group">
                                                    <input type="tel" name="phone" id="email" required placeholder=" " class="input-field w-full p-3 border rounded-lg">
                                                    <label for="phone" class="input-label">Phone number</label>
                                                </div>-->
                            <div class="input-group">
                                <input type="password" name="password" id="password" required placeholder=" " class="input-field w-full p-3 border rounded-lg">
                                <label for="password" class="input-label">Password</label>
                                <p id="passwordRules" class="error-message"></p>
                            </div>
                            <div class="input-group">
                                <input type="password" name="confirmPassword" id="confirmPassword" required placeholder=" " class="input-field w-full p-3 border rounded-lg">
                                <label for="confirm_password" class="input-label">Confirm Password</label>
                                <p id="passwordError" class="error-message"></p>
                            </div>
                            <button type="submit" class="w-full bg-blue-500 text-white font-semibold p-3 rounded-lg hover:bg-blue-600">Sign Up</button>
                        </form>
                        <p class="text-sm text-center text-gray-600 mt-4">Already have an account? <a href="customerLogin" class="text-blue-500 hover:underline">Log in</a></p>
                    </div>
                </div>
                
                <!-- Popup -->
                <div class="popup" id="loginFailPopup">
                    <div class="popup-content">
                        <h3>${sessionScope.message}</h3>
                    <button onclick="closePopup()">Close</button>
                </div>
            </div>
        </main> 
        <jsp:include page="footer.jsp"></jsp:include>
            <script src="assets/js/bootstrap.min.js"></script>
            <!-- Bootstrap JS -->
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

            <!-- Custom JS -->
            <script>
                        document.getElementById("register").addEventListener("submit", function (event) {
                            const password = document.getElementById("password").value;
                            const confirmPassword = document.getElementById("confirmPassword").value;
                            const passwordRules = document.getElementById("passwordRules");
                            const passwordError = document.getElementById("passwordError");

                            let isValid = true;
                            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%!&*?]).{8,}$/;

                            // Kiểm tra mật khẩu có đúng format không
                            if (!passwordRegex.test(password)) {
                                passwordRules.textContent = "Password must be at least 8 characters, include one uppercase, one lowercase, one number, and one special character.";
                                isValid = false;
                            } else {
                                passwordRules.textContent = "";
                            }

                            // Kiểm tra mật khẩu có quá dài không
                            if (password.length > 50) {
                                passwordRules.textContent = "Password is too long, it must be shorter than 50 characters.";
                                isValid = false;
                            }

                            // Kiểm tra xác nhận mật khẩu
                            if (password !== confirmPassword) {
                                passwordError.textContent = "Password and Confirm Password do not match.";
                                isValid = false;
                            } else {
                                passwordError.textContent = "";
                            }

                            // Nếu có lỗi, chặn việc submit form
                            if (!isValid) {
                                event.preventDefault();
                            }
                        });

                        function showPopup() {
                            document.getElementById("loginFailPopup").style.display = "flex";
                        }

                        function closePopup() {
                            document.getElementById("loginFailPopup").style.display = "none";
                        }

                        // Show popup if login fails (you can trigger this with backend error)
                        // For example, if you're using a session attribute or response error:
            <%
                if (session.getAttribute("message") != null) {
                    out.print("showPopup();");
                }
                session.removeAttribute("message");
            %>
        </script>
    </body>
</html>
