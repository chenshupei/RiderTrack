package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "GiveCommentsServlet", urlPatterns = {"/GiveCommentsServlet"})
public class GiveCommentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int activity_id = Integer.parseInt((String) request.getSession().getAttribute("activity_id"));
        String username = (String) request.getSession().getAttribute("username");
        String comment = request.getParameter("comments");
        System.out.println(activity_id);
        System.out.println(username);
        System.out.println(comment);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
