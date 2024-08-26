<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");
    PreparedStatement st1 = con.prepareStatement("select fnm, mail,mobile,city from formtable");

    ResultSet rs = st1.executeQuery();
%>

<html>
<head>
    <link href="admin.css" rel="stylesheet">
    <style>
        .logintab {
            font-size: 20px;
            font-family: berlin sans fb;
            color: white;
            margin-top: -550;
        }

        .fieldtheme {
            width: 250px;
            height: 30px;
            font-size: 15px;
        }

        .btntheme {
            width: 150px;
            height: 40px;
            font-size: 15px;
            background-color: black;
            color: white;
            text-transform: uppercase;
            font-family: berlin sans fb;
            align: center;
        }

        .form-table {
            width: 39%;
            margin: 20px auto;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: -15px;
            margin-left: 450px;
                
        }

        .form-table th, .form-table td {
            border: 2px solid white;
            padding: 10px;
            text-align: left;
            word-wrap: break-word;
        }
         .form-table th {
            font-weight: bold;
            background-color: whitesmoke; 
            color: black;
        }
        .scrollable-table {
            max-height: 200px;
            overflow-y: auto;
        }
    </style>
</head>
<body>

<div class="divtheme">
    <%@include file="adminn.jsp" %>
    
    <form action="">
        <table class="logintab" cellspacing="10px" align="center" cellpadding='2'>
            
            <tr align='center'>
                <td>
                    <input type="submit" value="VIEW ALL DETAILS" class="btntheme" name="btn">
                </td>
            </tr>
        </table>
    </form>

    <div class="scrollable-table">
        <% if (request.getParameter("btn") != null) { %>
            <table class="form-table">
                <thead>
                    <tr>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Mobile Number</th>
                        <th>City</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            String fnm = rs.getString(1);
                            String mail = rs.getString(2);
                            int mobile = rs.getInt(3);
                            String city = rs.getString(4);
                    %>
                            <tr>
                                <td><%= fnm %></td>
                                <td><%= mail %></td>
                                <td><%= mobile %></td>
                                <td><%= city %></td>
                            </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <% } %>
    </div>
</div>

</body>
</html>
