/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CustomerDAO;
import DAOs.CustomerVoucherDAO;
import DAOs.VoucherDAO;
import Models.Customer;
import Models.Voucher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author HP
 */
public class AssignVoucherServlet extends HttpServlet {

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
            out.println("<title>Servlet AssignVoucherServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AssignVoucherServlet at " + request.getContextPath() + "</h1>");
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
        try {
            int customerId = Integer.parseInt(request.getParameter("Id"));

            CustomerDAO cDAO = new CustomerDAO();
            VoucherDAO vDAO = new VoucherDAO();

            Customer customer = cDAO.getCustomerById(customerId);
            List<Voucher> vouchers = vDAO.getAllVoucherActivate();

            request.setAttribute("customer", customer);
            request.setAttribute("vouchers", vouchers);
        } catch (Exception e) {
            e.printStackTrace();  // Ghi log để dễ debug
            request.setAttribute("error", "Unable to load customer data or voucher.");
        }

        // Dù có lỗi hay không, vẫn forward về JSP
        request.getRequestDispatcher("AssignVoucherView.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            int customerID = Integer.parseInt(request.getParameter("customerID"));
//            int voucherID = Integer.parseInt(request.getParameter("voucherID"));
//            int quantity = Integer.parseInt(request.getParameter("quantity"));
//            String rawExpire = request.getParameter("expirationDate");
//
//            String expirationDate = null;
//            LocalDateTime now = LocalDateTime.now();
//
//            if (quantity <= 0) {
//                throw new Exception("Quantity must be greater than 0.");
//            }
//
//            if (rawExpire != null && !rawExpire.isEmpty()) {
//                LocalDateTime dt = LocalDateTime.parse(rawExpire, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
//                if (dt.isBefore(now)) {
//                    throw new Exception("Expiration date must be after the current time.");
//                }
//                expirationDate = dt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//            }
//
//            CustomerVoucherDAO cvDAO = new CustomerVoucherDAO();
//            if (cvDAO.isVoucherAlreadyAssigned(customerID, voucherID)) {
//                throw new Exception("The customer has been issued this voucher.");
//            }
//            VoucherDAO vDAO = new VoucherDAO();
//            Voucher voucher = vDAO.getVoucher(voucherID); 
//
//            // Nếu voucher không tồn tại, báo lỗi
//            if (voucher == null) {
//                throw new Exception("Voucher not found.");
//            }
//            // Convert ExpirationDate string thành LocalDateTime để so sánh
//            LocalDateTime expirationDateTime = LocalDateTime.parse(expirationDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//            String sd = voucher.getStartDate();
//            String ed =  voucher.getEndDate();
//            LocalDateTime startDate = LocalDateTime.parse(voucher.getStartDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"));
//            LocalDateTime endDate = LocalDateTime.parse(voucher.getEndDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS"));
//
//            // Kiểm tra ngày hết hạn có nằm trong khoảng ngày của voucher không
//            if (expirationDateTime.isBefore(startDate) || expirationDateTime.isAfter(endDate)) {
//                throw new Exception("Expiration date must be between the voucher's start and end date.");
//            }
//
//            int count = cvDAO.assignVoucherToCustomer(customerID, voucherID, quantity, expirationDate);
//            if (count > 0) {
//                response.sendRedirect("CustomerListServlet?success=assigned");
//            } else {
//                response.sendRedirect("CustomerListServlet?success=failed");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("error", e.getMessage());
//
//            CustomerDAO cDAO = new CustomerDAO();
//            VoucherDAO vDAO = new VoucherDAO();
//
//            int id = Integer.parseInt(request.getParameter("customerID"));
//            request.setAttribute("customer", cDAO.getCustomerById(id));
//            request.setAttribute("vouchers", vDAO.getAllVoucher());
//
//            request.getRequestDispatcher("AssignVoucherView.jsp").forward(request, response);
//        }
//    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerID = Integer.parseInt(request.getParameter("customerID"));
            int voucherID = Integer.parseInt(request.getParameter("voucherID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String rawExpire = request.getParameter("expirationDate");

            String expirationDate = null;
            LocalDateTime now = LocalDateTime.now();

            if (quantity <= 0) {
                throw new Exception("Quantity must be greater than 0.");
            }else  if(quantity >2){
             throw new Exception("Quantity must be smaller than 3.");
            }

            if (rawExpire != null && !rawExpire.isEmpty()) {
                
                rawExpire = rawExpire.replaceAll("\\.0$", "");

                
                LocalDateTime dt = LocalDateTime.parse(rawExpire, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
                if (dt.isBefore(now)) {
                    throw new Exception("Expiration date must be after the current time.");
                }
                expirationDate = dt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }

           
            CustomerVoucherDAO cvDAO = new CustomerVoucherDAO();
            if (cvDAO.isVoucherAlreadyAssigned(customerID, voucherID)) {
                throw new Exception("The customer has been issued this voucher.");
            }

         
            VoucherDAO vDAO = new VoucherDAO();
            Voucher voucher = vDAO.getVoucher(voucherID);
            
            int limit = (voucher.getMaxUsedCount()-voucher.getUsedCount());
            if(quantity > limit ){ 
                throw new Exception("Voucher not enough.");
            }
            
            if (voucher == null) {
                throw new Exception("Voucher not found.");
            }

           
            LocalDateTime expirationDateTime = LocalDateTime.parse(expirationDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

           
            String startDateString = voucher.getStartDate().split("\\.")[0];
            String endDateString = voucher.getEndDate().split("\\.")[0];

// Chuyển đổi chuỗi thành LocalDateTime với đúng định dạng
            LocalDateTime startDate = LocalDateTime.parse(startDateString, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            LocalDateTime endDate = LocalDateTime.parse(endDateString, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            // Kiểm tra ngày hết hạn có nằm trong khoảng ngày của voucher không
            if (expirationDateTime.isBefore(startDate) || expirationDateTime.isAfter(endDate)) {
                throw new Exception("Expiration date must be between the voucher's start and end date.");
            }

            // Gán voucher cho khácah hàng
            int count = cvDAO.assignVoucherToCustomer(customerID, voucherID, quantity, expirationDate);
            if (count > 0) {
                response.sendRedirect("CustomerListServlet?success=assigned");
            } else {
                response.sendRedirect("CustomerListServlet?success=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());

            // Reload lại thông tin customer và voucher
            CustomerDAO cDAO = new CustomerDAO();
            VoucherDAO vDAO = new VoucherDAO();

            int id = Integer.parseInt(request.getParameter("customerID"));
            request.setAttribute("customer", cDAO.getCustomerById(id));
            request.setAttribute("vouchers", vDAO.getAllVoucher());

            request.getRequestDispatcher("AssignVoucherView.jsp").forward(request, response);
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
