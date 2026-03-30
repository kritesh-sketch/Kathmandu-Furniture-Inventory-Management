package com.learninglogs.controller;

import com.learninglogs.dao.TopicDao;
import com.learninglogs.dao.TopicDaoImpl;
import com.learninglogs.entity.Topic;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

/**
 * TopicServlet — handles all topic-related HTTP requests.
 *
 * URL: /topic
 *
 * GET actions:
 *   (default)      -> list all topics   -> topic-list.jsp
 *   ?action=new    -> show add form     -> topic-add-edit.jsp
 *   ?action=edit   -> show edit form    -> topic-add-edit.jsp (pre-filled)
 *   ?action=search -> search topics     -> topic-list.jsp (filtered)
 *
 * POST actions:
 *   action=add     -> insert new topic  -> redirect to /topic
 *   action=edit    -> update topic      -> redirect to /topic
 *   action=delete  -> delete topic      -> redirect to /topic
 *
 * Week 5: doPost "add" action now sets userId on the new Topic.
 */
@WebServlet("/topic")
public class TopicServlet extends HttpServlet {

    private final TopicDao topicDao = new TopicDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            ArrayList<Topic> topics = topicDao.fetchAllTopics();
            request.setAttribute("topics", topics);
            request.getRequestDispatcher("/WEB-INF/views/topic-list.jsp")
                   .forward(request, response);
        }
        else if ("new".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/views/topic-add-edit.jsp")
                   .forward(request, response);
        }
        else if ("edit".equals(action)) {
            int topicId = Integer.parseInt(request.getParameter("topicid"));
            Topic topic = topicDao.findTopicById(topicId);
            request.setAttribute("topic", topic);
            request.getRequestDispatcher("/WEB-INF/views/topic-add-edit.jsp")
                   .forward(request, response);
        }
        else if ("search".equals(action)) {
            String keyword = request.getParameter("search");
            ArrayList<Topic> topics;
            if (keyword == null || keyword.trim().isEmpty()) {
                topics = topicDao.fetchAllTopics();
            } else {
                topics = topicDao.searchTopics(keyword.trim());
            }
            request.setAttribute("topics", topics);
            request.setAttribute("searchKeyword", keyword);
            request.getRequestDispatcher("/WEB-INF/views/topic-list.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String topicName = request.getParameter("topic");

            if (topicName == null || topicName.trim().isEmpty()) {
                request.setAttribute("error", "Topic name cannot be empty.");
                request.getRequestDispatcher("/WEB-INF/views/topic-add-edit.jsp")
                       .forward(request, response);
                return;
            }

            // UPDATED for Week 5 — create Topic and set userId before insert
            // Week 4 was: topicDao.insertTopic(new Topic(topicName.trim()))
            Topic newTopic = new Topic(topicName.trim());
            newTopic.setUserId(1);  // Hardcoded userId=1 until session management in Week 7
            boolean success = topicDao.insertTopic(newTopic);

            if (!success) {
                request.setAttribute("error", "Topic already exists.");
                request.getRequestDispatcher("/WEB-INF/views/topic-add-edit.jsp")
                       .forward(request, response);
                return;
            }

            response.sendRedirect(request.getContextPath() + "/topic");
        }
        else if ("edit".equals(action)) {
            int topicId = Integer.parseInt(request.getParameter("topicid"));
            String topicName = request.getParameter("topic");

            if (topicName == null || topicName.trim().isEmpty()) {
                request.setAttribute("error", "Topic name cannot be empty.");
                Topic topic = topicDao.findTopicById(topicId);
                request.setAttribute("topic", topic);
                request.getRequestDispatcher("/WEB-INF/views/topic-add-edit.jsp")
                       .forward(request, response);
                return;
            }

            Topic topic = new Topic(topicName.trim());
            topic.setId(topicId);
            topicDao.updateTopic(topic);
            response.sendRedirect(request.getContextPath() + "/topic");
        }
        else if ("delete".equals(action)) {
            int topicId = Integer.parseInt(request.getParameter("topicid"));
            topicDao.deleteTopic(topicId);
            response.sendRedirect(request.getContextPath() + "/topic");
        }
    }
}
