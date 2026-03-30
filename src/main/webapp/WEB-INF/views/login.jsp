<%-- ============================================================
     TODO 1: JSP Directives
     ============================================================
     Add TWO directives at the very top of this file (before the
     DOCTYPE declaration):

     1. Page directive — tells the server this is a JSP page:
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>

     2. JSTL taglib directive — imports the core tag library so
        you can use <c:if> for conditional display:
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

     CONCEPT: Same directives you used in register.jsp (tutorial
     TODO 4). The page directive sets content type; the taglib
     directive imports JSTL so we can use <c:if> to conditionally
     show error messages.

     The complete code:

       <%@ page contentType="text/html;charset=UTF-8" language="java" %>
       <%@ taglib prefix="c" uri="jakarta.tags.core" %>
     ============================================================ --%>
<%-- TODO 1: Add JSP directives here --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

  <%-- ============================================================
       TODO 2: Head Section + Auth Header
       ============================================================
       Build the page head and the authentication header with logo.
       This is the same structure as register.jsp (tutorial TODO 5)
       but with a different page title.

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
           <title>Learning Log — Login</title>
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
  <%-- TODO 2: Add head section and auth header here --%>
  <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Learning Log — Login</title>
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
           TODO 3: Login Form
           ============================================================
           Build the login form with 2 input fields, error display,
           and a link to the register page. Compare with register.jsp
           (tutorial TODO 6) — same pattern, fewer fields.

           1. Form container with class "auth-form"
           2. Form tag: POST to ${pageContext.request.contextPath}/login
           3. Heading: <h2>Login</h2>

           4. Error display — use JSTL <c:if> to show errors:
              <c:if test="${not empty error}">
                <p class="error">${error}</p>
              </c:if>
              This only renders when the servlet sets an "error" attribute.

           5. Two input fields:
              - Username: type="text", name="username",
                value="${param.username}" (preserves typed value on error)
              - Password: type="password", name="password"
                (NO value retention — security practice)

           KEY DIFFERENCE from register.jsp:
           - Only 2 fields (no email, no confirm password)
           - Link goes to /register (not /login)
           - Form POSTs to /login (not /register)

           CONCEPT: ${param.username} reads the form parameter directly
           from the request. When login fails and the servlet forwards
           back to this page, the original parameters are still in the
           request — so the username field shows what the user typed.
           Password is NOT retained for security.

           The complete structure:

             <div class="auth-form">
               <form action="${pageContext.request.contextPath}/login" method="post">
                 <h2>Login</h2>

                 <c:if test="${not empty error}">
                   <p class="error">${error}</p>
                 </c:if>

                 <input type="text" name="username" placeholder="Username"
                        value="${param.username}" required />
                 <input type="password" name="password" placeholder="Password" required />

                 <button type="submit">Login</button>

                 <p class="link">Don't have an account?
                   <a href="${pageContext.request.contextPath}/register">Register</a>
                 </p>
               </form>
             </div>
           ============================================================ --%>
      <%-- TODO 3: Add login form here --%>

      <div class="auth-form">
          <form action="${pageContext.request.contextPath}/login" method="post">
              <h2>Login</h2>

              <c:if test="${not empty error}">
                  <p class="error">${error}</p>
              </c:if>

              <input type="text" name="username" placeholder="Username"
                     value="${param.username}" required />
              <input type="password" name="password" placeholder="Password" required />

              <button type="submit">Login</button>

              <p class="link">Don't have an account?
                  <a href="${pageContext.request.contextPath}/register">Register</a>
              </p>
          </form>
      </div>

</html>
