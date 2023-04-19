

<%@include file="add_product.html" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Product</title>
        <style>
            table,td{
                border:1px dotted activecaption;
                margin:0px;
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
            String select="SELECT * FROM product WHERE product_id = ?";
            PreparedStatement pstmt=con.prepareStatement(select);
            int product_id=Integer.parseInt(request.getParameter("product_id"));
            int product_quantity=Integer.parseInt(request.getParameter("product_quantity"));
            pstmt.setInt(1,product_id);
            ResultSet rst=pstmt.executeQuery();
            
            if(rst.next()){
            
                int qua=rst.getInt(5);
                qua=qua+product_quantity;
                String query="UPDATE product SET in_stock = "+qua+" WHERE product_id ="+product_id;
                Statement stmt=con.createStatement();
                
                stmt.execute(query);
                stmt.close();
            }
            else{
            
                String product_name=request.getParameter("product_name");
//                out.print(product_name);
                
                int product_price=Integer.parseInt(request.getParameter("product_price"));
                String query="INSERT INTO product (product_id, product_name, product_price,in_stock) VALUES ("+product_id+",'"+product_name+"',"+product_price+","+product_quantity+")";
                String insert_sales="INSERT INTO sales (product_id, product_name, unit_sold,product_price) VALUES ("+product_id+",'"+product_name+"',0,"+product_price+")";
                Statement stmt=con.createStatement();
                Statement stmt2=con.createStatement();
                try{
                stmt.executeUpdate(query);
                stmt2.executeUpdate(insert_sales);
                
               
            }catch(Exception e){out.print(e);}
                finally{
                stmt.close();
                stmt2.close();
            }
            }
            select="SELECT * FROM product";
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
<br>
<hr>
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
