# Encryption vs Hashing

## Data Encryption

Encryption is a **two-way** process. You encrypt data with a key, and later decrypt it with a key to get the original data back.

- **Reversible**: ciphertext can be converted back to plaintext
- **Key-based**: requires a secret key (symmetric) or key pair (asymmetric)
- **Example algorithm**: AES (Advanced Encryption Standard)
- **Use cases**: data in transit (HTTPS/TLS), stored data you need to read back (credit card numbers, medical records)

```
plaintext  --[key]--> ciphertext  --[key]--> plaintext
```

## Hashing

Hashing is a **one-way** process. You feed data in and get a fixed-length digest out. There is no way to reverse it.

- **Irreversible**: you cannot recover the original input from the hash
- **No key**: the same input always produces the same output
- **Example algorithms**: BCrypt, SHA-256
- **Use cases**: password storage, data integrity checks, checksums

```
plaintext  --[hash function]--> digest  (no way back)
```

## Why Hash Passwords Instead of Encrypting Them?

If you encrypt passwords and store them in a database:

- An attacker who steals the database **and** the encryption key can decrypt every password instantly.
- The key must exist somewhere the application can reach it, making it a single point of failure.

If you hash passwords instead:

- Even if the entire database is stolen, the attacker only has hashes.
- There is no key to steal — the hashes cannot be reversed.
- The attacker is forced to guess passwords one at a time and compare hashes, which is slow (especially with BCrypt).

## Comparison Table

| | Encryption | Hashing |
|---|---|---|
| **Direction** | Two-way (encrypt + decrypt) | One-way (hash only) |
| **Reversible?** | Yes, with the correct key | No |
| **Key required?** | Yes | No |
| **Output length** | Varies with input size | Fixed length |
| **Example** | AES-256 | BCrypt, SHA-256 |
| **Password storage?** | No — key compromise exposes all passwords | Yes — no key to compromise |
| **Good for** | Data you need to read back | Data you only need to verify |
