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

@WebServlet(name = "ObserveServlet", urlPatterns = {"/ObserveServlet"})
public class ObserveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String activityID = request.getParameter("activity_id");
        ActivityService activityService = new ActivityServiceImpl();
        int result = activityService.checkObserveAvailability(username, Integer.parseInt(activityID));

        System.out.println(result);

        out.print(result);
        out.flush();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
