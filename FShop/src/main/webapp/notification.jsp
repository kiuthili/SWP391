<%-- 
    Document   : notification
    Created on : Mar 5, 2025, 3:41:12 PM
    Author     : HP
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông Báo Reply Mới</title>
    <!-- Link Bootstrap CSS (sử dụng phiên bản mới nhất) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- (Tùy chọn) Link cho biểu tượng, ví dụ Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>


      <div class="modal-body">
        
<!--        <div class="list-group">
            <c:forEach items="${unreadReply}" var="rep">
                <a href="replyDetail.jsp?replyID=${rep.replyID}" class="list-group-item list-group-item-action">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">Reply #${rep.replyID}</h5>
                        <small>${rep.isRead ? "Đã Đọc" : "Chưa Đọc"}</small>
                    </div>
                    <p class="mb-1">${rep.answer}</p>
                </a>
            </c:forEach>
            <c:if test="${empty unreadReply}">
                <p class="text-muted">Không có reply mới.</p>
            </c:if>
        </div>-->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
        <
        <a href="allReplies.jsp" class="btn btn-primary">Xem Tất Cả</a>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


