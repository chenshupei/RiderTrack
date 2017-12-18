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

@WebServlet(name = "DeregisterServlet", urlPatterns = {"/DeregisterServlet"})
public class DeregisterServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        System.out.println("Enter DeregisterServlet");
        System.out.println("join deregister servlet");
        String activityID = request.getParameter("activity_id");
        String username = request.getParameter("username");

        ActivityService activityService = new ActivityServiceImpl();
        int result = activityService.userDeregisterActivity(username, Integer.parseInt(activityID));
        out.print(result);
        out.flush();
    }
}
