<%-- 
    Document   : employeeLogin
    Created on : Feb 14, 2025, 10:00:53 PM
    Author     : TuongMPCE180644
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Login</title>
        <link rel="stylesheet" href="assets/css/bootstrap.css"/>
        <link href="assets/fonts/themify-icons/themify-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                background-color: #f8f9fa;
            }
            .bg-image-vertical {
                position: relative;
                overflow: hidden;
                background-repeat: no-repeat;
                background-position: right center;
                background-size: auto 100%;
            }

            @media (min-width: 1025px) {
                .h-custom-2 {
                    height: 100%;
                }
            }

        </style>
    </head>
    <body>
        <section class="vh-100">
            <div class="container">
                <div class="row">

                    <div class="col-md-6 text-black">
                        <div class="d-flex align-items-center h-custom-2 px-5 ms-xl-4 pt-5 pt-xl-0 mt-xl-n5">

                            <form style="width: 23rem;" action="EmployeeLogin" method="POST">

                                <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px; font-size: 40px; font-weight: bold;">Login</h3>

                                <div data-mdb-input-init class="form-outline mb-4">
                                    <label class="form-label" for="form2Example18">Email address</label>
                                    <input name="email" type="email" id="form2Example18" class="form-control form-control-lg" required/>

                                </div>

                                <div data-mdb-input-init class="form-outline mb-4">
                                    <label class="form-label" for="form2Example28">Password</label>
                                    <input name="password" type="password" id="form2Example28" class="form-control form-control-lg" required/>

                                </div>

                                <div class="pt-1 mb-4">
                                    <button data-mdb-button-init data-mdb-ripple-init class="btn btn-info btn-lg btn-block" type="submit">Login</button>
                                </div>

                            </form>

                        </div>

                    </div>
                    <div class="col-md-6" style="padding: 200px 0px 200px 0px;">
                        <img src="./assets/imgs/Dashboard/Group 1521.svg"
                             alt="Login image" width="100%" height="auto" style="object-fit: cover; object-position: left; margin-top: 10px; border-radius: 10px;">
                    </div>
                </div>
            </div>
        </section>



        <%
            String message = (String) session.getAttribute("message");
            System.out.println("Session message: " + message + request.getRequestURI());
        %>
        <%
            if (message != null) {
        %>
        <div id="cookiesPopup1" style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 350px; display: flex; flex-direction: column; align-items: center; background-color: #fff; color: #000; text-align: center; border-radius: 20px; padding: 30px 30px 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); z-index: 1000;">
            <button class="close" onclick="closePopup1()" style="width: 30px; font-size: 20px; color: #c0c5cb; align-self: flex-end; background-color: transparent; border: none; margin-bottom: 10px; cursor: pointer;">✖</button>
            <img src="./assets/imgs/icon/fail.jpg" alt="fail-tick" style="width: 82px; margin-bottom: 15px; border-radius: 50%;" />
            <p style="margin-bottom: 40px; font-size: 18px;">${sessionScope.message}</p>
            <button class="accept" onclick="closePopup1()" style="background-color: red; border: none; border-radius: 5px; width: 200px; padding: 14px; font-size: 16px; color: white; box-shadow: 0px 6px 18px -5px red; cursor: pointer;">OK</button>
        </div>


        <div id="overlay" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;"></div>
        <%
                session.setAttribute("message", null);
            }
        %>
        <script>

            function closePopup1() {
                document.getElementById("cookiesPopup1").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }

            // Show popup if login fails (you can trigger this with backend error)
            // For example, if you're using a session attribute or response error:
            <%
                if (session.getAttribute("message") != null || session.getAttribute("message") == "") {
                    out.print("showPopup();");
                }
                session.removeAttribute("message");
            %>
        </script>

    </body>
</html>
