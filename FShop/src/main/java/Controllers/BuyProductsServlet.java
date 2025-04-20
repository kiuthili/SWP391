/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AddressDAO;
import DAOs.CartDAO;
import DAOs.CustomerVoucherDAO;
import DAOs.OrderDAO;
import DAOs.ProductDAO;
import Models.Address;
import Models.Cart;
import Models.Customer;
import Models.CustomerVoucher;
import Models.Email;
import Models.EmailUtils;
import Models.Order;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nhutb
 */
@WebServlet(name = "buyProductsServlet", urlPatterns = {"/order"})
public class BuyProductsServlet extends HttpServlet {

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
            out.println("<title>Servlet Order</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Order at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        session.removeAttribute("discount");
        if (action.equalsIgnoreCase("changeAddress")) {
            AddressDAO cdao = new AddressDAO();
            Address add = cdao.getDefaultAddress(cus.getId());
            String address = add.getAddressDetails();
            session.removeAttribute("shipAddress");
            session.setAttribute("shipAddress", address);
            response.sendRedirect("CheckoutView.jsp");
        } else if (action.equalsIgnoreCase("useVoucher")) {
            int voucherId = 0;
            try {
                voucherId = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                System.out.println(e.toString());
            }
            CustomerVoucherDAO cv = new CustomerVoucherDAO();
            CustomerVoucher customerVoucherUsing = cv.getVoucherById(cus.getId(), voucherId);
            long totalAmount = (Long) session.getAttribute("totalAmount");
            if (totalAmount < customerVoucherUsing.getMinOrderValue()) {
                session.setAttribute("message", "Your order is not equal or greater than " + customerVoucherUsing.getMinOrderValue() + "đ.\nYou cannot use this voucher.");
                response.sendRedirect("ConfirmView.jsp");
            } else {
                int discount = 0;
                if (customerVoucherUsing.getVoucherType() == 1) {
                    discount = (int) Math.round(totalAmount * (customerVoucherUsing.getVoucherValue() / 100.0));
                    if (discount > customerVoucherUsing.getMaxDiscountAmount()) {
                        discount = customerVoucherUsing.getMaxDiscountAmount();
                    }
                } else if (customerVoucherUsing.getVoucherType() == 0) {
                    discount = customerVoucherUsing.getVoucherValue();
                }
                System.out.println(customerVoucherUsing.getExpirationDate() + " " + (totalAmount - discount) + " " + customerVoucherUsing.getMaxDiscountAmount());
                session.setAttribute("discount", discount);
                session.setAttribute("customerVoucherUsing", customerVoucherUsing);
                response.sendRedirect("ConfirmView.jsp");
            }
        } else if (action.equalsIgnoreCase("cancelVoucher")) {
            session.removeAttribute("customerVoucherUsing");
            session.removeAttribute("discount");
            response.sendRedirect("ConfirmView.jsp");
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
        String action = request.getParameter("buyProductAction");
        OrderDAO od = new OrderDAO();
        CartDAO ca = new CartDAO();
        ProductDAO p = new ProductDAO();
        Customer cus = (Customer) session.getAttribute("customer");
        String url = request.getParameter("orderUrl");
        System.out.println("Context: " + url);
        if (cus != null) {
            if (action.equals("checkout")) {
                AddressDAO cdao = new AddressDAO();
                Address add = cdao.getDefaultAddress(cus.getId());
                List<Cart> cart = ca.getCartOfAccountID(cus.getId());
                List<Cart> cartSelected = new ArrayList<>();
                if (url.equalsIgnoreCase("Cart")) {
                    String selectedProductIds[] = request.getParameterValues("cartSelected");
                    int count = 0;
                    long totalAmount = 0;
                    for (int i = 0; i < cart.size(); i++) {
                        for (String selectedProductId : selectedProductIds) {
                            if (cart.get(i).getProductID() == Integer.parseInt(selectedProductId)) {
                                cartSelected.add(cart.get(i));
                                totalAmount += cart.get(i).getPrice() * cart.get(i).getQuantity();
                                count++;
                                System.out.println(cart.get(i).getFullName());
                            }
                        }
                    }
                    if (totalAmount > 100000000) {
                        session.setAttribute("message", "total amount too big");
                        response.sendRedirect("cart");
                    } else {
                        if (add == null) {
                            session.setAttribute("message", "Please add your address before order");
                            response.sendRedirect("CartView.jsp");
                        } else {
                            if (cus.getPhoneNumber() == null || cus.getPhoneNumber().equals("")) {
                                session.setAttribute("message", "Please add your phone number before order");
                                response.sendRedirect("CartView.jsp");
                            } else {
                                String address = add.getAddressDetails();

                                session.setAttribute("cartSelected", cartSelected);
                                session.setAttribute("totalAmount", totalAmount);
                                session.setAttribute("shipAddress", address);
                                session.setAttribute("numOfItems", count);
                                session.setAttribute("url", url);
                                request.getRequestDispatcher("CheckoutView.jsp").forward(request, response);

                            }
                        }
                    }

                } else if (url.equalsIgnoreCase("buyNow")) {
                    String productSelected = request.getParameter("productSelected");
                    int id = Integer.parseInt(productSelected);
                    String quantity = request.getParameter("quantity");
                    int quantityInput = Integer.parseInt(quantity);
                    Product pd = p.getProductByID(id);
                    if (pd.getPrice() * quantityInput > 100000000) {
                        session.setAttribute("message", "total amount too big");
                        response.sendRedirect("ProductDetailServlet?id=" + id);
                    } else {
                        if (add == null) {
                            session.setAttribute("message", "Please add your address before order");
                            response.sendRedirect("ProductDetailServlet?id=" + id);
                        } else if (cus.getPhoneNumber() == null || cus.getPhoneNumber().equals("")) {
                            session.setAttribute("message", "Please add your phone number before order");
                            response.sendRedirect("ProductDetailServlet?id=" + id);
                        } else {
                            String address = add.getAddressDetails();
                            boolean existsInCart = false;
                            for (Cart c : cart) {
                                if (c.getProductID() == id) {
                                    existsInCart = true;
                                    break;
                                }
                            }
                            if (existsInCart) {
                                session.setAttribute("message", "You had this product in your cart. Go to your cart to checkout.");
                                response.sendRedirect("ProductDetailServlet?id=" + id);
                            } else {
                                cartSelected.add(new Cart(id, quantityInput, pd.getImage(), pd.getFullName(), pd.getPrice(), pd.getCategoryId()));
                                session.setAttribute("cartSelected", cartSelected);
                                session.setAttribute("totalAmount", pd.getPrice() * quantityInput);
                                session.setAttribute("shipAddress", address);
                                session.setAttribute("numOfItems", 1);
                                session.setAttribute("url", url);
                                request.getRequestDispatcher("CheckoutView.jsp").forward(request, response);
                            }
                        }
                    }
                }
            } else if (action.equals("confirm")) {
                session.setAttribute("customerVoucher", getRealTimeCustomerVoucherList(cus.getId()));
                String fullname = request.getParameter("fullname");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                System.out.println(fullname + " " + address);
                session.setAttribute("order", new Order(fullname, phone, address));
                request.getRequestDispatcher("ConfirmView.jsp").forward(request, response);
            } else if (action.equals("placeOrder")) {
                String urlBuy = (String) session.getAttribute("url");
                System.out.println("URL" + urlBuy);
                long totalAmount = Long.parseLong(request.getParameter("totalAmount"));
                Order o = (Order) session.getAttribute("order");
                int discount = 0;
                CustomerVoucher customerVoucherUsing = null;
                if (session.getAttribute("customerVoucherUsing") != null) {
                    discount = (int) session.getAttribute("discount");
                    customerVoucherUsing = (CustomerVoucher) session.getAttribute("customerVoucherUsing");
                }
                o.setDiscount(discount);
                o.setAccountID(cus.getId());
                o.setTotalAmount(totalAmount);
                od.createOrder(o);
                List<Cart> cartSelected = (List<Cart>) session.getAttribute("cartSelected");
                int newOrder = od.getNewestOrderID();
                for (Cart c : cartSelected) {
                    od.addOrderDetail(newOrder, c.getProductID(), c.getQuantity(), c.getPrice());
                    od.subtractQuantityAfterBuy(c.getProductID(), c.getQuantity());
                    if (!urlBuy.equalsIgnoreCase("buyNow")) {
                        ca.deleteProductOnCart(c.getProductID(), cus.getId());
                    }
                    if (session.getAttribute("customerVoucherUsing") != null) {
                        CustomerVoucherDAO cv = new CustomerVoucherDAO();
                        System.out.println(customerVoucherUsing.getQuantity());
                        if (customerVoucherUsing.getQuantity() == 1) {
                            cv.deleteVoucher(cus.getId(), customerVoucherUsing.getVoucherID());
                        } else if (customerVoucherUsing.getQuantity() > 1) {
                            cv.subtractQuantityOfVoucher(cus.getId(), customerVoucherUsing.getVoucherID());
                        }
                        cv.increaseVoucher(customerVoucherUsing.getVoucherID());
                    }
                }
                session.setAttribute("orderStatus", "success");
                session.setAttribute("numOfProCartOfCus", ca.getNumberOfProduct(cus.getId()));
                //gui mail xac nhan don hang thanh cong
                sendOrderConfirmationEmail(cus, o, cartSelected, totalAmount);
                session.setAttribute("newOrder", newOrder);
                request.getRequestDispatcher("ConfirmView.jsp").forward(request, response);
                session.removeAttribute("order");
                session.removeAttribute("cartSelected");
                session.removeAttribute("discount");
                session.removeAttribute("customerVoucherUsing");
                session.removeAttribute("shipAddress");
                session.removeAttribute("numOfItems");
            }
        } else {
            response.sendRedirect("customerLogin");
        }
    }
    //phuong thuc gui mail

    private void sendOrderConfirmationEmail(Customer customer, Order order, List<Cart> cartItems, long totalAmount) {
        try {
            Email email = new Email();
            email.setFrom("nhutlac2004@gmail.com");
            email.setFromPassword("nxsg zrqd kuvt zgwi");
            email.setTo(customer.getEmail());
            email.setSubject("Order Confirmation from Fshop");

            StringBuilder sb = new StringBuilder();
            sb.append("Hello ").append(customer.getFullName()).append(",<br><br>");
            sb.append("Thank you for shopping with <b>FShop</b>. Here are your order details:<br>");
            sb.append("<b>Recipient:</b> ").append(order.getFullName()).append("<br>");
            sb.append("<b>Shipping Address:</b> ").append(order.getAddress()).append("<br>");
            sb.append("<b>Contact Number:</b> ").append(order.getPhone()).append("<br><br>");
            sb.append("<b>Order Summary:</b><br>");
            sb.append("<table border='1' cellspacing='0' cellpadding='5'>");
            sb.append("<tr><th>Product</th><th>Price</th><th>Quantity</th><th>Total</th></tr>");

            for (Cart item : cartItems) {
                sb.append("<tr>")
                        .append("<td>").append(item.getFullName()).append("</td>")
                        .append("<td>").append(String.format("%d", item.getPrice())).append(" VND</td>")
                        .append("<td>").append(item.getQuantity()).append("</td>")
                        .append("<td>").append(String.format("%d", item.getPrice() * item.getQuantity())).append(" VND</td>")
                        .append("</tr>");
            }

            sb.append("</table><br>");
            sb.append("<b>Total Amount:</b> ").append(String.format("%d", totalAmount)).append(" VND<br>");
            sb.append("<br>Thank you for choosing <b>FShop</b>!<br>");
            sb.append("If you have any questions, feel free to contact us.<br><br>");

            email.setContent(sb.toString());

            EmailUtils.send(email);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private List<CustomerVoucher> getRealTimeCustomerVoucherList(int customerId) {
        CustomerVoucherDAO c = new CustomerVoucherDAO();
        List<CustomerVoucher> list = c.getVoucherOfCustomer(customerId);
        for (CustomerVoucher customerVoucher : list) {
            if (customerVoucher.getExpirationDate() != null) {
                String expirationDateString = customerVoucher.getExpirationDate();
                String endDateString = customerVoucher.getEndDate();
                Timestamp expirationDate = Timestamp.valueOf(expirationDateString);
                Timestamp endDate = Timestamp.valueOf(endDateString);
                LocalDateTime currentDate = LocalDateTime.now();
                boolean isDeleted = false;
                if (expirationDate.toLocalDateTime().isBefore(currentDate) && customerVoucher.getExpirationDate() != null) {
                    System.out.println("Voucher Het Han");
                    c.deleteVoucher(customerId, customerVoucher.getVoucherID());
                    isDeleted = true;
                }
                if (((customerVoucher.getUsedCount() == customerVoucher.getMaxUsedCount()) && isDeleted == false) && customerVoucher.getMaxUsedCount() != 0) {
                    System.out.println("Voucher Het Luot sd");
                    c.deleteVoucher(customerId, customerVoucher.getVoucherID());
                    isDeleted = true;
                }

                if (endDate.toLocalDateTime().isBefore(currentDate) && isDeleted == false && customerVoucher.getEndDate() != null) {
                    System.out.println("Voucher Het End date");
                    c.deleteVoucher(customerId, customerVoucher.getVoucherID());
                    isDeleted = true;
                }
            }
        }
        list = c.getVoucherOfCustomer(customerId);
        return list;
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
