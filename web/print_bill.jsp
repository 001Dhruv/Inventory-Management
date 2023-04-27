
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>print_bill</title>
        <style>
            table,td{
                border:1px dotted activecaption;
                margin:20px;
            }
        </style>
    </head>
    <body>
        <%
           try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/inventory_management";
               String username="root";
               String pass="123456";
               Connection con;
               con=DriverManager.getConnection(url,"root",pass);
               String drop_table="drop table bill";
               Statement stmt=con.createStatement();
                stmt.execute(drop_table);
                response.sendRedirect("home.php");
                stmt.close();
                con.close();
            }
            catch(Exception e){
                    out.println("Error while deleting..");
                    }
            
        %>
    </body>
</html>

