# Login Flow — Step by Step

## Overview

Login follows the same servlet pattern as registration: GET displays the form, POST processes the submission. The key difference is that login **verifies** a password against a stored BCrypt hash instead of creating a new user.

## The Complete Flow

### 1. User Visits `/login` (GET Request)

The browser sends a GET request. The servlet's `doGet()` method handles it.

```java
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
}
```

This forwards to `login.jsp`, which renders the login form.

### 2. User Fills the Form and Clicks Login (POST Request)

The browser sends a POST request with username and password. The servlet's `doPost()` method handles it.

### 3. Extract Parameters

```java
String username = request.getParameter("username");
String password = request.getParameter("password");
```

Only two fields — login is simpler than registration (no email, no confirm password).

### 4. Find the User in the Database

```java
User user = userDao.findByUsername(username);
```

`findByUsername()` returns a `User` object if found, or `null` if no user exists with that username.

### 5a. If User Not Found — Forward Back with Error

```java
if (user == null) {
    request.setAttribute("error", "Invalid username or password.");
    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    return;
}
```

### 5b. If User Found — Verify Password

```java
if (!PasswordUtil.checkPassword(password, user.getPassword())) {
    request.setAttribute("error", "Invalid username or password.");
    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    return;
}
```

`checkPassword()` calls `BCrypt.checkpw()` which:
1. Extracts the salt from the stored hash
2. Re-hashes the typed password with that same salt
3. Compares the result to the stored hash

### 6. On Success — Redirect to Topics

```java
response.sendRedirect(request.getContextPath() + "/topic");
```

## Same Error Message — Why?

Both "user not found" and "wrong password" show the **same message**: `"Invalid username or password."` This is intentional security practice.

If the messages were different:
- "Username not found" → attacker learns this username doesn't exist
- "Wrong password" → attacker learns this username **does** exist and can focus on cracking the password

This is called **username enumeration** — and it makes brute-force attacks easier. A generic error message prevents it.

## How BCrypt.checkpw() Works

During registration, BCrypt created a hash like this:

```
$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
^^^^  ^^  ^^^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
algo  cost  salt (22 chars)         hash (31 chars)
```

During login, `BCrypt.checkpw(typedPassword, storedHash)`:
1. Reads the cost (`10`) and salt from the stored hash
2. Hashes the typed password using the same cost and salt
3. Compares the resulting hash to the stored one
4. Returns `true` if they match, `false` otherwise

You never decrypt the password — BCrypt is one-way. You hash the input the same way and compare results.

## Forward vs Redirect (Same Pattern as Registration)

```
ERROR → Forward (preserve form data)
  Browser ---POST /login---> LoginServlet ---forward---> login.jsp
  URL stays: /login
  ${param.username} shows what user typed

SUCCESS → Redirect (Post/Redirect/Get)
  Browser ---POST /login---> LoginServlet ---302---> Browser ---GET /topic---> TopicServlet
  URL changes: /topic
  Prevents form resubmission on refresh
```

## Login vs Registration — Side by Side

| | Registration | Login |
|---|---|---|
| **Form fields** | 4 (username, email, password, confirm) | 2 (username, password) |
| **Validation** | Username rules, email format, password strength, match | None (just check credentials) |
| **Password** | Hash and store (`getHashPassword`) | Verify against stored hash (`checkPassword`) |
| **On success** | Redirect to `/login` | Redirect to `/topic` |
| **On error** | Forward with specific validation messages | Forward with generic "Invalid username or password." |
| **Value retention** | Username + email preserved | Username preserved |

## What's Missing — No Session Yet

After a successful login, the user is redirected to `/topic`. But the app **doesn't remember** that they logged in. If they navigate to another page and come back, there's no way to know who they are.

This is because we haven't implemented **session management** yet. That's Week 7:

```java
// Week 7 will add this after successful login:
HttpSession session = request.getSession();
session.setAttribute("userId", user.getId());
session.setAttribute("username", user.getUsername());
```

For now, login "works" (validates credentials) but doesn't "stick" (no persistent state).
