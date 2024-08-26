<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");
    PreparedStatement st1 = con.prepareStatement("select subs from substable");

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

        .subs-table {
            width: 39%;
            margin: 20px auto;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: -15px;
            margin-left: 450px;
                
        }

        .subs-table th, .subs-table td {
            border: 2px solid white;
            padding: 10px;
            text-align: left;
            word-wrap: break-word;
        }
         .subs-table th {
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
                    <input type="submit" value="VIEW ALL" class="btntheme" name="btn">
                </td>
            </tr>
        </table>
    </form>

    <div class="scrollable-table">
        <% if (request.getParameter("btn") != null) { %>
            <table class="subs-table">
                <thead>
                    <tr>
                        <th>Subscriber Mail-id</th>
                       
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            String subs = rs.getString(1);
                            
                    %>
                            <tr>
                                <td><%= subs %></td>
                                
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