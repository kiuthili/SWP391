/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CustomerDAO;
import DAOs.CustomerVoucherDAO;
import DAOs.VoucherDAO;
import Models.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ThyLTKCE181577
 */
public class RegisterOTPServlet extends HttpServlet {

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
            out.println("<title>Servlet RegisterOTPServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterOTPServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("VerifyOTPView.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        String otpEntered = request.getParameter("otp");
        String otpStored = (String) session.getAttribute("otp");

        // Check if OTP matches
        if (otpStored != null && otpStored.equals(otpEntered)) {
            // Retrieve customer details from session
            Customer customer = (Customer) session.getAttribute("registerCustomer");

            if (customer != null) {
                // Register the customer
                CustomerDAO ctmDAO = new CustomerDAO();
                int result = ctmDAO.addNewCustomer(customer);

                if (result != 0) {
                    session.setAttribute("message", "Register Successfully");
                    // Registration successful, remove session attributes
                    session.removeAttribute("otp");
                    session.removeAttribute("registerCustomer");
                    CustomerVoucherDAO cv = new CustomerVoucherDAO();
                    Customer cus = ctmDAO.getCustomerLogin(customer.getEmail(), customer.getPassword());
                    cv.assignVoucherToCustomer(cus.getId(), 1, 1, null);

                    // Redirect to login page
                    response.sendRedirect("/customerLogin");
                } else {
                    // Database error occurred
                    request.setAttribute("error", "Registration failed. Please try again.");
                    request.getRequestDispatcher("OTPView.jsp").forward(request, response);
                }
            } else {
                // No customer data found in session
                request.setAttribute("error", "Session expired! Please register again.");
                request.getRequestDispatcher("RegisterView.jsp").forward(request, response);
            }
        } else {
            // Incorrect OTP
            request.setAttribute("error", "Incorrect OTP code!");
            request.getRequestDispatcher("OTPView.jsp").forward(request, response);
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
