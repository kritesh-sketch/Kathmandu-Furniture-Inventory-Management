<%-- ============================================================
     TODO 3: JSP Directives
     ============================================================
     Add TWO directives at the very top of this file (before the
     DOCTYPE declaration):

     1. Page directive — tells the server this is a JSP page:
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>

     2. JSTL taglib directive — imports the core tag library so
        you can use <c:forEach> and <c:if>:
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

     Same pattern as topic-list.jsp — every JSP page needs these.

     The complete code:

       <%@ page contentType="text/html;charset=UTF-8" language="java" %>
       <%@ taglib prefix="c" uri="jakarta.tags.core" %>
     ============================================================ --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

  <%-- ============================================================
       TODO 4: Head Section + Header + Navbar
       ============================================================
       Convert the static HTML head, header, and navbar to use
       dynamic paths with ${pageContext.request.contextPath}.

       1. Head section with contextPath CSS links:
          - Two <link> tags: main.css and entry-list.css
          - href="${pageContext.request.contextPath}/static/css/main.css"
          - href="${pageContext.request.contextPath}/static/css/entry-list.css"

       2. Header — same structure as topic-list.jsp:
          - Logo <a> href="${pageContext.request.contextPath}/topic"
          - Image src="${pageContext.request.contextPath}/static/images/book.png"

       3. Navbar — three items:
          - First li: "< Back (Topics)" link back to topic list
          - Second li: "Entries List" title
          - Third li: "+New Entry" link with topicid parameter

       CONCEPT: The entry list always exists in the context of a topic.
       The "+New Entry" link must include ?topicid=${topic.id} so the
       servlet knows which topic the new entry belongs to. Same for the
       "< Back" link — it goes to the topic list, not the entry list.

       The complete structure:

         <head>
           <meta charset="UTF-8" />
           <meta name="viewport" content="width=device-width, initial-scale=1.0" />
           <title>Learning Log</title>
           <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
           <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/entry-list.css" />
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
             <li><a href="${pageContext.request.contextPath}/topic">&lt; Back (Topics)</a></li>
             <li><p>Entries List</p></li>
             <li><a href="${pageContext.request.contextPath}/entry?action=new&topicid=${topic.id}">+New Entry</a></li>
           </ul>
         </nav>

       Wireframe: See wireframes/entries-list.png
       ============================================================ --%>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/entry-list.css" />
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
          <li><a href="${pageContext.request.contextPath}/topic">&lt; Back (Topics)</a></li>
          <li><p>Entries List</p></li>
          <li><a href="${pageContext.request.contextPath}/entry?action=new&topicid=${topic.id}">+New Entry</a></li>
        </ul>
      </nav>

      <%-- ============================================================
           TODO 5: Dynamic Content — Search + Entry Cards
           ============================================================
           Build the main content area with a search bar and entry cards.

           1. Search bar — same pattern as topic-list.jsp but for entries:
              - form action="${pageContext.request.contextPath}/entry"
              - Hidden inputs: action=search AND topicid=${topic.id}
              - Label: "Entry: "
              - Input: name="search" with value="${searchKeyword}"
              - Button: "SEARCH"

              NOTE: The search form needs TWO hidden inputs — "action"
              AND "topicid". This is because entries are searched WITHIN
              a specific topic, not globally like topics.

           2. Topic title — show which topic these entries belong to:
              <h2 class="topic-title">${topic.name}</h2>

           3. Entry grid — use <c:forEach> to loop over ${entries}:

              <div class="entry-grid">
                <c:forEach var="entry" items="${entries}">
                  ... one entry card per iteration ...
                </c:forEach>
              </div>

           4. Each entry card (<div class="entry-card">) contains:

              a) Entry header with title, date, and photo:
                 - <h3>${entry.title}</h3>
                 - <p class="date">Date: ${entry.createdAt}</p>
                 - <div class="photo">Photo</div>

              b) Entry text:
                 <p class="entry-text">${entry.text}</p>

              c) Link (if exists):
                 <p class="link">Link: <a href="${entry.link}">${entry.link}</a></p>

              d) Entry actions — Edit link + Delete form:
                 - Edit: <a> link to ?action=edit&entryid=ID&topicid=ID
                 - Delete: <form> with POST, hidden action=delete,
                   hidden entryid, hidden topicid, confirm dialog

           CONCEPT: Each entry card has its own delete <form> (same
           pattern as topic delete). The edit action uses a GET link
           (same as topic edit). Both include topicid so the servlet
           knows which topic to return to after the operation.

           The complete content structure:

             <main class="content">
               <div class="search-bar">
                 <form action="${pageContext.request.contextPath}/entry" method="get">
                   <input type="hidden" name="action" value="search" />
                   <input type="hidden" name="topicid" value="${topic.id}" />
                   <label for="search">Entry: </label>
                   <input type="text" name="search" placeholder="Search..." value="${searchKeyword}" />
                   <button type="submit">SEARCH</button>
                 </form>
               </div>

               <h2 class="topic-title">${topic.name}</h2>

               <div class="entry-grid">
                 <c:forEach var="entry" items="${entries}">
                   <div class="entry-card">
                     <div class="entry-header">
                       <div>
                         <h3>${entry.title}</h3>
                         <p class="date">Date: ${entry.createdAt}</p>
                       </div>
                       <div class="photo">Photo</div>
                     </div>

                     <p class="entry-text">${entry.text}</p>

                     <p class="link">
                       Link: <a href="${entry.link}">${entry.link}</a>
                     </p>

                     <div class="entry-actions">
                       <a href="${pageContext.request.contextPath}/entry?action=edit&entryid=${entry.id}&topicid=${topic.id}">
                         <button>Edit</button>
                       </a>
                       <form action="${pageContext.request.contextPath}/entry" method="post">
                         <input type="hidden" name="action" value="delete" />
                         <input type="hidden" name="entryid" value="${entry.id}" />
                         <input type="hidden" name="topicid" value="${topic.id}" />
                         <button class="danger" type="submit"
                           onclick="return confirm('Are you sure you want to delete?');">
                           Delete
                         </button>
                       </form>
                     </div>
                   </div>
                 </c:forEach>
               </div>
             </main>

           Wireframe: See wireframes/entries-list.png
           ============================================================ --%>
      <main class="content">
        <div class="search-bar">
          <form action="${pageContext.request.contextPath}/entry" method="get">
            <input type="hidden" name="action" value="search" />
            <input type="hidden" name="topicid" value="${topic.id}" />
            <label for="search">Entry: </label>
            <input type="text" name="search" placeholder="Search..." value="${searchKeyword}" />
            <button type="submit">SEARCH</button>
          </form>
        </div>

        <h2 class="topic-title">${topic.name}</h2>

        <div class="entry-grid">
          <c:forEach var="entry" items="${entries}">
            <div class="entry-card">
              <div class="entry-header">
                <div>
                  <h3>${entry.title}</h3>
                  <p class="date">Date: ${entry.createdAt}</p>
                </div>
                <div class="photo">Photo</div>
              </div>

              <p class="entry-text">${entry.text}</p>

              <p class="link">
                Link: <a href="${entry.link}">${entry.link}</a>
              </p>

              <div class="entry-actions">
                <a href="${pageContext.request.contextPath}/entry?action=edit&entryid=${entry.id}&topicid=${topic.id}">
                  <button>Edit</button>
                </a>
                <form action="${pageContext.request.contextPath}/entry" method="post">
                  <input type="hidden" name="action" value="delete" />
                  <input type="hidden" name="entryid" value="${entry.id}" />
                  <input type="hidden" name="topicid" value="${topic.id}" />
                  <button class="danger" type="submit"
                    onclick="return confirm('Are you sure you want to delete?');">
                    Delete
                  </button>
                </form>
              </div>
            </div>
          </c:forEach>
        </div>
      </main>

      <footer class="footer">
        <h3>&copy; Learning Logs</h3>
      </footer>

    </div>
  </body>
</html>
