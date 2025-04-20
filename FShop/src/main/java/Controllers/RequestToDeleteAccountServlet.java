/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.CustomerDAO;
import DAOs.OrderDAO;
import Models.Customer;
import Models.Email;
import Models.EmailUtils;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;

/**
 *
 * @author TuongMPCE180644
 */
@WebServlet(name = "RequestToDeleteAccountServlet", urlPatterns = {"/requestToDeleteAccount"})
public class RequestToDeleteAccountServlet extends HttpServlet {

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
            out.println("<title>Servlet RequestToDeleteAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestToDeleteAccountServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("customer");

        OrderDAO o = new OrderDAO();
        int orderCount = o.checkHaveOrders(cus.getId());
        System.out.println("Order count: " + orderCount);
        if (orderCount != 0) {
            session.setAttribute("messageFail", "You have pending orders. Account cannot be deleted.");
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try ( PrintWriter out = response.getWriter()) {
                out.write("{\"status\": \"fail\", \"message\": \"You have pending orders. Account cannot be deleted.\"}");
                out.flush();
            }
            return;
        }

        if (cus.getGoogleId() == null || cus.getGoogleId().trim().isEmpty()) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try ( PrintWriter out = response.getWriter()) {
                out.write("{\"status\": \"success\"}");
                out.flush();
            }
            return;
        }

        String otp = generateOTP();
        session.setAttribute("otp", otp);

        try {
            sendOTPEmail(cus.getEmail(), otp, cus.getFullName());
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try ( PrintWriter out = response.getWriter()) {
                out.write("{\"status\": \"success\"}");
                out.flush();
            }
        } catch (Exception e) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try ( PrintWriter out = response.getWriter()) {
                out.write("{\"status\": \"fail\", \"message\": \"Failed to send OTP email.\"}");
                out.flush();
            }
        }
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
        String password = request.getParameter("confirmPassword");
        String confirmOTP = request.getParameter("OTP");

        HttpSession session = request.getSession();
        CustomerDAO cusDAO = new CustomerDAO();
        Customer cus = (Customer) session.getAttribute("customer");
        CartDAO c = new CartDAO();
        if (password != null) {
            if (cusDAO.cofirmPassword(cus.getId(), password) > 0) {
                if (cusDAO.requestToDeleteAccount(cus.getId()) > 0) {
                    c.deleteCartOfCustomer(cus.getId());
                    response.sendRedirect("/Logout");
                } else {
                    session.setAttribute("messageFail", "Delete is not suscess!");
                    response.sendRedirect("/viewCustomerProfile");
                }
            } else {
                session.setAttribute("messageFail", "Your cofirm password is not correct!");
                response.sendRedirect("/viewCustomerProfile");
            }
        }

        if (confirmOTP != null) {
            String OTP = (String) session.getAttribute("otp");
            if (confirmOTP.equals(OTP)) {
                if (cusDAO.requestToDeleteAccount(cus.getId()) > 0) {
                    c.deleteCartOfCustomer(cus.getId());
                    response.sendRedirect("/Logout");
                } else {
                    session.setAttribute("message", "Delete was not successful!");
                    response.sendRedirect("/viewCustomerProfile");
                }
            } else {
                session.setAttribute("messageFail", "Your confirm OTP is incorrect!");
                response.sendRedirect("/viewCustomerProfile");
            }

        }
        processRequest(request, response);
    }

    private String generateOTP() {
        SecureRandom random = new SecureRandom();
        int otp = 100000 + random.nextInt(900000); // Generates a 6-digit number
        return String.valueOf(otp);
    }

    private void sendOTPEmail(String recipientEmail, String otp, String fullName) {
        try {
            Email email = new Email();
            email.setFrom("kieuthy2004@gmail.com"); // Sender email
            email.setFromPassword("xkkc ohwn aesf arqm"); // App Password for email
            email.setTo(recipientEmail);
            email.setSubject("Email Verification OTP");

            StringBuilder sb = new StringBuilder();
            sb.append("Dear ").append(fullName).append(",<br><br>");
            sb.append(". Please use the OTP below to verify your email:<br>");
            sb.append("<h2>").append(otp).append("</h2>");
            sb.append("This OTP is valid for 5 minutes.<br>");
            sb.append("If you did not request this, please ignore this email.<br><br>");
            sb.append("Best Regards,<br>");
            sb.append("<b>FShop Team</b>");

            email.setContent(sb.toString());

            // Send the email
            EmailUtils.send(email);

        } catch (Exception e) {
            e.printStackTrace();
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

    private OrderDAO OrderDAO() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
