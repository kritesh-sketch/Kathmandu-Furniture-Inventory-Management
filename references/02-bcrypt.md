# BCrypt Password Hashing

## What Makes BCrypt Special

BCrypt was designed specifically for password hashing. Two features set it apart from general-purpose hash functions like SHA-256:

1. **Built-in salting** — automatically generates a 16-byte random salt and embeds it in the output
2. **Adjustable cost factor** — lets you control how slow the hash is to compute

## Cost Factor

The cost factor controls how many iterations BCrypt performs internally. The number of iterations is 2^cost.

| Cost | Iterations | Approximate Time |
|------|-----------|-----------------|
| 10 | 1,024 | ~100ms |
| 12 | 4,096 | ~300ms |
| 14 | 16,384 | ~1s |

Higher cost = slower hashing = harder to brute-force. A cost of 10-12 is typical for web applications. You can increase it over time as hardware gets faster.

## Salt

A salt is random data mixed with the password before hashing. It solves a specific problem:

- Without salt: every user with password `hunter2` gets the same hash. An attacker can precompute a table of common password hashes (a **rainbow table**) and look them up instantly.
- With salt: each user gets a unique random salt, so identical passwords produce different hashes. Rainbow tables become useless.

BCrypt embeds the salt directly in the hash string — you do not need to store it separately.

## Hash Format

A BCrypt hash looks like this:

```
$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
```

Breaking it down:

| Segment | Meaning |
|---------|---------|
| `$2a$` | BCrypt version identifier |
| `10$` | Cost factor (2^10 = 1024 iterations) |
| Next 22 characters | Base64-encoded salt |
| Remaining 31 characters | Base64-encoded hash |

The entire 60-character string is what you store in the database.

## Java API

### Maven Dependency

```xml
<dependency>
    <groupId>org.mindrot</groupId>
    <artifactId>jbcrypt</artifactId>
    <version>0.4</version>
</dependency>
```

### Key Methods

```java
// Generate a salt with a specified cost factor
String salt = BCrypt.gensalt(12);  // cost = 12

// Hash a password using the generated salt
String hash = BCrypt.hashpw(plainPassword, salt);  // returns 60-char string

// Verify a password against a stored hash
boolean match = BCrypt.checkpw(inputPassword, storedHash);  // true or false
```

## Registration Flow

When a user registers:

```java
String salt = BCrypt.gensalt(12);
String hashedPassword = BCrypt.hashpw(rawPassword, salt);
// Store hashedPassword in the database (60 chars)
```

## Login Flow

When a user logs in:

```java
// 1. Retrieve the stored hash from the database by username
String storedHash = userDao.getUser(username).getPassword();

// 2. Compare the typed password against the stored hash
if (BCrypt.checkpw(typedPassword, storedHash)) {
    // Login success
} else {
    // Login failure
}
```

`checkpw` extracts the salt and cost factor from the stored hash automatically — you never need to store or retrieve the salt separately.
