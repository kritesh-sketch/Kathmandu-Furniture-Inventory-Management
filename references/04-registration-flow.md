# Registration Flow — Step by Step

## Overview

Registration uses the standard servlet pattern: GET displays the form, POST processes the submission.

## The Complete Flow

### 1. User Visits `/register` (GET Request)

The browser sends a GET request. The servlet's `doGet()` method handles it.

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
}
```

This forwards to `register.jsp`, which renders an empty form.

### 2. User Fills the Form and Clicks Register (POST Request)

The browser sends a POST request with form data. The servlet's `doPost()` method handles it.

### 3. Extract Parameters

```java
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");
String confirmPassword = request.getParameter("cpassword");
```

### 4. Validate All Inputs

Each field is checked using `ValidationUtil`. Errors are collected in a `StringBuilder` so the user sees all problems at once.

### 5a. If Validation Fails — Forward Back

```java
request.setAttribute("error", error.toString());
request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
return;
```

The JSP can repopulate the form using `${param.username}` and `${param.email}` so the user does not have to retype everything.

**Password fields are intentionally NOT repopulated** with `${param.password}`. This is a security practice — passwords should not be echoed back into HTML, where they could be cached or exposed in page source.

### 5b. If Validation Passes — Hash and Store

```java
String hashedPassword = PasswordUtil.getHashPassword(password);
User user = new User(username, email, hashedPassword);
userDao.insertUser(user);
```

### 6. Handle Duplicate Users

If the database insert fails (e.g., username already exists):

```java
request.setAttribute("error", "Username or email already exists.");
request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
```

### 7. On Success — Redirect to Login

```java
response.sendRedirect(request.getContextPath() + "/login");
```

## Forward vs Redirect

These are two different ways to send the user to another page, and the distinction matters.

```
FORWARD (server-side)
Browser ---POST /register---> RegisterServlet ---forward---> register.jsp
  URL stays: /register
  Request data: preserved (attributes + parameters)
  Use when: showing errors on the same form

REDIRECT (client-side)
Browser ---POST /register---> RegisterServlet ---302 redirect---> Browser ---GET /login---> LoginServlet
  URL changes: /login
  Request data: lost (new request entirely)
  Use when: success — prevents form resubmission on refresh
```

### Why Redirect After Success?

If you forward to a success page after a POST, the user's browser still thinks the last action was a POST to `/register`. If they refresh the page, the browser resubmits the POST and tries to create the account again.

A redirect causes the browser to make a fresh GET request. Refreshing the page just repeats the GET — no duplicate submission.

This pattern is called **Post/Redirect/Get (PRG)**.
