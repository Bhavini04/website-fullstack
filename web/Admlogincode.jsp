<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.SQLException" %>
<%
    String uname = request.getParameter("unm");
    String pas = request.getParameter("pass");

    Connection con = null;
    PreparedStatement st1 = null;
    ResultSet rs = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");

        // Prepare the SQL query
        st1 = con.prepareStatement("SELECT * FROM admintab WHERE username=? AND password=?");
        st1.setString(1, uname);
        st1.setString(2, pas);

        // Execute the query
        rs = st1.executeQuery();

        // Check if the user is authenticated
        if (rs.next()) {
            response.sendRedirect("admindashboard.jsp");
        } else {
            out.println("Invalid ID/Password");
        }
    } catch (ClassNotFoundException e) {
        out.println("JDBC Driver not found: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Database error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (st1 != null) st1.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>




















