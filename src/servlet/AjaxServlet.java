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

@WebServlet(name = "AjaxServlet", urlPatterns = {"/AjaxServlet"})
public class AjaxServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        ActivityService activityService = new ActivityServiceImpl();
        String username = (String) request.getSession().getAttribute("username");
        String activityID = (String) request.getSession().getAttribute("activity_id");

        String x = request.getParameter("v1");
        String y = request.getParameter("v2");

        activityService.setParticipantLocation(username, Integer.parseInt(activityID), Double.parseDouble(x), Double.parseDouble(y));

        System.out.println(username);
        System.out.println(activityID);
        System.out.println(x);
        System.out.println(y);

    }

}