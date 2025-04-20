/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AddressDAO;
import Models.Address;
import Models.Customer;
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
@WebServlet(name = "AddAddressServlet", urlPatterns = {"/AddAddress"})
public class AddAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("customer");

        if (cus != null) {
            String url = request.getParameter("currentAddressPage");
            System.out.println("Context: " + url);
            AddressDAO add = new AddressDAO();
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            String ward = request.getParameter("ward");
            String address = request.getParameter("address");
            String addressDetails = address + ", " + ward + ", " + district + ", " + province;
            if (request.getParameter("isDefault") != null) {
                int id = add.addAddress(new Address(cus.getId(), 1, addressDetails));
                add.disableDefaultAddress(id, cus.getId());
                session.setAttribute("message", "Add address successfully");
            } else {
                add.addAddress(new Address(cus.getId(), 0, addressDetails));
                session.setAttribute("message", "Add address successfully");
            }
            if (url.equalsIgnoreCase("addressPage")) {
                response.sendRedirect("ViewShippingAddress");
            } else if (url.equalsIgnoreCase("forOrder")) {
                response.sendRedirect("ViewShippingAddress?action=forOrder");
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
