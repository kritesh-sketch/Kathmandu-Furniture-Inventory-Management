<%-- this JSP page uses Java, html as output--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--  Declearing Document type as HTML5 and setting language as english  --%>
<!doctype html>
<html lang="en">

<%--
    - <head> section contains metadat and resouces for the page.
    - It deosnot not display content on the page itself

    1. Head section with TWO CSS files:
         - main.css (shared styles + CSS variables)
         -
         Both use ${pageContext.request.contextPath} for the path.

    2. Importing Google Fonts:
         - Andika New Basic
         - Fredoka One
         - Bellota

     3. Auth header — centered logo + app name:
          - A div with class "Furniture-logo"
          - An <img> for the kathmandu furniture house logo

    CONCEPT: Importing all the required font and css used during
             development of login page is imported in this head
             section with proper syntax.
--%>

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login | Gokyo Resturant</title>
    <link
            href="https://fonts.googleapis.com/css2?family=Andika+New+Basic:ital,wght@0,400;0,700;1,400;1,700&display=swap"
            rel="stylesheet"
    />
    <link
            href="https://fonts.googleapis.com/css2?family=Andika+New+Basic&family=Fredoka+One&display=swap"
            rel="stylesheet"
    />
    <link
            href="https://fonts.googleapis.com/css2?family=Andika+New+Basic:wght@400;600;700&family=Bellota:wght@400;700&display=swap"
            rel="stylesheet"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css" />
</head>

<body>
<!-- Logo Section -->
<header>
    <div class="logo">
        <img src="./../images/head-logo.svg" alt="Mattress logo" />
    </div>
</header>

<%-- --%>

<!-- Welcome text -->
<section class="login-information">
    <div class="welcome-text">
        <p class="text">
            Explore <br />the <br />
            things <br />
            <span style="color: #cb6f72">you love</span>.
        </p>
    </div>

    <!-- Login Images -->
    <div class="display-image">
        <!-- FIRST IMAGE -->

        <div class="image-display">
            <img
                    src="./../images/Apartment Therapy.jpg"
                    alt="Image display in login"
            />
        </div>

        <!-- Second image -->

        <div class="image-display">
            <img
                    src="./../images/19 Beige Curtains Living Room Ideas for Warm Minimal Look.jpg"
                    alt=""
            />
        </div>

        <!-- Third Image -->
        <div class="image-display">
            <img
                    src="./../images/Tappeto Corridoio Morbido per Camera da letto_Soggiorno soffice e peluche - 100_150cm _ Bianco.jpg"
                    alt="Image 3"
            />
        </div>
    </div>
    <!-- Login entry section -->
    <section class="login-form">
        <h1 class="login-form-heading">Log into Mattress</h1>
        <div class="entry-box">
            <input
                    type="text"
                    class="input-box"
                    placeholder="Email or mobile number"
            />
            <input type="password" class="input-box" placeholder="Password" />
        </div>
        <button class="login-btn">Log in</button>
        <p>Forget password ?</p>
        <button class="crt-act-btn">Create a new account</button>
        <p class="declaring-name">
            <span class="at-symbol">@ </span>Greenleaf Bio Mattress
        </p>
    </section>

    <!--  -->
</section>

<!--  -->
</body>
</html>
