/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 *
 * @author Dhruv
 */
public class login extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet login</title>");            
            out.println("</head>");
            out.println("<body>");
            try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/inventory_management";
               String pass="123456";
               Connection con;
            con=DriverManager.getConnection(url,"root",pass);
            String query="select * from login where store_id=?";
//            String query="select * from login";
               PreparedStatement pstmt=con.prepareStatement(query);
//            Statement stmt=con.createStatement();
            String store_id=request.getParameter("store_id");
            String password=request.getParameter("password");
               pstmt.setString(1,store_id);
               ResultSet rst =pstmt.executeQuery();
//            ResultSet rst =stmt.executeQuery(query);
//               while(rst.next()){
//                   out.println(rst.getString(1));
//                   out.println(rst.getString(2));
//               }
            RequestDispatcher rd;
            if(rst.next()){
                String get_password=rst.getString(2);
                if(get_password.equals(password)){
//                    out.println("lOGin SUCCESS");
                    
                    rd=request.getRequestDispatcher("home.html");
                    rd.forward(request, response);
                }
                else{
//                    out.println("Incorrect pass ");
                    rd=request.getRequestDispatcher("login_password_incorrect.html");
                    rd.include(request, response);
                    
                }
            }
            else{
                rd=request.getRequestDispatcher("register_your_store.html");
                rd.forward(request, response);
            }
            }
            catch(Exception e){
                out.println(e);
            }
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
