/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.EmployeeDAO;
import DAOs.ImportOrderDAO;
import DAOs.SupplierDAO;
import Models.ImportOrder;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author KienBTCE180180
 */
public class ViewImportOrderServlet extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ViewImportOrderServlet</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ViewImportOrderServlet at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }

        ImportOrderDAO importD = new ImportOrderDAO();
        SupplierDAO sd = new SupplierDAO();
        EmployeeDAO ed = new EmployeeDAO();
        ArrayList<ImportOrder> importOrders;

        String detailID = request.getParameter("id");

        if (detailID != null) {
            int id = Integer.parseInt(detailID);
            ImportOrder importOrder = importD.getImportOrderDetailsByID(id);

//            if (importOrder.getCompleted() == 0) {
//                response.sendRedirect("UpdateImportOrder?id=" + id);
//                return;
//            }
            try {
                request.setAttribute("importOrder", importOrder);
                request.setAttribute("employee", ed.getEmployeeById(importOrder.getEmployeeId() + ""));
                request.getRequestDispatcher("ImportOrderDetailsView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
        } else if (request.getParameter("fromDate") != null && request.getParameter("toDate") != null) {
            try {
                request.setAttribute("importOrders", importD.filterHistoryByDate(request.getParameter("fromDate"), request.getParameter("toDate")));
                request.getRequestDispatcher("ImportOrderListView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
        } //else if (request.getParameter("name") != null) {
//            String name = request.getParameter("name");
//            importOrders = importD.getImportOrderBySupplierName(name);
//
//            if (importOrders.isEmpty()) {
//                importOrders = importD.getAllImportOrders();
//            }
//
//            try {
//                request.setAttribute("importOrders", importOrders);
//                request.setAttribute("searchValue", name);
//                request.setAttribute("suppliers", sd.getAllActivatedSuppliers());
//                request.getRequestDispatcher("ImportOrderListView.jsp").forward(request, response);
//            } catch (NullPointerException e) {
//                System.out.println(e);
//            }
//        }

        importOrders = importD.getAllImportOrders();
        try {
            request.setAttribute("importOrders", importOrders);
            request.setAttribute("suppliers", sd.getAllActivatedSuppliers());
            request.getRequestDispatcher("ImportOrderListView.jsp").forward(request, response);
        } catch (NullPointerException e) {
            System.out.println(e);
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
        processRequest(request, response);
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
