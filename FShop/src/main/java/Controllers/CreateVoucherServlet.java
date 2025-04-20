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


public class CreateVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateVoucherServlet at " + request.getContextPath() + "</h1>");
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

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            String code = request.getParameter("voucherCode").trim();
            if (code.length() > 10) {
                request.setAttribute("error", "Voucher code must not exceed 10 characters.");
                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);

                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }

            int type = Integer.parseInt(request.getParameter("voucherType"));
            int value = Integer.parseInt(request.getParameter("voucherValue"));
            int maxDiscount = Integer.parseInt(request.getParameter("maxDiscountAmount"));
            int minOrder = Integer.parseInt(request.getParameter("minOrderValue"));

            String rawStart = request.getParameter("startDate");
            String rawEnd = request.getParameter("endDate");

            DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            DateTimeFormatter sqlFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            LocalDateTime start = LocalDateTime.parse(rawStart, inputFormat);
            LocalDateTime end = LocalDateTime.parse(rawEnd, inputFormat);

            // Kiểm tra nếu ngày kết thúc trước ngày bắt đầu
            if (end.isBefore(start)) {
                request.setAttribute("error", "End Date must be after Start Date.");
// Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);

                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }

            // Kiểm tra nếu giá trị voucher lớn hơn 100 đối với loại voucher phần trăm
            if (type == 1 && value >= 100) {
                request.setAttribute("error", "If the voucher type is percent, you cannot set a value greater than 100.");
                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);

                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }

            String startDate = start.format(sqlFormat);
            String endDate = end.format(sqlFormat);

            int maxUsed = Integer.parseInt(request.getParameter("maxUsedCount"));
            int status = Integer.parseInt(request.getParameter("status"));
            String desc = request.getParameter("description");

            // Kiểm tra các giá trị số không âm
            if (value < 0 || maxDiscount < 0 || minOrder < 0 || maxUsed < 0) {
                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);
                request.setAttribute("maxUsedCount", maxUsed);
                request.setAttribute("status", status);
                request.setAttribute("description", desc);

                request.setAttribute("error", "Numeric values must be non-negative.");
                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }

            // Kiểm tra ngày bắt đầu và ngày kết thúc không phải trong quá khứ
            LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Bangkok"));
            if (start.isBefore(now)) {
                request.setAttribute("error", "Start Date must not be in the past.");
                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);
                request.setAttribute("maxUsedCount", maxUsed);
                request.setAttribute("status", status);
                request.setAttribute("description", desc);

                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }
            if (end.isBefore(now)) {
                request.setAttribute("error", "End Date must not be in the past.");
                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);
                request.setAttribute("maxUsedCount", maxUsed);
                request.setAttribute("status", status);
                request.setAttribute("description", desc);

                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mã voucher đã tồn tại
            VoucherDAO dao = new VoucherDAO();
            if (dao.checkVoucherCodeExists(code)) {
                request.setAttribute("error", "Voucher code '" + code + "' already exists!");
                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);
                request.setAttribute("maxUsedCount", maxUsed);
                request.setAttribute("status", status);
                request.setAttribute("description", desc);

                request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng voucher mới
            Voucher newVoucher = new Voucher(0, code, value, type, startDate, endDate,
                    0, maxUsed, maxDiscount, minOrder, status, desc);

            // Chèn voucher vào cơ sở dữ liệu
            int count = dao.insertVoucher(newVoucher);
            if (count > 0) {
                response.sendRedirect("ViewVoucherListServlet?success=createsuccess");
            } else {

                // Lưu lại các giá trị người dùng nhập vào
                request.setAttribute("voucherCode", code);
                request.setAttribute("voucherType", type);
                request.setAttribute("voucherValue", value);
                request.setAttribute("maxDiscountAmount", maxDiscount);
                request.setAttribute("minOrderValue", minOrder);
                request.setAttribute("startDate", rawStart);
                request.setAttribute("endDate", rawEnd);
                request.setAttribute("maxUsedCount", maxUsed);
                request.setAttribute("status", status);
                request.setAttribute("description", desc);

                response.sendRedirect("CreateVoucherServlet?success=createfailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while creating voucher.");
            request.getRequestDispatcher("CreateVoucherView.jsp").forward(request, response);
        }
    }


}
