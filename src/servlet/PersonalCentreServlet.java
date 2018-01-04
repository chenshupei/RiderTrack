package servlet;

import bean.UserinfoBean;
import service.UserinfoService;
import service.UserinfoServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "PersonalCentreServlet", urlPatterns = {"/PersonalCentreServlet"})
public class PersonalCentreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PersonalCentreServlet() {
        super();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = (String)request.getSession().getAttribute("username");
        System.out.println(userName);
        UserinfoService userinfoService = new UserinfoServiceImpl();
        UserinfoBean userinfoBean = userinfoService.getUserinfo(userName);
        System.out.println(userinfoBean.getEmail());
        request.setAttribute("name", userinfoBean.getName());
        request.setAttribute("email_address", userinfoBean.getEmail());
        request.getRequestDispatcher("personalCentre.jsp").forward(request, response);
    }
}
