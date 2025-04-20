/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.ImportOrderDAO;
import DAOs.ImportOrderDetailDAO;
import DAOs.ProductDAO;
import DAOs.SupplierDAO;
import Models.Employee;
import Models.ImportOrder;
import Models.ImportOrderDetail;
import Models.Product;
import Models.Supplier;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author KienBTCE180180
 */
public class ImportStockServlet extends HttpServlet {

    SupplierDAO sd = new SupplierDAO();
    ProductDAO pd = new ProductDAO();
    ImportOrderDAO ioD = new ImportOrderDAO();
    ImportOrderDetailDAO iodD = new ImportOrderDetailDAO();

    ImportOrder io;
    ImportOrder importOrder;
//    Supplier s;

//    ArrayList<Product> selectedProducts;
//    ArrayList<Product> products;
//    ArrayList<ImportOrderDetail> detailList = new ArrayList<>();
    int importId;
//    long sum = 0;

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
//            out.println("<title>Servlet ImportStockServlet</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ImportStockServlet at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
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
//        processRequest(request, response);
        String status = request.getParameter("status");
        if (status != null) {
            HttpSession session = request.getSession();
            session.removeAttribute("selectedProducts");
            session.removeAttribute("supplier");
//            selectedProducts = null;
//            products = null; // check
//            detailList.clear();
//            s = null;
//            sum = 0L;

            response.sendRedirect("ImportOrder");
        } else {
            try {
//                HttpSession session = request.getSession();
//                session.setAttribute("supplier", s); // session to show selected supplier
//                session.setAttribute("selectedProducts", detailList); // session to show selected supplier

//                request.setAttribute("supplier", s);
                request.setAttribute("suppliers", sd.getAllActivatedSuppliers());
//                products = pd.getAllProducts(); // check
//                request.setAttribute("products", pd.getAllProducts());
                HttpSession session = request.getSession();
                ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
                if (products == null) {
                    products = pd.getAllProducts();
                    session.setAttribute("products", products);
                }
//                request.setAttribute("selectedProducts", detailList);
                request.getRequestDispatcher("ImportStockView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
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
        HttpSession session = request.getSession();
//        ArrayList<Product> products = pd.getAllProducts();

        Supplier s = (Supplier) session.getAttribute("supplier");

        if (s == null) {
            s = new Supplier();
            session.setAttribute("supplier", s);
        }

//        Supplier s = null;
//        ArrayList<ImportOrderDetail> detailList = null;
        ArrayList<ImportOrderDetail> detailList = (ArrayList<ImportOrderDetail>) session.getAttribute("selectedProducts");

        if (detailList == null) {
            detailList = new ArrayList<>();
        }

        ArrayList<Product> products = (ArrayList<Product>) session.getAttribute("products");
        if (products == null) {
            products = pd.getAllProducts();
            session.setAttribute("products", products);
        }

        if (request.getParameter("supplierId") != null) {
            s = sd.getSupplierByID(Integer.parseInt(request.getParameter("supplierId")));

//            HttpSession session = request.getSession();
            session.setAttribute("supplier", s);

//            request.setAttribute("supplier", s);
            response.sendRedirect("ImportStock");
        } else if (request.getParameter("productId") != null) {
            int pId = Integer.parseInt(request.getParameter("productId"));
            Product p = pd.getProductByID(pId);
            ImportOrderDetail d = new ImportOrderDetail();

            d.setProduct(p);
            d.setQuantity(Integer.parseInt(request.getParameter("importQuantity")));
            d.setImportPrice(Long.parseLong(request.getParameter("importPrice")));

            boolean isContained = false;

//            if (detailList != null) {
            for (ImportOrderDetail proDet : detailList) {
                if (proDet.getProduct().getProductId() == pId) {
                    isContained = true;
                }
            }

            if (!isContained) {
                detailList.add(d);
                // check this block
                int deleteIndex = -1;
                for (int i = 0; i < products.size(); ++i) {
                    if (products.get(i).getProductId() == d.getProduct().getProductId()) {
                        deleteIndex = i;
                    }
                }
                if (deleteIndex != -1) {
                    System.out.println(products.remove(products.get(deleteIndex)));
                }
            } else {
                String error = "Duplicated Product";
//                    HttpSession session = request.getSession();
                session.setAttribute("error", error);
            }
//            }

            // check this block
            try {
//                HttpSession session = request.getSession();
//                session.setAttribute("supplier", s); // session to show selected supplier
                session.setAttribute("selectedProducts", detailList);
                session.setAttribute("products", products);

//                request.setAttribute("supplier", s);
                request.setAttribute("suppliers", sd.getAllActivatedSuppliers());
//                request.setAttribute("products", products);
//                request.setAttribute("selectedProducts", detailList);
                request.getRequestDispatcher("ImportStockView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
//            response.sendRedirect("ImportStock");
        } else if (request.getParameter("action") != null) {
            String action = request.getParameter("action");

//            if (detailList != null) {
            if ("delete".equals(action)) {
                int pId = Integer.parseInt(request.getParameter("productEditedId"));

                for (ImportOrderDetail proDet : detailList) {
                    if (proDet.getProduct().getProductId() == pId) {
                        detailList.remove(proDet);
                        Product temp = pd.getProductByID(proDet.getProduct().getProductId());
                        System.out.println(temp.getFullName());
                        products.add(temp); // check
                        break;
                    }
                }

            } else if ("save".equals(action)) {
                int pId = Integer.parseInt(request.getParameter("productEditedId"));

                for (ImportOrderDetail proDet : detailList) {
                    if (proDet.getProduct().getProductId() == pId) {
                        proDet.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                        proDet.setImportPrice(Long.parseLong(request.getParameter("price")));
                        break;
                    }
                }
            }
//            }

            for (int i = 0; i < products.size() - 1; i++) {
                for (int j = i + 1; j < products.size(); j++) {
                    if (products.get(i).getProductId() > products.get(j).getProductId()) {
                        Product temp = products.get(i);
                        products.set(i, products.get(j));
                        products.set(j, temp);
                    }
                }
            }

            // check this block
            try {
//                HttpSession session = request.getSession();
//                session.setAttribute("supplier", s); // session to show selected supplier
                session.setAttribute("selectedProducts", detailList);
                session.setAttribute("products", products);

//                request.setAttribute("supplier", s);
                request.setAttribute("suppliers", sd.getAllActivatedSuppliers());
//                request.setAttribute("products", products);
//                request.setAttribute("selectedProducts", detailList);
                request.getRequestDispatcher("ImportStockView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
//            response.sendRedirect("ImportStock");
        } else {

            Supplier supTest = (Supplier) session.getAttribute("supplier");
            ArrayList<ImportOrderDetail> listTest = (ArrayList<ImportOrderDetail>) session.getAttribute("selectedProducts");
            
            System.out.println("in ra o day");
            System.out.println(supTest == null);
            System.out.println(listTest == null);

            if (supTest == null || listTest == null) {
                long sum = 0L;
                for (ImportOrderDetail proDet : listTest) {
                    sum += proDet.getQuantity() * proDet.getImportPrice();
                }

                HttpSession sess = request.getSession();
                Employee e = (Employee) sess.getAttribute("employee");

                ImportOrder impOrder = new ImportOrder(e.getEmployeeId(), supTest.getSupplierId(), sum);
                impOrder.setEmployeeId(e.getEmployeeId());

                int impId = ioD.createImportOrder(impOrder);

                for (ImportOrderDetail proDet : listTest) {
                    proDet.setIoid(impId);
                    iodD.createImportOrderDetail(proDet);
                }
                ioD.importStock(impId);

                session.removeAttribute("selectedProducts");
                session.removeAttribute("supplier");

//            selectedProducts = null;
//            products = null; // check
//            detailList.clear();
//            s = null;
//            sum = 0L;
//                response.sendRedirect("ImportOrder?id=" + impId);
                response.sendRedirect("ImportOrder");
            } else {
                System.out.println("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
                String error = "Please select full";
//            HttpSession session = request.getSession();
                session.setAttribute("error", error);
                response.sendRedirect("ImportStock");
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
