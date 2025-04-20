/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.EmployeeDAO;
import Models.Employee;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author TuongMPCE180644
 */
@WebServlet(name = "EmployeeLoginServlet", urlPatterns = {"/EmployeeLogin"})
public class EmployeeLoginServlet extends HttpServlet {

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
            out.println("<title>Servlet EmployeeLoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmployeeLoginServlet at " + request.getContextPath() + "</h1>");
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
//        HttpSession session = request.getSession();
//        session.invalidate();
        request.getRequestDispatcher("EmployeeLoginView.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        EmployeeDAO emDAO = new EmployeeDAO();
        Cookie loginEmail = null;

        Employee em = emDAO.employeeLogin(email, password);//Emloyee có all thông tin tru di password là ko có
        if (em != null) {
            if (em.getStatus() == 1) {
                session.setAttribute("employee", em);

                loginEmail = new Cookie("employee" + em.getEmployeeId(), email + "_0");
                loginEmail.setMaxAge(20 * 60);
                loginEmail.setPath("/EmployeeLogin");
                response.addCookie(loginEmail);

                if (em.getRoleId() == 1) {
                    response.sendRedirect("/StatisticManagementServlet");//Link qua Admin
                } else if (em.getRoleId() == 2) {
                    //session.setAttribute("message", "Shop Managers");
                    response.sendRedirect("/ShopDashboardServlet");//Link qua Shop Manager
                } else if (em.getRoleId() == 3) {
                    response.sendRedirect("/ViewOrderListServlet");//Link qua Order Manager
                } else if (em.getRoleId() == 4) {
                    response.sendRedirect("/Warehouse");//Link qua Warehouse Manager
                } else {
                    processRequest(request, response);//ko có roleId thì error
                }
            } else if (em.getStatus() == 0) {
                session.setAttribute("message", "Your account is deactive!");//deactive thì không login dc
                response.sendRedirect("/EmployeeLogin");
            } else {
                session.setAttribute("message", "Status is not true!");//status nó có 2 à ngoài ra thì l?i
                response.sendRedirect("/EmployeeLogin");
            }
        } else {
            int id = emDAO.checkEmailActive(email);
            if (id > 1) {
                int count = 0;
                String emailCheck = "";
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {

                    for (Cookie cookie : cookies) {
                        if (("employee" + id).equals(cookie.getName())) {
                            String str[] = cookie.getValue().trim().split("_");
                            emailCheck = str[0];
                            try {
                                count = Integer.parseInt(str[1]);
                                System.out.println("chuyen so " + str[1]);
                                count++;

                            } catch (NumberFormatException e) {
                                System.out.println("Error:" + e);
                                count = 0;
                            }
                            break;
                        }
                    }
                }

                loginEmail = new Cookie("employee" + id, email + "_" + count);
                loginEmail.setPath("/EmployeeLogin");
                loginEmail.setMaxAge(20 * 60);
                response.addCookie(loginEmail);

                if (count > 4 && email.equals(emailCheck)) {
                    System.out.println("id:" + id);
                    int i = emDAO.blockEmployee(id);
                    System.out.println("khoa" + i);
                    session.setAttribute("message", "Your account is deactive!");
                    response.sendRedirect("/EmployeeLogin");
                    return;
                }

                session.setAttribute("message", "Incorrect password! You have " + (5 - count) + " login attempts left before your account is locked.");
            } else if (id == 1) {
                session.setAttribute("message", "Incorrect password!");
            } else {
                session.setAttribute("message", "Your account is deactive!");
            }

            response.sendRedirect("/EmployeeLogin");
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
