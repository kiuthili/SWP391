/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.CartDAO;
import DAOs.ProductDAO;
import DAOs.ProductRatingDAO;
import Models.Customer;
import Models.Product;
import Models.ProductRating;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author KienBTCE180180
 */
public class ViewProductServlet extends HttpServlet {

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
        /* Don't delete this LOC */
        CartDAO c = new CartDAO();
        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("customer");
        if (cus != null) {
            session.setAttribute("numOfProCartOfCus", c.getNumberOfProduct(cus.getId()));
        }
        /* Don't delete this LOC */

        ProductDAO pd = new ProductDAO();
        ArrayList<Product> products;
//        Set<Product> filterProducts = new HashSet<>();

        String pathInfo = request.getRequestURI();
        request.setAttribute("uri", request.getServletPath().substring(1));
        if (pathInfo != null && pathInfo.contains("Laptop")) {
            products = pd.getAllProductsByCategory("1");

            // ================================================================== Multi Filter
            ArrayList<String> filters = new ArrayList<>();
            Iterator<Product> iterator;
            String brand = request.getParameter("brand");
            if (brand != null) {
                iterator = products.iterator();
                String[] brandFilters = brand.split(",");

                for (String brandFilter : brandFilters) {
                    filters.add(brandFilter.trim());
                }

                while (iterator.hasNext()) {
                    Product p = iterator.next();

                    boolean found = false;
                    for (String b : brandFilters) {
                        if (b.equalsIgnoreCase(p.getBrandName())) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        iterator.remove();
                    }
                }
            }

            String price = request.getParameter("price");
            if (price != null) {
                iterator = products.iterator();
                ArrayList<String> priceFilters = new ArrayList<>();

                for (String string : price.split(",")) {
                    switch (string.trim()) {
                        case "20-25":
                            priceFilters.add("20000000;25000000");
                            break;
                        case "25-30":
                            priceFilters.add("25000000;30000000");
                            break;
                        case "30-over":
                            priceFilters.add("30000000");
                            break;
                        default:
                            break;
                    }
                    filters.add(string.trim());
                }

                while (iterator.hasNext()) {
                    Product p = iterator.next();
                    boolean found = false;
                    for (String range : priceFilters) {
                        String[] splitRange = range.split(";");
                        long minPrice = Long.parseLong(splitRange[0]);
                        long maxPrice = (splitRange.length == 2) ? Long.parseLong(splitRange[1]) : Long.MAX_VALUE;

                        if (p.getPrice() >= minPrice && p.getPrice() <= maxPrice) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        iterator.remove();
                    }
                }
            }
            // ================================================================== Multi Filter

            try {
                ProductRatingDAO prDAO = new ProductRatingDAO();
                ArrayList<ProductRating> stars = new ArrayList<>();
                for (Product p : products) {
                    ProductRating star = prDAO.getStarAVG(p.getProductId());

                    stars.add(star);

                }
                Map<Object, Object> dataMap = new HashMap<>();
                dataMap.put("stars", stars);
                dataMap.put("products", products);

                ArrayList<String> brands = pd.getAllBrandByCategory("Laptop");
                request.setAttribute("dataMap", dataMap);
                request.setAttribute("products", products);
                request.setAttribute("brands", brands);
                request.setAttribute("filters", filters);

                request.getRequestDispatcher("ProductListView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }

        } else if (pathInfo != null && pathInfo.contains("Smartphone")) {
            products = pd.getAllProductsByCategory("2");

            // ================================================================== Multi Filter
            ArrayList<String> filters = new ArrayList<>();
            Iterator<Product> iterator;
            String brand = request.getParameter("brand");
            if (brand != null) {
                iterator = products.iterator();
                String[] brandFilters = brand.split(",");

                for (String brandFilter : brandFilters) {
                    filters.add(brandFilter.trim());
                }

                while (iterator.hasNext()) {
                    Product p = iterator.next();

                    boolean found = false;
                    for (String b : brandFilters) {
                        if (b.equalsIgnoreCase(p.getBrandName())) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        iterator.remove();
                    }
                }
            }

            String price = request.getParameter("price");
            if (price != null) {
                iterator = products.iterator();
                ArrayList<String> priceFilters = new ArrayList<>();

                for (String string : price.split(",")) {
                    switch (string.trim()) {
                        case "5-15":
                            priceFilters.add("5000000;15000000");
                            break;
                        case "15-25":
                            priceFilters.add("15000000;25000000");
                            break;
                        case "25-30":
                            priceFilters.add("25000000;30000000");
                            break;
                        case "30-over":
                            priceFilters.add("30000000");
                            break;
                        default:
                            break;
                    }
                    filters.add(string.trim());
                }

                while (iterator.hasNext()) {
                    Product p = iterator.next();
                    boolean found = false;
                    for (String range : priceFilters) {
                        String[] splitRange = range.split(";");
                        long minPrice = Long.parseLong(splitRange[0]);
                        long maxPrice = (splitRange.length == 2) ? Long.parseLong(splitRange[1]) : Long.MAX_VALUE;

                        if (p.getPrice() >= minPrice && p.getPrice() <= maxPrice) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        iterator.remove();
                    }
                }
            }
            // ================================================================== Multi Filter

            try {
//                int numberRow = 0;
//                if (products != null) {
//                    numberRow = products.size() / 4;
//                    if (products.size() % 4 != 0) {
//                        numberRow++;
//                    }
//                }
//
//              ProductRatingDAO prDAO = new ProductRatingDAO();
//                ArrayList<ProductRating> stars = new ArrayList<>();
//            for (Product p : products) {
//               ProductRating star = prDAO.getStarAVG(p.getProductId());
//                System.out.println(star);
//                
//                stars.add(star);

                ProductRatingDAO prDAO = new ProductRatingDAO();
                ArrayList<ProductRating> stars = new ArrayList<>();
                for (Product p : products) {
                    ProductRating star = prDAO.getStarAVG(p.getProductId());
                    stars.add(star);

                }

                ArrayList<String> brands = pd.getAllBrandByCategory("Smartphone");

                Map<Object, Object> dataMap = new HashMap<>();
                dataMap.put("stars", stars);
                dataMap.put("products", products);

                request.setAttribute("dataMap", dataMap);
                request.setAttribute("products", products);
                request.setAttribute("brands", brands);
                request.setAttribute("filters", filters);
                request.getRequestDispatcher("ProductListView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
        } else if (pathInfo != null && pathInfo.contains("Accessory")) {
            products = new ArrayList<>();
            Set<String> brands = new HashSet<>();
            if (pathInfo.contains("Headphone")) {
                products.addAll(pd.getAllProductsByCategory("4"));
                brands.addAll(pd.getAllBrandByCategory("Headphone"));
            } else if (pathInfo.contains("Charger")) {
                products.addAll(pd.getAllProductsByCategory("5"));
                brands.addAll(pd.getAllBrandByCategory("Charger"));
            } else if (pathInfo.contains("Cable")) {
                products.addAll(pd.getAllProductsByCategory("6"));
                brands.addAll(pd.getAllBrandByCategory("Charging Cable"));
            } else {
                products.addAll(pd.getAllProductsByCategory("3"));
                products.addAll(pd.getAllProductsByCategory("4"));
                products.addAll(pd.getAllProductsByCategory("5"));
                products.addAll(pd.getAllProductsByCategory("6"));
                brands.addAll(pd.getAllBrandByCategory("Mouse"));
                brands.addAll(pd.getAllBrandByCategory("Headphone"));
                brands.addAll(pd.getAllBrandByCategory("Charger"));
                brands.addAll(pd.getAllBrandByCategory("Charging Cable"));
            }

            // ================================================================== Multi Filter
            ArrayList<String> filters = new ArrayList<>();
            Iterator<Product> iterator;
            String brand = request.getParameter("brand");
            if (brand != null) {
                iterator = products.iterator();
                String[] brandFilters = brand.split(",");

                for (String brandFilter : brandFilters) {
                    filters.add(brandFilter.trim());
                }

                while (iterator.hasNext()) {
                    Product p = iterator.next();

                    boolean found = false;
                    for (String b : brandFilters) {
                        if (b.equalsIgnoreCase(p.getBrandName())) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        iterator.remove();
                    }
                }
            }

            String price = request.getParameter("price");
            if (price != null) {
                iterator = products.iterator();
                ArrayList<String> priceFilters = new ArrayList<>();

                for (String string : price.split(",")) {
                    switch (string.trim()) {
                        case "100-500":
                            priceFilters.add("100000;500000");
                            break;
                        case "500-1":
                            priceFilters.add("500000;1000000");
                            break;
                        case "1-5":
                            priceFilters.add("1000000;5000000");
                            break;
                        case "5-15":
                            priceFilters.add("5000000;15000000");
                            break;
                        case "15-25":
                            priceFilters.add("15000000;25000000");
                            break;
                        case "25-30":
                            priceFilters.add("25000000;30000000");
                            break;
                        case "30-over":
                            priceFilters.add("30000000");
                            break;
                        default:
                            break;
                    }
                    filters.add(string.trim());
                }

                while (iterator.hasNext()) {
                    Product p = iterator.next();
                    boolean found = false;
                    for (String range : priceFilters) {
                        String[] splitRange = range.split(";");
                        long minPrice = Long.parseLong(splitRange[0]);
                        long maxPrice = (splitRange.length == 2) ? Long.parseLong(splitRange[1]) : Long.MAX_VALUE;

                        if (p.getPrice() >= minPrice && p.getPrice() <= maxPrice) {
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        iterator.remove();
                    }
                }
            }
            // ================================================================== Multi Filter

            try {
                ProductRatingDAO prDAO = new ProductRatingDAO();
                ArrayList<ProductRating> stars = new ArrayList<>();
                for (Product p : products) {
                    ProductRating star = prDAO.getStarAVG(p.getProductId());

                    stars.add(star);

                }

                Map<Object, Object> dataMap = new HashMap<>();
                dataMap.put("stars", stars);
                dataMap.put("products", products);

                request.setAttribute("dataMap", dataMap);
                request.setAttribute("products", products);
                request.setAttribute("brands", brands);
                request.setAttribute("filters", filters);
                request.getRequestDispatcher("ProductListView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
        } else {
            products = pd.getAllProducts();

            for (int i = 0; i < products.size(); i++) {
                if (products.get(i).getStock() < 1) {
                    products.remove(i);
                }
            }

            ProductRatingDAO prDAO = new ProductRatingDAO();
            ArrayList<ProductRating> stars = new ArrayList<>();
            for (Product p : products) {
                ProductRating star = prDAO.getStarAVG(p.getProductId());
                stars.add(star);
            }
            try {
                Map<Object, Object> dataMap = new HashMap<>();
                dataMap.put("stars", stars);
                dataMap.put("products", products);

                request.setAttribute("dataMap", dataMap);
                request.setAttribute("products", products);
                request.getRequestDispatcher("HomeView.jsp").forward(request, response);
            } catch (NullPointerException e) {
                System.out.println(e);
            }
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
