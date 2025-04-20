/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.VoucherDAO;
import Models.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author HP
 */
public class UpdateVoucherServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateVoucherServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("voucherID");
        int voucherId = Integer.parseInt(id);
        VoucherDAO vDAO = new VoucherDAO();

        Voucher voucher = vDAO.getVoucher(voucherId);
        request.setAttribute("voucher", voucher);
        request.getRequestDispatcher("UpdateVoucherView.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy input
            int voucherID = Integer.parseInt(request.getParameter("voucherID"));
            String code = request.getParameter("voucherCode").trim();
            int type = Integer.parseInt(request.getParameter("voucherType"));
            int value = Integer.parseInt(request.getParameter("voucherValue"));
            int maxDiscount = Integer.parseInt(request.getParameter("maxDiscountAmount"));
            int minOrder = Integer.parseInt(request.getParameter("minOrderValue"));

            String rawStart = request.getParameter("startDate");
            String rawEnd = request.getParameter("endDate");

            int used = Integer.parseInt(request.getParameter("usedCount"));
            int maxUsed = Integer.parseInt(request.getParameter("maxUsedCount"));
            int status = Integer.parseInt(request.getParameter("status"));
            String desc = request.getParameter("description");

            // Parse ngày
            DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            DateTimeFormatter sqlFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime start = LocalDateTime.parse(rawStart, inputFormat);
            LocalDateTime end = LocalDateTime.parse(rawEnd, inputFormat);
            String startDate = start.format(sqlFormat);
            String endDate = end.format(sqlFormat);

            // ===== VALIDATE =====
            if (code.length() > 10) {
                request.setAttribute("error", "Voucher Code must not exceed 10 characters.");
            } else if (start.isAfter(end)) {
                request.setAttribute("error", "End date must be after start date.");
            } else if (value < 0 || maxDiscount < 0 || minOrder < 0 || used < 0 || maxUsed < 0) {
                request.setAttribute("error", "Numeric values must be non-negative.");
            }
            if (type == 1 && value >= 100) {
                request.setAttribute("error", "If the voucher type is percent, you cannot set a value greater than 100.");
//                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
               
            }
             LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Bangkok"));

            if (start.isBefore(now)) {
                request.setAttribute("error", "Start Date must not be in the past.");
//                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
               
            }
             if (end.isBefore(now)) {
                request.setAttribute("error", "End Date must not be in the past.");
//                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
//                return;
            }

            // Nếu có lỗi → quay lại form
            if (request.getAttribute("error") != null) {
                // Trả lại đối tượng voucher với dữ liệu đã nhập
                Voucher errorVoucher = new Voucher(voucherID, code, value, type,
                        rawStart, rawEnd, used, maxUsed, maxDiscount, minOrder, status, desc);
                request.setAttribute("voucher", errorVoucher);
                request.getRequestDispatcher("UpdateVoucherView.jsp").forward(request, response);
                return;
            }

            // Nếu hợp lệ → tiếp tục update
            Voucher updated = new Voucher(voucherID, code, value, type, startDate, endDate,
                    used, maxUsed, maxDiscount, minOrder, status, desc);

            VoucherDAO dao = new VoucherDAO();
            int count = dao.updateVoucher(updated);
            if (count > 0) {
                response.sendRedirect("ViewVoucherListServlet?success=updatesuccess");
            } else {
                response.sendRedirect("ViewVoucherListServlet?success=updatefailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong! Please check your inputs.");
            // Trả lại dữ liệu voucher sau khi có lỗi
            request.setAttribute("voucher", new Voucher());  // Trả về một đối tượng Voucher trống để form không bị trống.
            request.getRequestDispatcher("UpdateVoucherView.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
