<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Learning Log</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/topic-list.css" />
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
          <li></li>
          <li><p>Topic Lists</p></li>
          <li><a href="${pageContext.request.contextPath}/topic?action=new">+New Topic</a></li>
        </ul>
      </nav>
      <main class="content">
        <div class="search">
          <form action="${pageContext.request.contextPath}/topic" method="get">
            <input type="hidden" name="action" value="search" />
            <label for="search">Topic: </label>
            <input type="text" name="search" placeholder="Search..." value="${searchKeyword}" />
            <button type="submit">SEARCH</button>
          </form>
        </div>
        <div class="topicContainer">
          <ul>
            <c:forEach var="topic" items="${topics}" varStatus="status">
              <li class="topicItem">
                <a class="topic" href="${pageContext.request.contextPath}/entry?topicid=${topic.id}">${status.count}. ${topic.name}</a>
                <a class="edit" href="${pageContext.request.contextPath}/topic?action=edit&topicid=${topic.id}">Edit</a>
                <form action="${pageContext.request.contextPath}/topic" method="post">
                  <input type="hidden" name="action" value="delete" />
                  <input type="hidden" name="topicid" value="${topic.id}" />
                  <button class="submit" type="submit"
                    onclick="return confirm('Are you sure you want to delete?');">
                    Delete
                  </button>
                </form>
              </li>
            </c:forEach>
          </ul>
        </div>
      </main>

      <footer class="footer">
        <h3>&copy; Learning Logs</h3>
      </footer>

    </div>
  </body>
</html>
