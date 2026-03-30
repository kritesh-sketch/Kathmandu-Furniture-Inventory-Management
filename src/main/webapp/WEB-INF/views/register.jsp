<%-- ============================================================
     TODO 4: JSP Directives
     ============================================================
     Add TWO directives at the very top of this file (before the
     DOCTYPE declaration):

     1. Page directive — tells the server this is a JSP page:
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>

     2. JSTL taglib directive — imports the core tag library so
        you can use <c:if> for conditional display:
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

     CONCEPT: Same directives you used in Week 4 JSPs. The page
     directive sets content type; the taglib directive imports JSTL
     so we can use <c:if> to conditionally show error messages.

     The complete code:

       <%@ page contentType="text/html;charset=UTF-8" language="java" %>
       <%@ taglib prefix="c" uri="jakarta.tags.core" %>
     ============================================================ --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

  <%-- ============================================================
       TODO 5: Head Section + Auth Header
       ============================================================
       Build the page head and the authentication header with logo.

       1. Head section with TWO CSS files:
          - main.css (shared styles + CSS variables)
          - auth.css (login/register page styles)
          Both use ${pageContext.request.contextPath} for the path.

       2. Auth header — centered logo + app name:
          - A div with class "auth-header"
          - An <img> for the book logo
          - An <h1> with "Learning Logs"

       CONCEPT: The auth pages use a different layout than the
       topic/entry pages. Instead of the full header+navbar+content
       layout, auth pages use a simple centered design (auth.css).

       The complete structure:

         <head>
           <meta charset="UTF-8" />
           <meta name="viewport" content="width=device-width, initial-scale=1.0" />
           <title>Learning Log — Register</title>
           <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
           <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css" />
         </head>

         <body>
           <div class="auth-page">

             <div class="auth-header">
               <img src="${pageContext.request.contextPath}/static/images/book.png" alt="LL" />
               <h1>Learning Logs</h1>
             </div>
       ============================================================ --%>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Learning Log — Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css" />
  </head>

  <body>
    <div class="auth-page">

      <div class="auth-header">
        <img src="${pageContext.request.contextPath}/static/images/book.png" alt="LL" />
        <h1>Learning Logs</h1>
      </div>

      <%-- ============================================================
           TODO 6: Registration Form
           ============================================================
           Build the registration form with 4 input fields, error
           display, and a link to the login page.

           1. Form container with class "auth-form"
           2. Form tag: POST to ${pageContext.request.contextPath}/register
           3. Heading: <h2>Register</h2>

           4. Error display — use JSTL <c:if> to show errors:
              <c:if test="${not empty error}">
                <p class="error">${error}</p>
              </c:if>
              This only renders when the servlet sets an "error" attribute.

           5. Four input fields:
              - Username: type="text", name="username",
                value="${param.username}" (preserves typed value on error)
              - Email: type="email", name="email",
                value="${param.email}" (preserves typed value on error)
              - Password: type="password", name="password"
                (NO value retention — security practice)
              - Confirm Password: type="password", name="cpassword"
                (NO value retention — security practice)

           6. Submit button: "Register"
           7. Link to login: "Already have an account? Log in"

           CONCEPT: ${param.username} reads the form parameter directly
           from the request. When validation fails and the servlet
           forwards back to this page, the original form parameters are
           still in the request — so ${param.username} shows what the
           user typed. This prevents them from retyping everything.
           Password fields do NOT use ${param.password} for security.

           The complete structure:

             <div class="auth-form">
               <form action="${pageContext.request.contextPath}/register" method="post">
                 <h2>Register</h2>

                 <c:if test="${not empty error}">
                   <p class="error">${error}</p>
                 </c:if>

                 <input type="text" name="username" placeholder="Username"
                        value="${param.username}" required />
                 <input type="email" name="email" placeholder="Email"
                        value="${param.email}" required />
                 <input type="password" name="password" placeholder="Password" required />
                 <input type="password" name="cpassword" placeholder="Confirm Password" required />

                 <button type="submit">Register</button>

                 <p class="link">Already have an account?
                   <a href="${pageContext.request.contextPath}/login">Log in</a>
                 </p>
               </form>
             </div>
           ============================================================ --%>
      <div class="auth-form">
        <form action="${pageContext.request.contextPath}/register" method="post">
          <h2>Register</h2>

          <c:if test="${not empty error}">
            <p class="error">${error}</p>
          </c:if>

          <input type="text" name="username" placeholder="Username"
                 value="${param.username}" required />
          <input type="email" name="email" placeholder="Email"
                 value="${param.email}" required />
          <input type="password" name="password" placeholder="Password" required />
          <input type="password" name="cpassword" placeholder="Confirm Password" required />

          <button type="submit">Register</button>

          <p class="link">Already have an account?
            <a href="${pageContext.request.contextPath}/login">Log in</a>
          </p>
        </form>
      </div>

    </div>
  </body>
</html>