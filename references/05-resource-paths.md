# Resource Paths in Web Applications

## Web App Root vs Server Root

A servlet container (like Tomcat) can host multiple web applications. Each application lives under its own **context path**, which is a prefix in the URL.

```
Server root:      http://localhost:8080/
App context path: http://localhost:8080/learning-logs/
```

The server root `/` is the base of the entire server. Your application root `/learning-logs/` is a subdirectory within that. All paths in your application must account for this prefix.

## Context Path

The context path is the portion of the URL between the server root and your servlet/resource path.

```
http://localhost:8080 /learning-logs /register
                       ^^^^^^^^^^^^^^ ^^^^^^^^
                       context path    servlet path
```

If you hard-code paths without the context path, your links will break:

- `href="/register"` points to `http://localhost:8080/register` (server root — wrong)
- `href="/learning-logs/register"` works but breaks if the app is deployed under a different name

The solution: build paths dynamically using the context path.

## In JSP: `${pageContext.request.contextPath}`

Use this EL expression to get the context path in any JSP.

### CSS and Static Resources

```jsp
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
```

### Navigation Links

```jsp
<a href="${pageContext.request.contextPath}/topic">Topics</a>
```

### Form Actions

```jsp
<form action="${pageContext.request.contextPath}/register" method="post">
```

## In Servlets: `request.getContextPath()`

Use this method when building URLs in Java code, typically for redirects.

### Redirects

```java
response.sendRedirect(request.getContextPath() + "/login");
```

This sends a 302 response with the full path, and the browser navigates to the correct URL.

## RequestDispatcher Paths

When forwarding to a JSP from a servlet, the path passed to `getRequestDispatcher()` is **relative to the application root** (not the server root). It starts with `/` but does not include the context path.

```java
// Correct — path is relative to the app root
request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);

// Wrong — do NOT include the context path
request.getRequestDispatcher("/learning-logs/WEB-INF/views/register.jsp").forward(request, response);
```

The servlet container resolves the path within your application automatically.

## WEB-INF Protection

The `WEB-INF` directory has a special rule enforced by the servlet container: **browsers cannot access files inside it directly**.

```
http://localhost:8080/learning-logs/WEB-INF/views/register.jsp  --> 404 (blocked)
```

Only servlets can reach WEB-INF contents via `RequestDispatcher.forward()`. This is a security feature:

- Users cannot navigate directly to a JSP and bypass your servlet logic (validation, authentication, data loading)
- All requests must go through your servlets first, which act as controllers

### The Pattern

```
Browser --> /register (servlet URL) --> RegisterServlet --> forward to /WEB-INF/views/register.jsp
```

The user sees `/register` in the address bar. The JSP inside WEB-INF is never directly exposed.
