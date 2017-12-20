package servlet;

import bean.ActivityBean;
import service.ActivityService;
import service.ActivityServiceImpl;
import service.UserinfoService;
import service.UserinfoServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ShowDetailServlet", urlPatterns = {"/ShowDetailServlet"})
public class ShowDetailServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ActivityBean activityBean = null;
        String idString = request.getParameter("id");
        int id = Integer.parseInt(idString);
        request.setAttribute("activity_id", idString);
        request.getSession().setAttribute("activity_id", idString);
        String username = (String) request.getSession().getAttribute("username");
        boolean register = false;
        ActivityService activityService = new ActivityServiceImpl();
        activityBean = activityService.getActivity(id);
        register = activityService.getRegisterState(username, id);

        request.setAttribute("register", register);

        request.setAttribute("activity_detail_name", activityBean.getActivityName());
        request.setAttribute("activity_detail_location", activityBean.getLocation());
        request.setAttribute("activity_detail_start_date", activityBean.getStartDate());
        request.setAttribute("activity_detail_end_date", activityBean.getEndDate());
        request.setAttribute("activity_detail_description", activityBean.getDescription());
        request.setAttribute("activity_detail_type", activityBean.getType());
        request.setAttribute("activity_detail_sponsor", activityBean.getSponsor());
        request.getRequestDispatcher("details.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
