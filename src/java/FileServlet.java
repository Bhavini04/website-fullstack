import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/FileServlet")
@MultipartConfig
public class FileServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fullstack";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Bhavini2004@";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("image");
        String name = request.getParameter("name");
        String des = request.getParameter("des");
       

        // Debugging output
        System.out.println("File Part: " + (filePart != null ? "Present" : "Not Present"));
        if (filePart != null) {
            System.out.println("File Size: " + filePart.getSize());
        }
        System.out.println("Name: " + (name != null ? name : "Not Provided"));
        System.out.println("Description: " + (des != null ? des : "Not Provided"));
  

        if (filePart != null && name != null && !name.isEmpty() &&
            des != null && !des.isEmpty()
            ) {

            try (InputStream inputStream = filePart.getInputStream();
                 Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                
                String sql = "INSERT INTO projecttable (image, name, des) VALUES (?, ?, ?)";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setBlob(1, inputStream);
                    statement.setString(2, name);
                    statement.setString(3, des);
                   

                    int row = statement.executeUpdate();
                    if (row > 0) {
                        request.setAttribute("message", "File uploaded and saved into database");
                    } else {
                        request.setAttribute("message", "Failed to upload file");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Log error for debugging
                request.setAttribute("message", "Database error: " + e.getMessage());
            }
        } else {
            request.setAttribute("message", "All fields are required");
        }

        // Forward to JSP page
        request.getRequestDispatcher("admindashboard.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling file uploads";
    }
}
