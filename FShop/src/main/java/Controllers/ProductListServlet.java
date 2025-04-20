package Controllers;

import DAOs.AttributeDAO;
import DAOs.CategoryDAO;
import DAOs.ProductDAO;
import Models.AttributeDetail;
import Models.Category;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 *
 * @author kiuth
 */
public class ProductListServlet extends HttpServlet {

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
            out.println("<title>Servlet ProductListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductListServlet at " + request.getContextPath() + "</h1>");
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
        // Lấy session và hiển thị message nếu có
        HttpSession session = request.getSession();
        String message = (String) session.getAttribute("message");
        if (message != null) {
            request.setAttribute("message", message);
            session.removeAttribute("message");
        }

        final String sortBy = (request.getParameter("sortBy") == null
                || (!request.getParameter("sortBy").equals("IsDeleted")
                && !request.getParameter("sortBy").equals("Price")
                && !request.getParameter("sortBy").equals("FullName")
                && !request.getParameter("sortBy").equals("Stock")))
                ? "IsDeleted" : request.getParameter("sortBy");

        final String order = (request.getParameter("order") == null
                || (!request.getParameter("order").equalsIgnoreCase("asc")
                && !request.getParameter("order").equalsIgnoreCase("desc")))
                ? "asc" : request.getParameter("order");

        ProductDAO pr = new ProductDAO();
        CategoryDAO catDAO = new CategoryDAO();

        // Lấy danh sách danh mục để hiển thị dropdown
        List<Category> categories = catDAO.getAllCategories();
        request.setAttribute("categories", categories);

        // Lấy các tham số filter từ request
        String detailID = request.getParameter("id");
        String deleteID = request.getParameter("delete");
        String restoreID = request.getParameter("restore");
        String keyword = request.getParameter("txt");
        String selectedCategoryID = request.getParameter("categoryId");
        String filterNewImport = request.getParameter("new_import");

        // Xử lý xóa sản phẩm
        if (deleteID != null) {
            int id = Integer.parseInt(deleteID);
            Product product = pr.getProductByID(id);
            pr.deleteProduct(id);
            if (product != null) {
                session.setAttribute("message", product.getFullName() + " has been deleted from website");
            } else {
                session.setAttribute("message", "Product not found");
            }
            response.sendRedirect("ProductListServlet");
            return;
        }

        // Xử lý khôi phục sản phẩm
        if (restoreID != null) {
            int id = Integer.parseInt(restoreID);
            Product product = pr.getProductByID(id);
            pr.restoreProduct(id);
            if (product != null) {
                session.setAttribute("message", product.getFullName() + " has been activated on website");
            } else {
                session.setAttribute("message", "Product not found");
            }
            response.sendRedirect("ProductListServlet");
            return;
        }

        // Xử lý xem chi tiết sản phẩm
        if (detailID != null) {
            int id = Integer.parseInt(detailID);
            Product product = pr.getProductByID(id);
            AttributeDAO ad = new AttributeDAO();
            List<AttributeDetail> attributes = ad.getAttributesByProductID(id);
            product.setAttributeDetails(attributes);
            request.setAttribute("product", product);
            request.getRequestDispatcher("ProductDetailManagerView.jsp").forward(request, response);
            return;
        }

        // Lấy danh sách sản phẩm theo filter (nếu có) hoặc mặc định
        ArrayList<Product> products = null;
        if (selectedCategoryID != null && !selectedCategoryID.isEmpty()) {
            try {
                int categoryID = Integer.parseInt(selectedCategoryID);
                products = (ArrayList<Product>) pr.getProductsByCategory(categoryID);
                System.out.println("Số sản phẩm tìm thấy theo danh mục: " + products.size());
            } catch (NumberFormatException e) {
                System.out.println("Lỗi: categoryID không hợp lệ - " + selectedCategoryID);
            }
        } else if (keyword != null && !keyword.trim().isEmpty()) {
            products = (ArrayList<Product>) pr.searchProductByName(keyword);
        } else if ("true".equals(filterNewImport)) {
            products = (ArrayList<Product>) pr.getNewImportedProducts();
            System.out.println("Số sản phẩm mới nhập: " + products.size());
        } else {
            products = pr.getProductList();
        }
        // Áp dụng sort theo sortBy cho danh sách sản phẩm đã lấy (nếu danh sách khác null)
        if (products != null && !products.isEmpty()) {
            if ("Price".equals(sortBy)) {
                Collections.sort(products, new Comparator<Product>() {
                    @Override
                    public int compare(Product p1, Product p2) {
                        int cmp;
                        if (p1.getPrice() < p2.getPrice()) {
                            cmp = -1;
                        } else if (p1.getPrice() > p2.getPrice()) {
                            cmp = 1;
                        } else {
                            cmp = 0;
                        }
                        return "asc".equalsIgnoreCase(order) ? cmp : -cmp;
                    }
                });
            } else if ("FullName".equals(sortBy)) {
                Collections.sort(products, new Comparator<Product>() {
                    @Override
                    public int compare(Product p1, Product p2) {
                        // Thêm null check cho FullName
                        String name1 = p1.getFullName() == null ? "" : p1.getFullName();
                        String name2 = p2.getFullName() == null ? "" : p2.getFullName();
                        int cmp = name1.compareToIgnoreCase(name2);
                        return "asc".equalsIgnoreCase(order) ? cmp : -cmp;
                    }
                });
            } else if ("Stock".equals(sortBy)) {
                Collections.sort(products, new Comparator<Product>() {
                    @Override
                    public int compare(Product p1, Product p2) {
                        int cmp;
                        if (p1.getStock() < p2.getStock()) {
                            cmp = -1;
                        } else if (p1.getStock() > p2.getStock()) {
                            cmp = 1;
                        } else {
                            cmp = 0;
                        }
                        return "asc".equalsIgnoreCase(order) ? cmp : -cmp;
                    }
                });
            } else { // Default: IsDeleted
                Collections.sort(products, new Comparator<Product>() {
                    @Override
                    public int compare(Product p1, Product p2) {
                        int cmp = p1.getDeleted() - p2.getDeleted();
                        return "asc".equalsIgnoreCase(order) ? cmp : -cmp;
                    }
                });
            }
        }
        // Đưa danh sách sản phẩm và các tham số khác về JSP
        request.setAttribute("products", products);
        request.getRequestDispatcher("ManageProductView.jsp").forward(request, response);
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
