/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAOs.RevenueStatisticDAO;
import Models.RevenueStatistic;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author NguyenPVT-CE181835
 */
public class RevenueStatisticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RevenueStatisticDAO revenueStatisticDAO = new RevenueStatisticDAO();
        String timePeriod = request.getParameter("timePeriod");
        ArrayList<RevenueStatistic> revenueData = new ArrayList<>();
        ArrayList<RevenueStatistic> listRevenuePhone = revenueStatisticDAO.getRevenuePhone();
        ArrayList<RevenueStatistic> listRevenueLaptop = revenueStatisticDAO.getRevenueLaptop();
        if ("day".equalsIgnoreCase(timePeriod)) {
            revenueData = revenueStatisticDAO.getRevenueByDay();
        } else if ("month".equalsIgnoreCase(timePeriod)) {
            revenueData = revenueStatisticDAO.getRevenueByMonth();
        } else if ("year".equalsIgnoreCase(timePeriod)) {
            revenueData = revenueStatisticDAO.getRevenueByYear();
        }
        request.setAttribute("time", timePeriod);
        request.setAttribute("revenueData", revenueData);
        request.setAttribute("listRevenuePhone", listRevenuePhone);
        request.setAttribute("listRevenueLaptop", listRevenueLaptop);
        request.getRequestDispatcher("RevenueStatisticView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
