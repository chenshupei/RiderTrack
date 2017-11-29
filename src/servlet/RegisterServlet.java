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
import java.io.UnsupportedEncodingException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    public RegisterServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String username = "";
        String name = "";
        String password = "";
        String conPassword = "";
        username = request.getParameter("username");
        name = request.getParameter("name");
        password = request.getParameter("password");
        conPassword = request.getParameter("con_password");
        if((username == null||username.equals(""))&&(password==null||password.equals(""))){
            request.setAttribute("msg_username", "user name shouldn't be none");
            request.setAttribute("msg_password", "password shouldn't be none");
            request.getRequestDispatcher("login3.jsp").forward(request, response);
            System.out.println(1);
        }else if(username==null||username.equals("")){
            request.setAttribute("password", password);
            request.setAttribute("msg_username", "user name shouldn't be none");
            request.getRequestDispatcher("login3.jsp").forward(request, response);
            System.out.println(2);
        }else if(password==null||password.equals("")){
            request.setAttribute("username", username);
            request.setAttribute("msg_password", "password shouldn't be none");
            request.getRequestDispatcher("login3.jsp").forward(request, response);
            System.out.println(3);
        }else{
            if(conPassword==""||conPassword.equals("")){
                request.setAttribute("username", username);
                request.setAttribute("password", password);
                request.setAttribute("msg_con_password", "Please confirm password");
                request.getRequestDispatcher("login3.jsp").forward(request, response);
                System.out.println(4);
            }else{

                if(!conPassword.equals(password)){
                    request.setAttribute("password", password);
                    request.setAttribute("username", username);
                    request.setAttribute("msg", "Two password is not same");
                    request.setAttribute("con_password", "");
                    request.setAttribute("msg_hide", "show");
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }else{
                    System.out.println("Success");
                    UserinfoService userinfoService=new UserinfoServiceImpl();
                    UserinfoBean userinfoBean=new UserinfoBean();
                    userinfoBean.setUsername(username);
                    userinfoBean.setName(name);
                    userinfoBean.setPassword(password);
                    request.setAttribute("msg_hide", "show");
                    int result=userinfoService.registerUserinfo(userinfoBean);
                    System.out.println("In servlet"+result);
                    if(result==1){
                        request.setAttribute("msg", "Register is success, please login to the system");
                        request.setAttribute("username", username);
                        request.getRequestDispatcher("home.jsp").forward(request, response);
//                        response.sendRedirect("home.jsp");
                    }else{
                        request.setAttribute("msg", "Register is failed");
                        request.setAttribute("msg_hide", "show");
                        request.getRequestDispatcher("home.jsp").forward(request, response);
                    }

                }
            }
        }

    }

}
