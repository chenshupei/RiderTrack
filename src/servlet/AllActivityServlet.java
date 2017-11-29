package servlet;

import bean.ActivityBean;
import service.ActivityService;
import service.ActivityServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "AllActivityServlet", urlPatterns = {"/AllActivityServlet"})
public class AllActivityServlet extends HttpServlet{
    private static final long serialVersionUID = 1L;

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ActivityServlet doGet()");
        ActivityService activityService = new ActivityServiceImpl();
        List<ActivityBean> activityList = activityService.fetchActivityList();
        request.setAttribute("activityList", activityList);
        request.getRequestDispatcher("allActivity.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}



