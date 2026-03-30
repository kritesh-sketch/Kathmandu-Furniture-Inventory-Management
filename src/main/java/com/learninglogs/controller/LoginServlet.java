package com.learninglogs.controller;

import com.learninglogs.dao.UserDao;
import com.learninglogs.dao.UserDaoImpl;
import com.learninglogs.entity.User;
import com.learninglogs.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * LoginServlet — handles user login.
 *
 * URL: /login
 *
 * GET  /login → forward to login.jsp (displays the form)
 * POST /login → find user, verify password, redirect on success
 */

// ============================================================
// TODO 4: Servlet Setup + doPost Start
// ============================================================
// Add the UserDao field and begin the doPost method.
//
// Steps:
//   1. Add a UserDao field: private final UserDao userDao = new UserDaoImpl();
//      (Same pattern as RegisterServlet's DAO field)
//   2. Override doPost method
//   3. Extract two parameters from the request:
//      - username: request.getParameter("username")
//      - password: request.getParameter("password")
//
// CONCEPT: The DAO field is created once when the servlet is loaded
// and reused for all requests. In RegisterServlet you used it to
// INSERT users — here you'll use it to FIND users by username.
//
// The complete code:
//
//   private final UserDao userDao = new UserDaoImpl();
//
//   @Override
//   protected void doPost(HttpServletRequest request, HttpServletResponse response)
//           throws ServletException, IOException {
//
//       String username = request.getParameter("username");
//       String password = request.getParameter("password");
//
//       // TODOs 5-7 continue here
//   }
//
// ============================================================

// ============================================================
// TODO 5: Find User
// ============================================================
// Look up the user in the database by username.
//
// Steps:
//   1. Call userDao.findByUsername(username)
//   2. If the result is null (user doesn't exist):
//      - Set error attribute: "Invalid username or password."
//      - Forward back to login.jsp
//      - Return (stop processing)
//
// SECURITY: Use the SAME error message "Invalid username or password."
// for user-not-found AND wrong-password (TODO 6). Never say
// "Username not found" — that tells an attacker the username exists.
// This prevents username enumeration attacks.
//
// The complete code:
//
//   User user = userDao.findByUsername(username);
//
//   if (user == null) {
//       request.setAttribute("error", "Invalid username or password.");
//       request.getRequestDispatcher("/WEB-INF/views/login.jsp")
//              .forward(request, response);
//       return;
//   }
//
// ============================================================

// ============================================================
// TODO 6: Verify Password
// ============================================================
// Check the typed password against the stored BCrypt hash.
//
// Steps:
//   1. Call PasswordUtil.checkPassword(password, user.getPassword())
//      - First argument: the plaintext password the user typed
//      - Second argument: the BCrypt hash stored in the database
//   2. If it returns false (password doesn't match):
//      - Set error attribute: "Invalid username or password."
//        (SAME message as TODO 5 — security practice)
//      - Forward back to login.jsp
//      - Return (stop processing)
//
// CONCEPT: In the tutorial you used PasswordUtil.getHashPassword()
// to CREATE a hash during registration. Now you use checkPassword()
// to VERIFY a password against the stored hash. BCrypt.checkpw()
// extracts the salt from the stored hash, re-hashes the input with
// that same salt, and compares the result.
//
// The complete code:
//
//   if (!PasswordUtil.checkPassword(password, user.getPassword())) {
//       request.setAttribute("error", "Invalid username or password.");
//       request.getRequestDispatcher("/WEB-INF/views/login.jsp")
//              .forward(request, response);
//       return;
//   }
//
// ============================================================

// ============================================================
// TODO 7: Success Redirect
// ============================================================
// If we reach this point, the user exists AND the password matches.
// Redirect to the topic list page.
//
// Steps:
//   1. Call response.sendRedirect() to the topic page
//      Use request.getContextPath() + "/topic"
//
// CONCEPT: Same Post/Redirect/Get pattern as RegisterServlet.
// After successful registration you redirected to /login.
// After successful login you redirect to /topic.
// Redirect (not forward) prevents form resubmission on refresh.
//
// NOTE: This redirect takes the user to the topic list, but the
// app doesn't "remember" who logged in. There's no session yet —
// that's Week 7. For now, login validates credentials but doesn't
// persist the login state.
//
// The complete code:
//
//   response.sendRedirect(request.getContextPath() + "/topic");
//
// ============================================================
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TODOs 4-7: Find user, verify password, redirect on success
        final UserDao userDao = new UserDaoImpl();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDao.findByUsername(username);

       if (user == null) {
           request.setAttribute("error", "Invalid username or password.");
           request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                  .forward(request, response);
           return;
       }

       if (!PasswordUtil.checkPassword(password, user.getPassword())) {
       request.setAttribute("error", "Invalid username or password.");
       request.getRequestDispatcher("/WEB-INF/views/login.jsp")
              .forward(request, response);
       return;
        }
        response.sendRedirect(request.getContextPath() + "/topic");
    }
}
