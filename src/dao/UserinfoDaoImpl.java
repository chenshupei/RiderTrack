package dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import bean.UserinfoBean;
import util.DBUtil;

public class UserinfoDaoImpl implements UserinfoDao{
    private DBUtil dbUtil = new DBUtil();


    @Override
    public int login(String username, String password) throws Exception {
        int result = 0;
        String sql = "select count(*) from user_info where user_name = ? and password=?";
        Connection connection = dbUtil.getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result = resultSet.getInt(1);
        }
        dbUtil.closeDBResource(connection, preparedStatement, resultSet);

        return result;
    }

    @Override
    public int registerUserinfo(UserinfoBean userinfoBean) throws Exception {
        int result = 0;
        Connection connection = dbUtil.getConnection();
        String sql = "insert into user_info (user_name, name, password) values(?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, userinfoBean.getUsername());
        preparedStatement.setString(2, userinfoBean.getName());
        preparedStatement.setString(3, userinfoBean.getPassword());
        result = preparedStatement.executeUpdate();
        dbUtil.closeDBResource(connection, preparedStatement);
        return result;
    }

    @Override
    public UserinfoBean getUserinfo(String username) throws Exception {
        Connection connection = dbUtil.getConnection();
        UserinfoBean userinfoBean = new UserinfoBean();
        String sql = "select * from user_info where user_name = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            userinfoBean.setUsername(resultSet.getString("user_name"));
            userinfoBean.setPassword(resultSet.getString("password"));
            userinfoBean.setEmail(resultSet.getString("email_address"));
            userinfoBean.setName(resultSet.getString("name"));
        }
        return userinfoBean;
    }
}
