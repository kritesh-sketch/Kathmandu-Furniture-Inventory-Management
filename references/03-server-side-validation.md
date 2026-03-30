# Server-Side Validation

## Why Validate on the Server

Client-side validation (HTML `required` attributes, JavaScript checks) improves user experience, but it is **not a security measure**. Anyone can bypass it:

- Disable JavaScript in browser settings
- Edit HTML attributes in browser dev tools
- Send requests directly with `curl`, Postman, or a script

Server-side validation is your **last line of defense**. Every input must be validated on the server regardless of what the client does.

## ValidationUtil Patterns

This project uses a `ValidationUtil` class with static methods for common checks.

### Null or Empty Check

```java
public static boolean isNullOrEmpty(String value) {
    return value == null || value.trim().isEmpty();
}
```

Handles three cases: `null`, empty string `""`, and whitespace-only strings like `"   "`.

### Alphanumeric Starting With Letter

```java
public static boolean isAlphanumericStartingWithLetter(String value) {
    return value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
}
```

- First character must be a letter (a-z or A-Z)
- Remaining characters can be letters or digits
- No spaces, symbols, or special characters
- Used for: usernames

### Valid Email

```java
public static boolean isValidEmail(String email) {
    // Regex pattern for standard email format
}
```

Checks for the general pattern: `local@domain.tld`.

### Valid Password

```java
public static boolean isValidPassword(String password) {
    // Requires: 8+ characters, at least one uppercase letter,
    //           at least one number, at least one symbol
}
```

Enforces password strength rules. Each requirement is checked independently so you can report which specific rule failed.

### Passwords Match

```java
public static boolean doPasswordsMatch(String password, String confirmPassword) {
    return password.equals(confirmPassword);
}
```

Simple equality check between the password and confirmation fields.

## How RegisterServlet Uses Validation

The servlet collects **all** errors before responding, so the user sees every problem at once instead of fixing them one at a time.

```java
StringBuilder error = new StringBuilder();

if (ValidationUtil.isNullOrEmpty(username)) {
    error.append("Username is required. ");
}
if (!ValidationUtil.isAlphanumericStartingWithLetter(username)) {
    error.append("Username must start with a letter and be alphanumeric. ");
}
if (!ValidationUtil.isValidEmail(email)) {
    error.append("Invalid email format. ");
}
if (!ValidationUtil.isValidPassword(password)) {
    error.append("Password must be 8+ chars with uppercase, number, and symbol. ");
}
if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
    error.append("Passwords do not match. ");
}

if (error.length() > 0) {
    request.setAttribute("error", error.toString());
    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    return;
}
```

## Displaying Errors in JSP

The JSP checks for the error attribute and displays it when present:

```jsp
<c:if test="${not empty error}">
    <div class="error-message">${error}</div>
</c:if>
```

This uses JSTL's `<c:if>` tag. The `not empty` check covers both null and empty string cases.
