<%@ page import="java.io.InputStream" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<!DOCTYPE html>
<html>
<head>
    <link href="admin.css" rel="stylesheet">
    <style>
        .logintab {
            font-size: 20px;
            font-family: 'Times New Roman';
            color: white;
            margin-top: -550px;
        }

        .fieldtheme {
            width: 250px;
            height: 30px;
            font-size: 15px;
        }

        .btntheme {
            width: 200px;
            height: 30px;
            font-size: 15px;
            background-color: black;
            color: white;
            text-transform: uppercase;
            font-family: 'Times New Roman';
            text-align: center;
        }

        .message {
            font-size: 18px;
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="divtheme">
    <%@ include file="adminn.jsp" %>

    <form action="FileServlet" method="post" enctype="multipart/form-data">
        <table class="logintab" cellspacing="10px" align="center" cellpadding='2'>
            <tr>
                <td><label for="imageUpload">Choose an image:</label></td>
                <td><input type="file" id="imageUpload" name="image" accept="image/*" required></td>
            </tr>
            <tr>
                <td>Name</td>
                <td><input type="text" placeholder="Enter name" class="fieldtheme" name="name" required></td>
            </tr>
            <tr>
                <td>Description</td>
                <td><input type="text" placeholder="Enter description" class="fieldtheme" name="des" required></td>
            </tr>
           
            <tr align='center'>
                <td colspan="2">
                    <input type="submit" value="Submit" class="btntheme">
                </td>
            </tr>
        </table>
    </form>

    <!-- Display server-side messages here -->
    <div class="message">
        <%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>
    </div>
</div>
</body>
</html>


