/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AttributeDAO;
import DAOs.OrderDetailDAO;
import DAOs.ProductDAO;
import DAOs.ProductRatingDAO;
import DAOs.RatingRepliesDAO;
import Models.AttributeDetail;
import Models.Customer;
import Models.ProductRating;
import Models.RatingReplies;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kiuth
 */
public class ProductDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
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

        ProductDAO pr = new ProductDAO();
        ArrayList<Models.Product> products;

        AttributeDAO ad = new AttributeDAO();
        String detailID = request.getParameter("id");

        ProductRatingDAO prRateDAO = new ProductRatingDAO();

        RatingRepliesDAO rrDAO = new RatingRepliesDAO();

        OrderDetailDAO odDAO = new OrderDetailDAO();
        if (detailID != null) {
            HttpSession session = request.getSession();
            Customer cus = (Customer) session.getAttribute("customer");
            int id = Integer.parseInt(detailID);
            boolean isOk = false;
            float star = prRateDAO.getStarAverage(id);
            Models.Product product = pr.getProductByID(id);

            List<AttributeDetail> attributes = ad.getAttributesByProductID(id);
            List<ProductRating> listPro = prRateDAO.getAllProductRating(id);
            List<RatingReplies> listReplies = rrDAO.getAllRatingRepliesByProduct(id);
            if (cus != null) {
                isOk = odDAO.getCustomerByProductID(cus.getId(), id);
            }
            try {

                request.setAttribute("isOk", isOk);
                request.setAttribute("dataRating", listPro);
                request.setAttribute("dataReplies", listReplies);
                request.setAttribute("star", star);
                request.setAttribute("product", product);
                request.setAttribute("attributes", attributes);
                System.out.println("Attributes forwarded: " + attributes.size()); // Debug
                request.getRequestDispatcher("ProductDetailView.jsp").forward(request, response);
                return;
            } catch (NullPointerException e) {
                System.out.println(e);
            }
        }
        products = pr.getProductList();
        try {
            request.setAttribute("products", products);
            request.getRequestDispatcher("ProductListView.jsp").forward(request, response);
        } catch (NullPointerException e) {
            System.out.println(e);
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
        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("customer");
        int customerId = cus.getId();

        int productId = Integer.parseInt(request.getParameter("productId"));
        int star = Integer.parseInt(request.getParameter("star"));
        String comment = request.getParameter("comment");

        ProductRatingDAO pDAO = new ProductRatingDAO();
        int count = pDAO.addProductRating(customerId, productId, star, comment);
        if (count > 0) {
            response.sendRedirect("ProductDetailServlet?id=" + productId + "&success=created");

        } else {
            response.sendRedirect("ProductDetailServlet?id=" + productId + "&success=deleted");

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
