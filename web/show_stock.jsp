

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Stock</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

        <style>
            table,td{
                border:1px dotted activecaption;
                margin:0px;
            }
        </style>

    </head>
    <body>  
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="#">Inventory </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="home.html">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item ">
          <a class="nav-link" href="analysis.jsp">Analysis</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="add_product.html">Add Items</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="show_stock.jsp">Show Stock</a>
        </li>
      </ul>
    </div>
</nav> 
<u><h2 style="align-content:center; padding-left: 37%; margin-bottom: 30px;"  >Stock In Our Inventory</h2></u>
        <%
            try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/inventory_management";
               String username="root";
               String pass="123456";
               Connection con;
               
               con=DriverManager.getConnection(url,"root",pass);
            
            String select="SELECT * FROM product";
            Statement stmt2=con.createStatement();
            
            ResultSet rst2=stmt2.executeQuery(select);
           out.println("<table class=\"table table-striped\"><thead class=\"table-dark\" style=\"margin: 10px;\"><tr><th scope=\"col\">Sr.No</th><th scope=\"col\">Product ID</th><th scope=\"col\">Product Name</th><th scope=\"col\">Price</th><th scope=\"col\">In Stock</th></tr></thead><tbody>");

            while(rst2.next()){
                int sr_no=rst2.getInt(1);
                int id=rst2.getInt(2);
                String name=rst2.getString(3);
                float price=rst2.getFloat(4);
                float quantity=rst2.getInt(5);
                String html = "<tr><th scope=\"row\">"+sr_no+"</th><td>"+id+"</td><td>"+name+"</td><td>"+price+"</td><td>"+quantity+"</td></tr>";  
                out.println(html);
            }
            stmt2.close();
            
            rst2.close();
            out.println("</tbody></table>");
            
        }
            catch(Exception e){
            e.printStackTrace();
            }
            finally{
            
           
            
            }
        %>
          
<br>
<br>

    <footer style=" width: 100%; position:fixed; bottom:0;" class="text-center text-white" style="background-color: #f1f1f1; margin-top: 25px"> 
        <div class="text-center text-dark p-3" style="background-color: rgba(0, 0, 0, 0.2);">
          © 2022 Copyright:
          <a class="text-dark" >Inventory Analysis and Management</a>
        </div>
      </footer>

    </body>
</html>
