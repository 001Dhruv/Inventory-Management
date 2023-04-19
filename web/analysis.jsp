<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <title>Analysis</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="#">Inventory </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item ">
              <a class="nav-link" href="home.html">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item active">
          <a class="nav-link" href="analysis.jsp">Analysis</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="add_product.html">Add Items</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="show_stock.jsp">Show Stock</a>
        </li>
          </ul>
        </div>
    </nav>
    <!--End of mavbar-->
    <u><h2 style="align-content:center; padding-left: 37%;"  >Previous Month Data</h2></u>
    <hr>
    <table  class="table table-striped" >
        <thead class="table-dark" style="margin: 10px;">
          <tr>
            <th scope="col">Sr.No</th>
            <th scope="col">Product ID</th>
            <th scope="col">Product Name</th>
            <th scope="col">Quantity Selled</th>
            <th scope="col">Quantity in Stock</th>
            <th scope="col">Price</th>
            <th scope="col">Total Sales Amount</th>
          </tr>
        </thead>
        <tbody>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<% try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url="jdbc:mysql://localhost:3306/inventory_management";
    String username="root";
    String pass="123456";
    Connection con;
    con=DriverManager.getConnection(url,"root",pass);
    String select_sales="SELECT * FROM sales";
    Statement stmt=con.createStatement();
    ResultSet rst=stmt.executeQuery(select_sales);
      
    while(rst.next()){
        int product_id=rst.getInt(2);
        int in_stock;
        String select_product="SELECT in_stock FROM product WHERE product_id = "+product_id;
        Statement stmt2=con.createStatement();
        ResultSet rst2=stmt2.executeQuery(select_product);
        rst2.next();
        in_stock=rst2.getInt(1);
        String html = "<tr><th scope=\"row\">"+rst.getInt(1)+"</th><td>"+rst.getInt(2)+"</td><td>"+rst.getString(3)+"</td><td>"+rst.getInt(4)+"</td><td>"+in_stock+"</td><td>"+rst.getInt(5)+"</td><td>"+rst.getInt(4)*rst.getInt(5)+"</td></tr>";  
        out.println(html);
    }
   }
   catch(Exception e){
        out.print(e);
    }     
%>
          
          
      </tbody>
      </table>
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