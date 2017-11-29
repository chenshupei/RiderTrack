package dao;

import bean.ActivityBean;
import bean.UserinfoBean;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ActivityDaoImpl implements ActivityDao {
    private DBUtil dbUtil = new DBUtil();
    private Connection connection = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    @Override
    public int addActivity(ActivityBean activityBean) throws Exception {
        int result = 0;
        Connection connection = dbUtil.getConnection();
        String sql1 = "insert into activity_info (activity_name, location, start_date, end_date, description, type, sponsor) values (?, ?, cast(? as date), cast(? as date), ?, ?, ?);" ;
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
}
