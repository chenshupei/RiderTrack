package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UserinfoService;
import service.UserinfoServiceImpl;
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if ((username == null || username.equals("")) && (password == null || password.equals(""))) {
            request.setAttribute("msg_username", "user	name	shouldn't	be	none");
            request.setAttribute("msg_password", "password	shouldn't	be	none");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (password == null || password.equals("")) {
            request.setAttribute("username", username);
            request.setAttribute("msg_password", "password	shouldn't	be	none");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else if (username == null || username.equals("")) {
            request.setAttribute("password", password);
            request.setAttribute("msg_username", "user	name shouldn't be none");

            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            UserinfoService userinfoService = new UserinfoServiceImpl();
            String name = userinfoService.getUserinfo(username).getName();
            int result = userinfoService.login(username, password);
            if (result == 1) {
                request.setAttribute("msg_welcome", "Welcome back, " + username);
                request.setAttribute("msg_username", username);
                request.getSession().setAttribute("username", username);
                request.getSession().setAttribute("name", name);
                request.getRequestDispatcher("home.jsp").forward(request, response);
                request.setAttribute("msg_username", username);
            } else {
                request.setAttribute("msg", "Username or password is wrong. Please try again.");
                request.setAttribute("msg_hide", "show");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            }
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
