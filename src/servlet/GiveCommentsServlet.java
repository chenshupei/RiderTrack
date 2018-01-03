package servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import service.ActivityService;
import service.ActivityServiceImpl;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@WebServlet(name = "GiveCommentsServlet", urlPatterns = {"/GiveCommentsServlet"})
public class GiveCommentsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LinkedList<String> urls = new LinkedList<>();
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        String comment = "";

        int activity_id = Integer.parseInt((String) request.getSession().getAttribute("activity_id"));
        String username = (String) request.getSession().getAttribute("username");
        System.out.println("activityID: " + activity_id);
        ActivityService activityService = new ActivityServiceImpl();
        int result = 0;

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload fileUpload = new ServletFileUpload(factory);

        fileUpload.setFileSizeMax(3 * 1024 * 1024);

        try {
            List<FileItem> list = fileUpload.parseRequest(request);
            int count = 0;
            for (FileItem item : list) {
                if (item.isFormField()) {
                    comment = item.getString();
                    continue;
                }
                String path = "D:\\workspace\\TestGit2\\pic\\" + activity_id + username + new SimpleDateFormat("yyyymmddHHmmss").format(new Date()) + count + ".png";
                File file = new File(path);
                urls.add(path);
                item.write(file);
                count++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        result = activityService.addComments(activity_id, username, comment, urls);
        out.print(result);
        out.flush();
    }

}
