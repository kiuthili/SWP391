<%-- 
    Document   : HeaderDashboard
    Created on : Feb 27, 2025, 12:38:21 PM
    Author     : KienBTCE180180
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                display: flex;
            }

            .header {
                display: flex;
                justify-content: right;
                align-items: center;
                padding: 10px;
                background: #FFFFFF;
                box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
                border-radius: 10px;
                height: 60px;
            }

            .icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
                margin: 5px;
            }
            .fullname{
                text-decoration: none;
                font-weight: bold;
                color: black;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <a href="ViewEmployeeProfile" style="text-decoration: none">
                <div style="display: flex; align-items: center;">
                    <c:choose>
                        <c:when test="${!sessionScope.employee.getAvatar().equals('')}">
                            <img class="icon" src="assets/imgs/EmployeeAvatar/${sessionScope.employee.getAvatar()}" >
                        </c:when>
                        <c:otherwise>
                            <img  class="icon" src="assets/imgs/EmployeeAvatar/defauft_avatar.jpg">
                        </c:otherwise>
                    </c:choose>
                    <p class="fullname" style="margin-top: 10px;">Hi, ${sessionScope.employee.getFullname()}</p>
                </div>
            </a>
        </div>
        <div class="table-navigate">
        </div>
    </body>
</html>
