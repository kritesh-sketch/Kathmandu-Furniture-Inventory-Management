<%-- ============================================================
     TODO 6: JSP Directives
     ============================================================
     Add TWO directives at the very top of this file (before the
     DOCTYPE declaration):

     1. Page directive:
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>

     2. JSTL taglib directive:
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

     Same pattern as every other JSP page.

     The complete code:

       <%@ page contentType="text/html;charset=UTF-8" language="java" %>
       <%@ taglib prefix="c" uri="jakarta.tags.core" %>
     ============================================================ --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

  <%-- ============================================================
       TODO 7: Head Section + Header + Navbar
       ============================================================
       Same pattern as entry-list.jsp, but with different CSS file
       and different navbar text.

       1. Head — link main.css + entry-add.css (not entry-list.css)

       2. Header — identical to entry-list.jsp

       3. Navbar — different text:
          - First li: "< Back (Entries)" link back to entry list
            (includes topicid so we return to the correct topic)
          - Second li: Dynamic title using EL ternary operator
          - Third li: empty

       CONCEPT: The back link needs topicid to return to the correct
       entry list. We use ${param.topicid} to read the topicid from
       the URL parameter directly — this works for both "new" (where
       topicid is in the URL) and "edit" (where topicid is also in
       the URL).

       The EL ternary ${empty entry ? 'Add Entry' : 'Edit Entry'}
       checks if an "entry" attribute exists in the request. If the
       servlet set an entry (for editing), it shows "Edit Entry".
       If not (adding new), it shows "Add Entry". Same pattern as
       topic-add-edit.jsp uses for topics.

       The complete structure:

         <head>
           <meta charset="UTF-8" />
           <meta name="viewport" content="width=device-width, initial-scale=1.0" />
           <title>Learning Log</title>
           <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
           <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/entry-add.css" />
         </head>

         (inside body, inside div.page:)
         <header class="header">
           <div class="logo">
             <a href="${pageContext.request.contextPath}/topic" style="text-decoration: none">
               <img src="${pageContext.request.contextPath}/static/images/book.png" alt="LL" />
             </a>
             <h3>Learning Log</h3>
           </div>
           <div class="usersession">
             <h3>Username</h3>
             <a href="#" class="logout">Logout</a>
           </div>
         </header>

         <nav class="navbar">
           <ul>
             <li><a href="${pageContext.request.contextPath}/entry?topicid=${param.topicid}">&lt; Back (Entries)</a></li>
             <li><p>${empty entry ? 'Add Entry' : 'Edit Entry'}</p></li>
             <li></li>
           </ul>
         </nav>

       Wireframe: See wireframes/add-edit-entries.png
       ============================================================ --%>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/entry-add.css" />
  </head>

  <body>
    <div class="page">

      <header class="header">
        <div class="logo">
          <a href="${pageContext.request.contextPath}/topic" style="text-decoration: none">
            <img src="${pageContext.request.contextPath}/static/images/book.png" alt="LL" />
          </a>
          <h3>Learning Log</h3>
        </div>
        <div class="usersession">
          <h3>Username</h3>
          <a href="#" class="logout">Logout</a>
        </div>
      </header>

      <nav class="navbar">
        <ul>
          <li><a href="${pageContext.request.contextPath}/entry?topicid=${param.topicid}">&lt; Back (Entries)</a></li>
          <li><p>${empty entry ? 'Add Entry' : 'Edit Entry'}</p></li>
          <li></li>
        </ul>
      </nav>

      <%-- ============================================================
           TODO 8: Form Content with EL Expressions
           ============================================================
           Build the multi-field form that submits to EntryServlet via POST.

           Key differences from topic-add-edit.jsp:
           1. FOUR input fields instead of one (title, text, link, image)
           2. Uses <textarea> for the description field
           3. Hidden inputs include topicid (entry belongs to a topic)
           4. Title and text are required; link and image are optional

           Structure:

           1. Error message (same pattern as topic-add-edit.jsp):
              <c:if test="${not empty error}"> shows error from servlet

           2. Form action and hidden inputs:
              - action="${pageContext.request.contextPath}/entry"
              - Hidden "action": add or edit (based on ${empty entry})
              - Hidden "topicid": always needed (from ${param.topicid})
              - Hidden "entryid": only in edit mode (from ${entry.id})

           3. Form rows (4 fields):
              a) Title:  <input type="text" name="title">
              b) Text:   <textarea name="text" rows="4">
              c) Link:   <input type="text" name="link">
              d) Image:  <input type="text" name="image">

           4. Each input uses EL to pre-fill for edit mode:
              value="${empty entry ? '' : entry.title}"
              For textarea, content goes between tags:
              ${empty entry ? '' : entry.text}

           5. Save button in form-actions div

           CONCEPT: The form has the same add/edit dual-purpose pattern
           as topic-add-edit.jsp. ${empty entry} determines the mode.
           link and image are optional — the servlet only validates
           title and text.

           The complete content structure:

             <main class="content">
               <h2 class="topic-title">${topic.name}</h2>

               <div class="form-card">
                 <c:if test="${not empty error}">
                   <p style="color: red; text-align: center; padding: 5px;">${error}</p>
                 </c:if>
                 <form action="${pageContext.request.contextPath}/entry" method="post">
                   <input type="hidden" name="action" value="${empty entry ? 'add' : 'edit'}" />
                   <input type="hidden" name="topicid" value="${param.topicid}" />
                   <c:if test="${not empty entry}">
                     <input type="hidden" name="entryid" value="${entry.id}" />
                   </c:if>

                   <div class="form-row">
                     <label for="title">Title:</label>
                     <input type="text" id="title" name="title" placeholder="Title"
                            value="${empty entry ? '' : entry.title}" />
                   </div>

                   <div class="form-row">
                     <label for="text">Description:</label>
                     <textarea id="text" name="text" rows="4"
                       placeholder="Description">${empty entry ? '' : entry.text}</textarea>
                   </div>

                   <div class="form-row">
                     <label for="link">Link:</label>
                     <input type="text" id="link" name="link" placeholder="Link URL"
                            value="${empty entry ? '' : entry.link}" />
                   </div>

                   <div class="form-row">
                     <label for="image">Image:</label>
                     <input type="text" id="image" name="image" placeholder="Image URL"
                            value="${empty entry ? '' : entry.image}" />
                   </div>

                   <div class="form-actions">
                     <button type="submit">Save</button>
                   </div>
                 </form>
               </div>
             </main>

           Wireframe: See wireframes/add-edit-entries.png
           ============================================================ --%>
      <main class="content">
        <h2 class="topic-title">${topic.name}</h2>

        <div class="form-card">
          <c:if test="${not empty error}">
            <p style="color: red; text-align: center; padding: 5px;">${error}</p>
          </c:if>
          <form action="${pageContext.request.contextPath}/entry" method="post">
            <input type="hidden" name="action" value="${empty entry ? 'add' : 'edit'}" />
            <input type="hidden" name="topicid" value="${param.topicid}" />
            <c:if test="${not empty entry}">
              <input type="hidden" name="entryid" value="${entry.id}" />
            </c:if>

            <div class="form-row">
              <label for="title">Title:</label>
              <input type="text" id="title" name="title" placeholder="Title"
                     value="${empty entry ? '' : entry.title}" />
            </div>

            <div class="form-row">
              <label for="text">Description:</label>
              <textarea id="text" name="text" rows="4"
                placeholder="Description">${empty entry ? '' : entry.text}</textarea>
            </div>

            <div class="form-row">
              <label for="link">Link:</label>
              <input type="text" id="link" name="link" placeholder="Link URL"
                     value="${empty entry ? '' : entry.link}" />
            </div>

            <div class="form-row">
              <label for="image">Image:</label>
              <input type="text" id="image" name="image" placeholder="Image URL"
                     value="${empty entry ? '' : entry.image}" />
            </div>

            <div class="form-actions">
              <button type="submit">Save</button>
            </div>
          </form>
        </div>
      </main>

      <footer class="footer">
        <h3>&copy; Learning Logs</h3>
      </footer>

    </div>
  </body>
</html>
