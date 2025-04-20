/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.AttributeDAO;
import DAOs.BrandDAO;
import DAOs.CategoryDAO;
import Models.Product;
import DAOs.ProductDAO;
import Models.AttributeDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kiuth
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UpdateProductServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductServlet at " + request.getContextPath() + "</h1>");
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
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductByID(productId);

            if (product != null) {
                // Lấy danh sách category từ DB thông qua CategoryDAO
                CategoryDAO categoryDAO = new CategoryDAO();
                BrandDAO brandDAO = new BrandDAO();

                List<String> categories = categoryDAO.getAllCategoryNames();
                List<String> brands = brandDAO.getAllBrandName();

                request.setAttribute("categories", categories);
                request.setAttribute("brands", brands);
                // Lấy danh sách attribute details từ DB thông qua AttributeDAO
                AttributeDAO attributeDAO = new AttributeDAO();
                List<AttributeDetail> attributeDetails = attributeDAO.getAttributesByProductID(productId);
                product.setAttributeDetails(attributeDetails);

                String brandName = request.getParameter("brandName");
                product.setBrandName(brandName);

                request.setAttribute("product", product);
                request.getRequestDispatcher("UpdateProductView.jsp").forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Product not found.");
                response.sendRedirect("ProductListServlet");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Invalid product ID.");
            response.sendRedirect("ProductListServlet");
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
        try {
            ProductDAO productDAO = new ProductDAO();
            int id = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String model = request.getParameter("model"); // Lấy model từ form
            String description = request.getParameter("description");
            long price = Long.parseLong(request.getParameter("price"));
            int isDeleted = Integer.parseInt(request.getParameter("isDeleted"));
            String categoryName = request.getParameter("categoryName");
            String brandName = request.getParameter("brandName");
            // Lấy sản phẩm hiện có để giữ lại các trường không cập nhật từ form
            Product currentProduct = productDAO.getProductByID(id);
            if (currentProduct == null) {
                request.getSession().setAttribute("error", "Product not found.");
                response.sendRedirect("ProductListServlet");
                return;
            }
            // Xử lý upload file cho ảnh chính
            String photoPath = currentProduct.getImage();
            Part part = request.getPart("txtPPic");
            if (part != null && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String realPath = request.getServletContext().getRealPath("/");
                Path imgDir = Paths.get(realPath, "assets", "imgs", "Products");
                if (!Files.exists(imgDir)) {
                    Files.createDirectories(imgDir);
                }
                String fileSavePath = imgDir.toString() + File.separator + fileName;
                part.write(fileSavePath);
                photoPath = fileName;
            } else {
                System.out.println("doPost - Giữ ảnh chính hiện tại: " + photoPath);
            }

            // Xử lý ảnh thứ 2
            String photoPath1 = currentProduct.getImage1();
            Part part1 = request.getPart("txtPPic1");
            if (part1 != null && part1.getSize() > 0) {
                String fileName = Paths.get(part1.getSubmittedFileName()).getFileName().toString();
                String realPath = request.getServletContext().getRealPath("/");
                Path imgDir = Paths.get(realPath, "assets", "imgs", "Products");
                if (!Files.exists(imgDir)) {
                    Files.createDirectories(imgDir);
                }
                String fileSavePath = imgDir.toString() + File.separator + fileName;
                part1.write(fileSavePath);
                photoPath1 = fileName;
            }

            // Xử lý ảnh thứ 3
            String photoPath2 = currentProduct.getImage2();
            Part part2 = request.getPart("txtPPic2");
            if (part2 != null && part2.getSize() > 0) {
                String fileName = Paths.get(part2.getSubmittedFileName()).getFileName().toString();
                String realPath = request.getServletContext().getRealPath("/");
                Path imgDir = Paths.get(realPath, "assets", "imgs", "Products");
                if (!Files.exists(imgDir)) {
                    Files.createDirectories(imgDir);
                }
                String fileSavePath = imgDir.toString() + File.separator + fileName;
                part2.write(fileSavePath);
                photoPath2 = fileName;
            }

            // Xử lý ảnh thứ 4
            String photoPath3 = currentProduct.getImage3();
            Part part3 = request.getPart("txtPPic3");
            if (part3 != null && part3.getSize() > 0) {
                String fileName = Paths.get(part3.getSubmittedFileName()).getFileName().toString();
                String realPath = request.getServletContext().getRealPath("/");
                Path imgDir = Paths.get(realPath, "assets", "imgs", "Products");
                if (!Files.exists(imgDir)) {
                    Files.createDirectories(imgDir);
                }
                String fileSavePath = imgDir.toString() + File.separator + fileName;
                part3.write(fileSavePath);
                photoPath3 = fileName;
            }
            // Nếu model rỗng thì giữ model cũ
            if (model == null || model.trim().isEmpty()) {
                model = currentProduct.getModel();
            }
            // Sau khi lấy thông tin fullName và model
            if (productDAO.checkDuplicateProduct(fullName, model, id)) {
                request.getSession().setAttribute("error", "The product or model name already exists. It cannot be duplicated with other products!");
                response.sendRedirect("UpdateProductServlet?id=" + id);
                return; // Dừng update, redirect lại trang cập nhật
            }

            // Kiểm tra nếu giá <= 0
            if (price <= 0) {
                request.getSession().setAttribute("error", "Product price must be greater than 0.");
                response.sendRedirect("UpdateProductServlet?id=" + id);
                return; // Dừng việc cập nhật nếu giá không hợp lệ
            }
            // Tạo đối tượng Product mới để update
            Product product = new Product();
            product.setProductId(id);
            product.setFullName(fullName);
            product.setDescription(description);
            product.setPrice(price);
            product.setModel(model);
            product.setDeleted(isDeleted);
            product.setImage(photoPath);
            product.setImage1(photoPath1);
            product.setImage2(photoPath2);
            product.setImage3(photoPath3);
            product.setCategoryName(categoryName);
            product.setModel(currentProduct.getModel());
            product.setBrandName(brandName);
            // Xây dựng danh sách attribute details từ form
            String[] attributeIds = request.getParameterValues("attributeId");
            if (attributeIds != null) {
                List<AttributeDetail> attributeDetails = new ArrayList<>();
                for (String attrIdStr : attributeIds) {
                    int attrId = Integer.parseInt(attrIdStr);
                    String attributeInfor = request.getParameter("attributeInfor_" + attrId);
                    AttributeDetail detail = new AttributeDetail(attrId, id, attributeInfor, null);
                    attributeDetails.add(detail);
                }
                product.setAttributeDetails(attributeDetails);
            } else {
                System.out.println("doPost - Không có attribute nào được gửi từ form.");
            }

            // Gọi updateProduct (nếu phương thức updateProduct trong ProductDAO trả về số dòng > 0 thì update thành công)
            int check = productDAO.updateProduct(product);
            System.out.println("doPost - Số dòng cập nhật: " + check);
            if (check > 0) {
                response.sendRedirect("ProductListServlet?id=" + product.getProductId());
            } else {
                request.getSession().setAttribute("error", "Update failed. Please try again.");
                response.sendRedirect("UpdateProductServlet?id=" + product.getProductId());
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "An unexpected error occurred.");
            response.sendRedirect("UpdateProductServlet?id=" + request.getParameter("id"));
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
