package dao;

import bean.ActivityBean;
import bean.CommentBean;
import bean.UserPosition;
import bean.UserinfoBean;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

public class ActivityDaoImpl implements ActivityDao {
    private DBUtil dbUtil = new DBUtil();
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    @Override
    public int addActivity(ActivityBean activityBean) throws Exception {
        int result = 0;
        Connection connection = dbUtil.getConnection();
        String sql1 = "insert into activity_info (activity_name, location, start_date, end_date, description, type, sponsor) values (?, ?, cast(? as date), cast(? as date), ?, ?, ?);";
        PreparedStatement preparedStatement = connection.prepareStatement(sql1);
        preparedStatement.setString(1, activityBean.getActivityName());
        preparedStatement.setString(2, activityBean.getLocation());
        preparedStatement.setString(3, activityBean.getStartDate());
        preparedStatement.setString(4, activityBean.getEndDate());
        preparedStatement.setString(5, activityBean.getDescription());
        preparedStatement.setString(6, activityBean.getType());
        preparedStatement.setString(7, activityBean.getSponsor());

        result = preparedStatement.executeUpdate();
        dbUtil.closeDBResource(connection, preparedStatement);
        return result;
    }

    @Override
    public ActivityBean getActivity(int id) throws Exception {
        connection = dbUtil.getConnection();
        ActivityBean activityBean = null;
        String sql = "select * from activity_info where id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, id);
        resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            activityBean = new ActivityBean();
            activityBean.setId(id);
            activityBean.setLocation(resultSet.getString("location"));
            activityBean.setSponsor(resultSet.getString("sponsor"));
            activityBean.setDescription(resultSet.getString("description"));
            activityBean.setType(resultSet.getString("type"));
            activityBean.setStartDate(resultSet.getString("start_date"));
            activityBean.setEndDate(resultSet.getString("end_date"));
            activityBean.setActivityName(resultSet.getString("activity_name"));
        }
        dbUtil.closeDBResource(connection, preparedStatement, resultSet);
        return activityBean;
    }


    @Override
    public List<ActivityBean> fetchActivityList() throws Exception {
        List<ActivityBean> activityBeanList = null;
        connection = dbUtil.getConnection();
        String sql = "select * from activity_info";
//        System.out.println("sql testing");
        preparedStatement = connection.prepareStatement(sql);
        resultSet = preparedStatement.executeQuery();
        activityBeanList = new ArrayList<ActivityBean>();
        while (resultSet.next()) {
//            System.out.println("sql success");
            ActivityBean activityBean = new ActivityBean();
            activityBean.setId(resultSet.getInt("id"));
            activityBean.setLocation(resultSet.getString("location"));
            activityBean.setSponsor(resultSet.getString("sponsor"));
            activityBean.setDescription(resultSet.getString("description"));
            activityBean.setType(resultSet.getString("type"));
            activityBean.setStartDate(resultSet.getString("start_date"));
            activityBean.setEndDate(resultSet.getString("end_date"));
            activityBean.setActivityName(resultSet.getString("activity_name"));
            activityBeanList.add(activityBean);
        }
        dbUtil.closeDBResource(connection, preparedStatement, resultSet);
        return activityBeanList;
    }

    @Override
    public boolean getRegisterState(String username, int activityID) throws Exception {
        boolean state = false;
        connection = dbUtil.getConnection();
        String sql = "select * from user_in_activity where user_name = ? and activity_id = ? and credits = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setInt(2, activityID);
        preparedStatement.setString(3, "P");
        resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            state = true;
        }
        dbUtil.closeDBResource(connection, preparedStatement, resultSet);
        return state;
    }

    @Override
    public int userJoinActivity(String username, int activityID) throws Exception {
        int result = 0;
        connection = dbUtil.getConnection();
        String sql = "insert into user_in_activity (user_name, activity_id, credits) values (?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setInt(2, activityID);
        preparedStatement.setString(3, "P");

        result = preparedStatement.executeUpdate();
        dbUtil.closeDBResource(connection, preparedStatement);
        return result;
    }

    @Override
    public int userDeregisterActivity(String username, int activityID) throws Exception {
        int result = 0;
        connection = dbUtil.getConnection();
        String sql = "delete from user_in_activity where user_name = ? and activity_id = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setInt(2, activityID);

        result = preparedStatement.executeUpdate();
        dbUtil.closeDBResource(connection, preparedStatement);
        return result;
    }

    @Override
    public int checkObserveAvailability(String username, int activityID) throws Exception {
        int result = 0;
        String participant;
        connection = dbUtil.getConnection();
        String sql = "SELECT CASE WHEN user_name IS NULL THEN 'no' ELSE user_name END AS participant FROM activity_info act LEFT JOIN (SELECT * FROM user_in_activity WHERE user_name = ?) uia ON act.id = uia.activity_id WHERE id = ? AND current_date > act.start_date AND current_date < act.end_date";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setInt(2, activityID);
        resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            result = 1;
            participant = resultSet.getString("participant");
            if (!participant.equals("no"))
                result = 2;
        }
        dbUtil.closeDBResource(connection, preparedStatement);
        return result;
    }

    @Override
    public int setParticipantLocation(String username, int activityID, double x, double y) throws Exception {
        int result;
        connection = dbUtil.getConnection();
        String sql = "insert into location (activity_id, user_name, x, y, date_time) values (?, ?, ?, ?, CURRENT_TIMESTAMP )";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, activityID);
        preparedStatement.setString(2, username);
        preparedStatement.setDouble(3, x);
        preparedStatement.setDouble(4, y);

        result = preparedStatement.executeUpdate();
        dbUtil.closeDBResource(connection, preparedStatement);
        return result;
    }

    @Override
    public Map<String, UserPosition> getActivityLocations(int activityID, String lastUpdate) throws Exception {
        Map<String, UserPosition> map = new HashMap<>();
        String sql;
        connection = dbUtil.getConnection();
        if (!lastUpdate.equals("1000-00-00 00:00:00")) {
            sql = "SELECT u.user_name, email_address, name, l1.x, l1.y FROM location l1 LEFT JOIN location l2 ON l1.user_name = l2.user_name AND l1.date_time < l2.date_time JOIN user_info u ON l1.user_name = u.user_name WHERE l1.activity_id = ? GROUP BY l1.user_name, l1.date_time HAVING count(l2.date_time) < 2 ORDER BY l1.date_time";
        } else {
            sql = "SELECT l.user_name, email_address, name, x, y FROM location l JOIN user_info u ON l.user_name = u.user_name WHERE activity_id = ?";
        }
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, activityID);
//        preparedStatement.setString(2, lastUpdate);
        resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            String userName = resultSet.getString("user_name");
            if (map.get(userName) != null) {
                map.get(userName).addPosition(resultSet.getDouble("x"), resultSet.getDouble("y"));
            } else {
                UserPosition userPosition = new UserPosition();
                userPosition.setUsername(userName);
                userPosition.setEmail(resultSet.getString("email_address"));
                userPosition.setName(resultSet.getString("name"));
                userPosition.addPosition(resultSet.getDouble("x"), resultSet.getDouble("y"));
                map.put(userName, userPosition);
            }
        }
        return map;
    }

    @Override
    public int addComments(int activityID, String username, String comments, LinkedList<String> urls) throws Exception {
        connection = dbUtil.getConnection();
        String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        String sql = "INSERT INTO updates (user_name, activity_id, content, date_time) VALUES (?, ?, ?, ? )";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setInt(2, activityID);
        preparedStatement.setString(3, comments);
        preparedStatement.setString(4, timeStamp);
        int result = preparedStatement.executeUpdate();
        if (urls.size() == 0) {
            return result;
        }
        String sql2 = "SELECT update_id FROM updates WHERE user_name = ? AND activity_id = ? AND date_time = ?";
        preparedStatement = connection.prepareStatement(sql2);
        preparedStatement.setString(1, username);
        preparedStatement.setInt(2, activityID);
        preparedStatement.setString(3, timeStamp);
        resultSet = preparedStatement.executeQuery();
        int updateID = -1;
        while (resultSet.next()) {
            updateID = resultSet.getInt("update_id");
        }
        String sql3;
        for (String url : urls) {
            sql3 = "INSERT INTO photos_in_update (update_id, photo_url) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(sql3);
            preparedStatement.setInt(1, updateID);
            preparedStatement.setString(2, url);
            result *= preparedStatement.executeUpdate();
        }
        return result;
    }

    @Override
    public LinkedList<CommentBean> getComments(int activityID) throws Exception {
        LinkedList<CommentBean> commentBeans = new LinkedList<>();
        connection = dbUtil.getConnection();
        String sql = "SELECT\n" +
                "  usr.user_name,\n" +
                "  usr.name,\n" +
                "  content,\n" +
                "  CASE\n" +
                "  WHEN date_add(date_time, INTERVAL 1 MINUTE) > current_timestamp\n" +
                "    THEN 'Just now'\n" +
                "  WHEN date_add(date_time, INTERVAL 3 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 2 MINUTE)\n" +
                "    THEN '1 minute ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 4 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 3 MINUTE)\n" +
                "    THEN '2 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 5 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 4 MINUTE)\n" +
                "    THEN '3 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 6 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 5 MINUTE)\n" +
                "    THEN '4 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 7 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 6 MINUTE)\n" +
                "    THEN '5 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 8 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 7 MINUTE)\n" +
                "    THEN '6 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 9 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 8 MINUTE)\n" +
                "    THEN '7 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 12 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 9 MINUTE)\n" +
                "    THEN '10 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 17 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 12 MINUTE)\n" +
                "    THEN '15 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 25 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 17 MINUTE)\n" +
                "    THEN '20 minutes ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 40 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 25 MINUTE)\n" +
                "    THEN 'Half hour ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 70 MINUTE) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 40 MINUTE)\n" +
                "    THEN '1 hour ago'\n" +
                "  WHEN date_add(date_time, INTERVAL 24 HOUR) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 70 MINUTE)\n" +
                "    THEN DATE_FORMAT(date_time, '%H:%i')\n" +
                "  WHEN date_add(date_time, INTERVAL 12 MONTH) > current_timestamp AND current_timestamp > date_add(date_time, INTERVAL 24 HOUR)\n" +
                "    THEN DATE_FORMAT(date_time, '%m-%d')\n" +
                "  ELSE date_format(date_time, '%y')\n" +
                "  END as that_time,\n" +
                "  cnt_like\n" +
                "FROM updates upd\n" +
                "  JOIN user_info usr ON upd.user_name = usr.user_name\n" +
                "WHERE activity_id = ?\n" +
                "ORDER BY date_time DESC";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, activityID);
        resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            commentBeans.add(new CommentBean(resultSet.getString("user_name"),
                    resultSet.getString("name"),
                    resultSet.getString("content"),
                    resultSet.getString("that_time"),
                    resultSet.getInt("cnt_like")));
        }
        return commentBeans;
    }
}
