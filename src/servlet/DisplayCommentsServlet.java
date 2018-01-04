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

@WebServlet(name = "DisplayCommentsServlet", urlPatterns = {"/DisplayCommentsServlet"})
public class DisplayCommentsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        System.out.println("In DisplayCommentsServlet!");
        ActivityService activityService = new ActivityServiceImpl();
        String json = activityService.getComments(Integer.parseInt((String)request.getSession().getAttribute("activity_id")));
        System.out.println(json);
        out.print(json);
        out.flush();
    }
}
