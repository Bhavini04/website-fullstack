<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>

<%
    String button = request.getParameter("submit"); // Update to match the submit button name
    String message = ""; 

    if (button != null) {
        String fnm = request.getParameter("fnm");
        String mail = request.getParameter("mail");
        String mobileParam = request.getParameter("mobile");
        String city = request.getParameter("city");

        int mobile = 0;
        boolean validMobile = true;

        if (mobileParam != null && !mobileParam.isEmpty()) {
            try {
                mobile = Integer.parseInt(mobileParam);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Log the error
                message = "Invalid mobile number format.";
                validMobile = false;
            }
        }

        if (fnm != null && !fnm.isEmpty() && mail != null && !mail.isEmpty() && city != null && !city.isEmpty() && validMobile) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");

                PreparedStatement st1 = con.prepareStatement("INSERT INTO formtable (fnm, mail, mobile, city) VALUES (?, ?, ?, ?)");
                st1.setString(1, fnm);
                st1.setString(2, mail);
                st1.setInt(3, mobile); // Use setInt for integer values
                st1.setString(4, city);

                int rowsAffected = st1.executeUpdate();
                con.close();

                if (rowsAffected > 0) {
                    message = "Feedback inserted successfully!";
                    response.sendRedirect("home.jsp");
                } else {
                    message = "Insertion failed.";
                }
            } catch (ClassNotFoundException | SQLException ex) {
                ex.printStackTrace(); // Log the error
                message = "Error: Unable to process your request. Please try again later.";
            }
        } else {
            if (message.isEmpty()) {
                message = "Enter all the required details.";
            }
        }

        // Optionally, display the message on the current page or redirect
        // response.sendRedirect("errorPage.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }
%>


<%
    String button1 = request.getParameter("Subscribe"); // Update to match the submit button name
    String message1 = ""; 

    if (button1 != null) {
       
        String subs = request.getParameter("subs");
        
        

       
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");

                PreparedStatement st1 = con.prepareStatement("INSERT INTO substable (subs) VALUES (?)");
                st1.setString(1, subs);
                    message = "Feedback inserted successfully!";
                    response.sendRedirect("home.jsp");
                } else {
                    message1 = "Insertion failed.";
                }
           
        
        

        // Optionally, display the message on the current page or redirect
        // response.sendRedirect("errorPage.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    
%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.example.ImageUtil"%> <!-- Import the helper class -->
<%@page contentType="text/html;charset=UTF-8" language="java" %>






<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FullStack Project</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            scroll-behavior: smooth; /* Smooth scrolling effect */
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            color: black;
            z-index: 1000;
            background-color: white; /* Ensure header has a background color */
        }

        .logo {
            font-size: 24px;
        }

        .logo img {
            vertical-align: middle;
            height: 40px;
            width: auto;
            margin-right: 10px;
        }

        .nav-menu {
            display: flex;
            gap: 20px;
            background-color: transparent;
        }

        .nav-menu a {
            color: black;
            text-decoration: none;
            padding: 10px;
            display: block;
        }

        .nav-menu a:hover {
            background-color: #f0f0f0;
            color: black;
        }

        .contact-box {
            background-color: orange;
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
        }

        .content {
            position: relative;
            width: cover;
            overflow: hidden;
            margin-top: -1px;
        }

        .image-container {
            position: relative;
            width: 100%;
            height: 700px;
            overflow: hidden;
        }

        .image-container img {
            width: 100%;
            height: auto; /* Maintain aspect ratio */
            max-height: 100%; /* Ensure the image does not exceed the container height */
            object-fit: cover; /* Cover the container but not crop */
            display: block;
            position: absolute;
            top: 0;
            left: 0;
        }

        .image-container .text-overlay {
            position: absolute;
            top: 45%;
            left: 56%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 38px;
            font-weight: bold;
            text-align: left;
            width: 80%;
        }

        .form-container {
            position: absolute;
            right: 150px;
            top: 110px;
            background-color: rgba(255, 255, 255, 0.6); /* Light blue background */
            padding: 30px;
            border-radius: 0px;
            width: 300px;
        }

        .form-container h2 {
            margin-top: 0;
            font-size: 20px;
            color: #333;
            text-align: center;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="tel"],
        .form-container input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 0px;
            box-sizing: border-box;
        }

        .form-container input[type="submit"] {
            background-color: orange; /* Orange background */
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }

        .form-container input[type="submit"]:hover {
            background-color: #e68500; /* Darker orange for hover */
        }

        .form-container input[type="text"]::placeholder,
        .form-container input[type="email"]::placeholder,
        .form-container input[type="tel"]::placeholder {
            color: #666; /* Placeholder text color */
        }

        /* New Section Styling */
        #services {
            padding: 50px 20px;
            background-color: #f9f9f9;
            text-align: center;
        }

        /* Underline Styling for Section Header */
        #services h2 {
            font-size: 36px;
            margin-top: -20px;
            margin-bottom: 30px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px; /* Space between text and underline */
        }

        #services h2::after {
            content: "";
            display: block;
            width: 80%; /* Adjust the width of the underline */
            height: 4px; /* Thickness of the underline */
            background-color: black; /* Color of the underline */
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        .service-options {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .service-option {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            width: 300px;
            text-align: center;
        }

        .service-option img {
            width: 100px; /* Adjust size as needed */
            height: auto;
            margin-bottom: 15px;
        }

        .service-option h3 {
            margin: 10px 0;
            font-size: 24px;
        }

        .service-option p {
            font-size: 16px;
            color: #333;
        }

        /* Collage Section Styling */
        #collage {
            padding: 50px 20px;
            background-color: #f5f5f5;
            text-align: center;
        }

        .collage-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px; /* Space between images */
        }

        .collage-item {
            position: relative;
            overflow: hidden;
            border-radius: 2px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .collage-item img {
            width: 100%;
            height: auto;
            display: block;
            transition: transform 0.3s ease, filter 0.3s ease;
        }

        .collage-item.small {
            width: 300px; /* Smaller images */
        }

        .collage-item.large {
            width: 450px; /* Larger image */
        }

        .collage-item:hover img {
            transform: scale(1.05);
            filter: brightness(0.8);
        }

        /* About Section Styling */
        #about {
            padding: 50px 20px;
            background-color: #f9f9f9;
            text-align: center;
        }

        #about h2 {
            font-size: 36px;
            margin-bottom: 30px;
            margin-top: -20px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }

        #about h2::after {
            content: "";
            display: block;
            width: 80%;
            height: 4px;
            background-color: black;
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        .about-content {
            max-width: 800px;
            margin: 0 auto;
            font-size: 18px;
            color: #333;
            position: relative;
        }

        .learn-more {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 18px;
            text-decoration: none;
            color: orange;
            border: 2px solid orange;
            border-radius: 5px;
            background-color: white;
            transition: background-color 0.3s, color 0.3s;
        }

        .learn-more:hover {
            background-color: orange;
            color: white;
        }

        .additional-info {
            display: none; /* Hidden by default */
            margin-top: 20px;
            font-size: 16px;
            color: black;
        }

        /* Projects Section Styling */
        #projects {
            padding: 50px 20px;
            background-color: #e9ecef; /* Light background color */
            text-align: center;
            overflow-x: auto; /* Enable horizontal scrolling */
            white-space: nowrap; /* Ensure items are displayed in a single line */
        }

        #projects h2 {
            font-size: 36px;
            margin-bottom: 20px;
            margin-top: -20px;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }

       #projects .subheading {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
        }

        .project-boxes {
            display: flex;
            gap: 20px; /* Space between project boxes */
        }

        .project-box {
            margin-left: 50px;
            margin-right: 50px;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 8px;
          
            text-align: center;
            width: 370px; /* Fixed width */
            flex-shrink: 0; /* Prevent shrinking */
            height:400px;
              overflow: hidden;
        }

        .project-box img {
            width: 50%;
            height: 30%;
        }

        .project-box .content {
            padding: 15px;
        }

        .project-box h3 {
            font-size: 24px;
            margin: 10px 0;
        }

        .project-box p {
            font-size: 16px;
            color: #333;
        }

        .project-box .learn-more {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            font-size: 16px;
            text-decoration: none;
            color: orange;
            border: 2px solid orange;
            border-radius: 5px;
            background-color: white;
            transition: background-color 0.3s, color 0.3s;
        }

        .project-box .learn-more:hover {
            background-color: orange;
            color: white;
        }
        
        /* Happy Clients Section Styling */
#clients {
    padding: 50px 20px;
    background-color: #f5f5f5;
    text-align: center;
}

#clients h2 {
    font-size: 36px;
    margin-bottom: 30px;
    margin-top: -20px;
    position: relative;
    display: inline-block;
    padding-bottom: 10px;
}



.client-container {
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
}

.client-box {
    background-color: white;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    width: 300px;
    text-align: center;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
    align-items: center;
}

.client-box img {
    width: 80px; /* Adjust size as needed */
    height: 80px;
    border-radius: 50%;
    margin-bottom: 15px;
}

.client-content p {
    font-size: 16px;
    color: #333;
    margin-bottom: 10px;
}

.client-content h3 {
    font-size: 18px;
    margin: 5px 0;
}

.client-content p:last-of-type {
    font-size: 14px;
    color: #666;
}
/* Footer Styling */
footer {
    background-color: #333;
    color: white;
    padding: 20px;
    text-align: center;
    position: relative;
    bottom: 0;
    width: 100%;
}

.footer-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
}

.footer-nav {
    display: flex;
    justify-content: center;
    gap: 20px;
}

.footer-nav a {
    color: white;
    text-decoration: none;
    font-size: 16px;
}

.footer-nav a:hover {
    text-decoration: underline;
}

.footer-subscribe {
    display: flex;
    gap: 10px;
    align-items: center;
}

.footer-subscribe input[type="email"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 250px;
    box-sizing: border-box;
}

.footer-subscribe input[type="submit"] {
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    background-color: orange;
    color: white;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
}

.footer-subscribe input[type="submit"]:hover {
    background-color: #e68500;
}

    </style>
</head>

<body>
    <header>
        <div class="logo">
            <img src="img/2.jpg" alt="TrustSphere">
            <span><b>Trust Sphere</b></span>
        </div>
        <nav class="nav-menu">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#about">About Us</a>
            <a href="#projects">Projects</a>
            <a href="#clients">Clients</a>
        </nav>
        <div class="contact-box">
            <a href="#contact-us" style="color: white; text-decoration: none;">Contact Us</a>
        </div>
    </header>
<section id="home">
    <div class="content">
        <div class="image-container">
            <img src="img/3.jpg" alt="Background Image">
            <div class="text-overlay">
                <div>Consult, Design, Deliver</div>
                <div style="font-size: 28px;">Your Trusted Partner in Project Excellence</div>
            </div>
            <div class="form-container">
                <h2>GET A FREE CONSULTATION</h2>
                <form action="" method="post">
    <input type="text" id="fnm" name="fnm" placeholder="Full Name" required>
    <input type="email" id="mail" name="mail" placeholder="Enter Email Address" required>
    <input type="tel" id="mobile" name="mobile" placeholder="Mobile Number" required>
    <input type="text" id="city" name="city" placeholder="Area or City" required>
    <input type="submit" name="submit" value="Get Quick Quote"> <!-- Ensure this name matches the JSP check -->
</form>

            </div>
        </div>
    </div>
</section>

    <!-- New Services Section -->
    <section id="services">
        <h2>Why Choose Us??</h2>
        <div class="service-options">
            <div class="service-option">
                <img src="img/p.jpg" alt="Potential ROI">
                <h3>Potential ROI</h3>
                <p>Discover the potential return on investment with our tailored strategies designed to maximize your gains.</p>
            </div>
            <div class="service-option">
                <img src="img/d.jpg" alt="Design">
                <h3>Design</h3>
                <p>Experience top-notch design services that bring your vision to life with creativity and precision.</p>
            </div>
            <div class="service-option">
                <img src="img/m.jpg" alt="Marketing">
                <h3>Marketing</h3>
                <p>Boost your business with our comprehensive marketing solutions that drive growth and visibility.</p>
            </div>
        </div>
    </section>

    <!-- New Collage Section -->
    <section id="collage">
        <div class="collage-container">
            <div class="collage-item small">
                <img src="img/1.jpg" alt="Project Image 1">
            </div>
            <div class="collage-item large">
                <img src="img/3.jpg" alt="Project Image 2">
            </div>
            <div class="collage-item small">
                <img src="img/1.jpg" alt="Project Image 3">
            </div>
        </div>
    </section>

    <!-- New Projects Section -->
    

    <section id="about">
        <h2>About Us</h2>
        <div class="about-content">
            <p>Welcome to Trust Sphere! We are a dedicated team of professionals committed to delivering excellence in every project we undertake. Our expertise spans various domains, including design, marketing, and strategy development. Our goal is to help you achieve your business objectives with innovative solutions and strategic insights.</p>
            <p>With a customer-centric approach and a passion for results, we tailor our services to meet the unique needs of each client. Explore our range of services and discover how we can help you succeed in a competitive landscape.</p>
            <a href="#" class="learn-more" id="learn-more-btn">Learn More</a>
            <div class="additional-info" id="additional-info">
                <p>At Trust Sphere, we pride ourselves on our ability to adapt and innovate. Our team consists of experts with years of experience in their respective fields, allowing us to provide comprehensive solutions tailored to your specific needs. We leverage cutting-edge technology and market insights to drive success and ensure our clients remain ahead of the competition.</p>
                <p>Whether you're looking to revamp your brand, enhance your digital presence, or optimize your business strategy, we are here to help. Our commitment to quality and customer satisfaction is at the core of everything we do.</p>
            </div>
        </div>
    </section>
    
   <section id="projects">
        <h2>Our Projects</h2>
        <div class="subheading">Explore our successful projects showcasing our expertise and creativity. Each project is a testament to our commitment to excellence.</div>
        <div class="project-boxes">
            <%
                // JDBC connection and query
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");
                PreparedStatement st1 = con.prepareStatement("SELECT image, name, des FROM projecttable");
                ResultSet rs = st1.executeQuery();

                while (rs.next()) {
                    // Retrieve BLOB and convert to Base64
                    byte[] imageBlob = rs.getBytes("image");
                    String imageBase64 = (imageBlob != null) ? ImageUtil.getBase64Image(imageBlob) : "";
                    String name = rs.getString("name");
                    String des = rs.getString("des");
            %>
                <div class="project-box">
                    <!-- Embed Base64-encoded image directly -->
                    <img src="<%= imageBase64 %>" alt="<%= name %>">
                    <div class="content">
                        <h3><%= name %></h3>
                        <p><%= des %></p>
                        <a href="" class="learn-more">Learn More</a>
                    </div>
                </div>
            <%
                }
                con.close();
            %>
        </div>
    </section>
    
    <!-- Happy Clients Section -->


<section id="clients">
    <h2>Happy Clients</h2>
    <div class="client-container">
        <%
            // JDBC connection and query
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fullstack", "root", "Bhavini2004@");
            PreparedStatement st2 = conn.prepareStatement("SELECT image, name, des FROM clienttable");
            ResultSet rs1 = st2.executeQuery();
        %>
        <% while (rs1.next()) { %>
            <div class="client-box">
                <!-- Retrieve BLOB and convert to Base64 -->
                <%
                    byte[] imageBlob = rs1.getBytes("image");
                    String imageBase64 = (imageBlob != null) ? ImageUtil.getBase64Image(imageBlob) : "";
                    String name = rs1.getString("name");
                    String des = rs1.getString("des");
                %>
                <img src="<%= imageBase64 %>" alt="<%= name %>">
                <div class="client-content">
                    <p><%= des %></p>
                    <h3><%= name %></h3>
                </div>
            </div>
        <% } %>
        <% conn.close(); %>
    </div>
</section>



<!-- Footer Section -->
<footer>
    <div class="footer-container">
        <nav class="footer-nav">
            <a href="#home">Home</a>
            <a href="#services">Services</a>
            <a href="#about">About Us</a>
            <a href="#projects">Projects</a>
            
        </nav>
        <div class="footer-subscribe">
            <form action="" method="post">
                <input type="email" id="subscribe-email" name="subs" placeholder="Enter your email" required>
                <input type="submit" name="Subscribe" value="Subscribe">
            </form>
        </div>
    </div>
</footer>

    <script>
        // JavaScript to toggle additional information
        document.getElementById('learn-more-btn').addEventListener('click', function(event) {
            event.preventDefault();
            var additionalInfo = document.getElementById('additional-info');
            if (additionalInfo.style.display === 'none' || additionalInfo.style.display === '') {
                additionalInfo.style.display = 'block';
                this.textContent = 'Show Less'; // Change text to "Show Less"
            } else {
                additionalInfo.style.display = 'none';
                this.textContent = 'Learn More'; // Change text back to "Learn More"
            }
        });
    </script>
</body>

</html>
