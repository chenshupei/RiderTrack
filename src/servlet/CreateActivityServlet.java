package servlet;

import bean.ActivityBean;
import com.sun.deploy.net.HttpRequest;
import com.sun.deploy.net.HttpResponse;
import dao.ActivityDao;
import dao.ActivityDaoImpl;
import service.ActivityService;
import service.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CreateActivityServlet", urlPatterns = {"/CreateActivityServlet"})
public class CreateActivityServlet extends HttpServlet {

    public CreateActivityServlet() {
        super();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String activityName = "";
        String location = "";
        String startDate = "";
        String endDate = "";
        String description = "";
        String type = "";
        String sponsor = "";

        boolean success = false;

        activityName = request.getParameter("activityName");
        location = request.getParameter("location");
        startDate = request.getParameter("startDate");
        endDate = request.getParameter("endDate");
        description = request.getParameter("description");
        type = request.getParameter("type");
        sponsor = (String) request.getSession().getAttribute("username");

        if (sponsor == null || sponsor == "") {
            request.setAttribute("msg_submit", "Please log in first.");
            request.getRequestDispatcher("createActivity.jsp").forward(request, response);
        }

        if (activityName == null || activityName.equals("")) {
            request.setAttribute("msg_activityName", "Activity name should not be empty.");
        }

        if (location == null || location.equals("")) {
            request.setAttribute("msg_location", "Location should not be empty.");
        }

        if (startDate == null || startDate.equals("")) {
            request.setAttribute("msg_startDate", "You need to specify the start date.");
        }

        if (endDate == null || endDate.equals("")) {
            request.setAttribute("msg_endDate", "You need to specify the end date.");
        } else {
            success = true;
        }

        if (success) {
            ActivityService activityService = new ActivityServiceImpl();
            ActivityBean activityBean = new ActivityBean();
            activityBean.setActivityName(activityName);
            activityBean.setLocation(location);
            activityBean.setStartDate(startDate);
            activityBean.setEndDate(endDate);
            activityBean.setDescription(description);
            activityBean.setType(type);
            activityBean.setSponsor(sponsor);
            int result = activityService.addActivity(activityBean);
            if (result == 1) {
                System.out.println("success");
                response.sendRedirect("createSuccess.jsp");
            } else {
                System.out.println("failed");
                request.setAttribute("msg_submit", "Create activity failed.");
                request.getRequestDispatcher("createActivity.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("createActivity.jsp").forward(request, response);
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
