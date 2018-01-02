package servlet;

import service.ActivityService;
import service.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "GiveCommentsServlet", urlPatterns = {"/GiveCommentsServlet"})
public class GiveCommentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        int activity_id = Integer.parseInt((String) request.getSession().getAttribute("activity_id"));
        String username = (String) request.getSession().getAttribute("username");
        String comment = request.getParameter("comment");
        System.out.println("comment:" + comment);

        ActivityService activityService = new ActivityServiceImpl();
        int result = activityService.addComments(activity_id, username, comment);
        out.print(result);
        out.flush();
    }

}
