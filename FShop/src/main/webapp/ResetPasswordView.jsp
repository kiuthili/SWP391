<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
        <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Tách CSS ra file riêng -->
    </head>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #f8f9fc;
        }
        .wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-bottom: 40px;
            margin-top: 40px;
        }
        h2 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        p {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .input-group {
            width: 100%;
            margin-bottom: 20px;
        }
        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }
        .message {
            color: green;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }

        .hi{
            background: #f5f7ff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            width: 600px;
        }
    </style>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="wrapper">
                <h2>Reset Password</h2>
                <p>Enter your new password below</p>
                <form action="ResetPasswordServlet" method="post">
                    <div class="input-group">
                        <label>New Password</label>
                        <input type="password" name="newPassword" required>
                    </div>
                    <div class="input-group">
                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" required>
                    </div>
                    <button type="submit">Update Password</button>
                </form>
            <% if (request.getAttribute("error") != null) {%>
            <p class="error"><%= request.getAttribute("error")%></p>
            <% }%>
        </div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
