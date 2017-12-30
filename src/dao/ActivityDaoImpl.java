package dao;

import bean.ActivityBean;
import bean.UserPosition;
import bean.UserinfoBean;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        System.out.println("dao: " + result);
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

        System.out.println("In dao");

        connection = dbUtil.getConnection();
        String sql = "SELECT u.user_name, u.email_address, u.name, x, y FROM location l JOIN user_info u ON l.user_name = u.user_name WHERE activity_id = ? ";
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
}
