

<%@include file="home.html" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <style>
            table,td{
                border:1px dotted activecaption;
                margin:0px;
            }
        </style>
        <script>
            function printBill() {
                window.print();
                return true;
        }
</script>

    </head>
    <body>   
<%!static boolean flag=false;%> 
        <%
            try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/inventory_management";
               String username="root";
               String pass="123456";
               Connection con;
               
               con=DriverManager.getConnection(url,"root",pass);
//               flag=false;
//              out.println(flag);
               if(true){
                String query_create_table="CREATE TABLE bill ( sr_no INT AUTO_INCREMENT PRIMARY KEY,product_id INT,product_name VARCHAR(32),product_price INT)";
                Statement stmt=con.createStatement();
                try{
                stmt.execute(query_create_table);}
                catch(Exception e){}
                finally{
                stmt.close();
//                flag=true;
                }
                }
            String item_code=request.getParameter("item_code");
//            out.println(item_code);
            
            String product_name;
            String product_price;
            
            String select="SELECT * FROM product WHERE product_id = ?";
            PreparedStatement pstmt=con.prepareStatement(select);
            
            pstmt.setString(1,item_code);
            ResultSet rst=pstmt.executeQuery();
            
            if(rst.next()){
            product_name=rst.getString(3);
            product_price=rst.getString(4);
//            out.println(product_price);
            int product_id=Integer.parseInt(item_code);
            String query_insert="INSERT INTO bill (product_id, product_name, product_price) VALUES (?, ?, ?)";
            String query_incr="UPDATE sales SET unit_sold = unit_sold+1 WHERE product_id ="+product_id;
            String query_decr="UPDATE product SET in_stock = in_stock-1 WHERE product_id ="+product_id;
            Statement stmt_incr=con.createStatement();
            Statement stmt_decr=con.createStatement();
            pstmt=con.prepareStatement(query_insert);
            
            pstmt.setInt(1,product_id);
            
            pstmt.setString(2,product_name);
            try{
            
//            out.println(Float.parseFloat(product_price));
//            out.println("<h1>HELLO</h1>");
            pstmt.setFloat(3,Float.parseFloat(product_price));
            stmt_incr.execute(query_incr);
            stmt_decr.execute(query_decr);
            }
            catch(Exception e){out.println(e);
            
            }
            
              
            pstmt.execute();
            stmt_incr.close();
            stmt_decr.close();
            
            }
             pstmt.close();
             rst.close();
             
            select="SELECT * FROM bill";
            Statement stmt2=con.createStatement();
            
            ResultSet rst2=stmt2.executeQuery(select);
           out.println("<table class=\"table table-striped\"><thead class=\"table-dark\" style=\"margin: 10px;\"><tr><th scope=\"col\">Sr.No</th><th scope=\"col\">Product ID</th><th scope=\"col\">Product Name</th><th scope=\"col\">Price</th></tr></thead><tbody>");
           int sum=0;
            while(rst2.next()){
                int sr_no=rst2.getInt(1);
                int id=rst2.getInt(2);
                String name=rst2.getString(3);
                float price=rst2.getFloat(4);
                sum+=price;
                String html = "<tr><th scope=\"row\">"+sr_no+"</th><td>"+id+"</td><td>"+name+"</td><td>"+price+"</td></tr>";  
                out.println(html);
            }
            out.println("<tr><th scope=\"row\">-</th><td>-</td><td>-</td><td>Total: "+sum+"</td></tr>");
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
          
        
      <div>
        <!-- <span>Number of  Items : 5</span>
        <br>
        <span>Total Amount  : ₹170590 </span> -->
        <hr>
        <br>
        
        <input style="width: 15%; margin: 10px;" type="text" class="form-control" placeholder="Enter Customer Mobile">
        <br>
        <%
            out.println("<form action=\"print_bill.jsp\" onsubmit=\"return printBill();\"><input type=\"submit\" value=\"Print Bill\" style=\"width: 15%; margin: 10px; float:left;\" class=\"btn btn-success\" ></form><form action=\"prinnt_bill.jsp\"><input type=\"submit\" value=\"Message Bill\" style=\"width: 15%; margin: 10px; float:left;\" class=\"btn btn-success\" ></form>");
            
              %>
    </div>
<br>
<br>
<br>
<br>
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
