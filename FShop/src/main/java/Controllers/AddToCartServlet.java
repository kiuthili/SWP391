/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.ProductDAO;
import Models.Cart;
import Models.Customer;
import Models.Product;
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
 * @author nhutb
 */
@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCart"})
public class AddToCartServlet extends HttpServlet {

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
            out.println("<title>Servlet AddToCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("customer");
        ProductDAO p = new ProductDAO();
        if (cus == null) {
            response.sendRedirect("customerLogin");
        } else {
            int id = Integer.parseInt(request.getParameter("productID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            CartDAO cart = new CartDAO();
            Cart cartCheck = cart.getProductOfCart(cus.getId(), id);
            if (cartCheck != null) {
                Product product = p.getProductByID(id);
                int totalQuantity = cartCheck.getQuantity() + quantity;

                // Kiểm tra nếu vượt quá giới hạn 5
                if (totalQuantity > 5) {
                    session.setAttribute("message", "Sorry, you can only buy a maximum of 5 per product.");
                    response.sendRedirect("ProductDetailServlet?id=" + id);
                } else if (product.getStock() >= totalQuantity) { // Kiểm tra số lượng tồn kho
                    cart.updateProductQuantity(cartCheck.getProductID(), totalQuantity, cus.getId());
                    response.sendRedirect("cart");
                } else {
                    session.setAttribute("message", "Sorry, the product quantity in stock is not enough.");
                    response.sendRedirect("ProductDetailServlet?id=" + id);
                }
            } else {
                if (quantity > 5) {
                    session.setAttribute("message", "Sorry, you can only buy a maximum of 5 per product.");
                    response.sendRedirect("ProductDetailServlet?id=" + id);
                } else {
                    cart.addToCart(cus.getId(), new Cart(id, quantity));
                    response.sendRedirect("cart");
                }
            }
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
