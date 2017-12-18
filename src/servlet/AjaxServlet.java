package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AjaxServlet", urlPatterns = {"/AjaxServlet"})
public class AjaxServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        System.out.println("ajax servlet");
        //PrintWriter out = response.getWriter();


        String value1 = request.getParameter("v1");
        String value2 = request.getParameter("v2");
        System.out.println(value1);
        System.out.println(value2);
        //out.print(value1 + value2);
        //out.flush();
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();

        String value1 = request.getParameter("v1");
        String value2 = request.getParameter("v2");
        System.out.println(value1);
        System.out.println(value2);
//      out.print(value1 + value2);
        String json = "{" + '"' + "name" + '"' + ":" + '"' + value1 + '"' + "," + '"' + "age" + '"' + ":" + '"' + "20" + '"' + "}";
        out.print(json);
        out.flush();
    }

}