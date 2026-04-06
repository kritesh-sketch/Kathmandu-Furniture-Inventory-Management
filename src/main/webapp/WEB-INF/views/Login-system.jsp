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

<%--
    LOGIN INFORMATION SECTION
    =========================
    Left-hand decorative panel shown alongside the login form.
    Contains only branding/welcome text — no interactive elements.

    Structure:
      <section class="login-information">   — outer wrapper for the panel
        <div class="welcome-text">          — centers/positions the text block
          <p class="text">                  — main display text

    The text reads: "Explore the things you love."
    Split across multiple lines using <br /> for a deliberate
    stacked/typographic effect (each word on its own line).

    "you love" is highlighted in accent color #cb6f72 (dusty rose/red)
    via an inline <span> style.

    NOTES:
      - This section is purely presentational (no form, no logic)
      - The color #cb6f72 should ideally move to a CSS variable
        (e.g. --accent-color) to stay consistent with the rest of the theme
      - Pair this section with the login form section (auth-form)
        side-by-side using flexbox or CSS grid
--%>


<section class="login-information">
    <div class="welcome-text">
        <p class="text">
            Explore <br />the <br />
            things <br />
            <span style="color: #cb6f72">you love</span>.
        </p>
    </div>

    <%--
        DISPLAY IMAGE SECTION
        =====================
        Decorative image carousel/grid panel inside the login-information
        section. Displays 3 lifestyle/interior images for visual appeal.
        No logic — purely presentational.

        Structure:
          <div class="display-image">        — outer wrapper for all images
            <div class="image-display">      — individual image card/slot
              <img src="..." alt="..." />    — the actual image

        IMAGE SLOTS:
          1. "Apartment Therapy.jpg"
             — First featured image, has descriptive alt text

          2. "19 Beige Curtains Living Room Ideas..."
             — Second image, alt="" (decorative — acceptable if purely visual,
               but consider adding meaningful alt text for accessibility)

          3. "Tappeto Corridoio Morbido..."
             — Third image, alt="Image 3"
               (too generic — replace with a real description)

        PATH NOTE:
          src="./../images/..." navigates up one directory then into /images.
          If files move, update all three paths consistently.
          Consider using ${pageContext.request.contextPath}/images/filename.jpg
          for a reliable absolute path in JSP.

    --%>


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


    <%--
        LOGIN FORM SECTION
        ==================
        The main interactive login panel. Contains heading, input fields,
        action buttons, and a brand footer line.

        Structure:
          <section class="login-form">         — outer wrapper for the form panel
            <h1 class="login-form-heading">    — page/section heading
            <div class="entry-box">            — groups the two input fields
              <input type="text" />            — email or mobile number field
              <input type="password" />        — password field
            <button class="login-btn">         — primary submit button
            <p>Forget password ?</p>           — forgot password link (see note)
            <button class="crt-act-btn">       — secondary: create account button
            <p class="declaring-name">         — brand footer line

        NOTES:
          - class="login-btn"   — primary action, style as filled/prominent
          - class="crt-act-btn" — secondary action, style as outlined/subtle
          - The brand line uses <span class="at-symbol"> for the @ character,
            allowing independent styling of the symbol vs the name
    --%>

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
        <button class="login-btn" type="submit">Log in</button>
        <p>Forget password ?</p>
        <button class="crt-act-btn" >Create a new account</button>
        <p class="declaring-name">
            <span class="at-symbol">@ </span>Greenleaf Bio Mattress
        </p>
    </section>

    <!--  -->
</section>

<!--  -->
</body>
</html>
