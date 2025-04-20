/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CustomerDAO;
import DAOs.CustomerVoucherDAO;
import DAOs.GoogleLogin;
import Models.Customer;
import Models.GoogleAccount;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author TuongMPCE180644
 */
@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/GoogleLogin"})
public class GoogleLoginServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportStockToFileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GoogleLoginServlet at " + request.getContextPath() + "</h1>");
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
        String code = request.getParameter("code");
        if (code == null || code.equals("\\s+")) {
            response.sendRedirect("/customerLogin");
            return;
        }
        HttpSession session = request.getSession();
        GoogleLogin gg = new GoogleLogin();

        String accessToken = gg.getToken(code);
        System.out.println("ACCESS: " + accessToken);
        if (accessToken != null && !accessToken.equalsIgnoreCase("")) {
            GoogleAccount acc = gg.getUserInfo(accessToken);
            if (acc != null) {
                Customer cus = new Customer(0, acc.getName(), null, null, null, null, acc.getEmail(), null, acc.getId(), 0, 0, null);
                CustomerDAO cusDAO = new CustomerDAO();
                if (cusDAO.checkGoogleEmailExisted(acc.getEmail()) == 0) {
                    if (cusDAO.addNewGoogleCustomer(cus) == 1) {
                        cus = cusDAO.getGoogleCustomer(acc.getEmail(), acc.getId());
                        CustomerVoucherDAO cv = new CustomerVoucherDAO();
                        cv.assignVoucherToCustomer(cus.getId(), 1, 1, null);
                    }
                } else {
                    cus = cusDAO.getGoogleCustomer(acc.getEmail(), acc.getId());
                }
                if (cus != null) {
                    if (cus.getIsBlock() == 0) {
                        session.setAttribute("customer", cus);
                        response.sendRedirect("/");
                        return;
                    } else {
                        session.setAttribute("message", "Your account has been locked!");
                        response.sendRedirect("/customerLogin");
                        return;
                    }
                } else {
                    session.setAttribute("message", "Failed to retrieve your account information.");
                    response.sendRedirect("/customerLogin");
                    return;
                }
            }
        }
        response.sendRedirect("/");
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
        processRequest(request, response);
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
