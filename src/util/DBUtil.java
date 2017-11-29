package util;
import java.sql.*;

public class DBUtil {

    public Connection getConnection() throws Exception {
        Connection connection = null;
        String driverClass = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/ridertrack";
        String name = "root";
        String password = "123456";
        Class.forName(driverClass);
        connection = DriverManager.getConnection(url, name, password);
        return connection;
    }

    public void closeDBResource(Connection connection, PreparedStatement preparedStatement, ResultSet resultSet) throws Exception {
        if (resultSet != null) {
            try {
                resultSet.close();
            }finally {
                resultSet = null;
            }
        }
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            }finally {
                preparedStatement = null;
            }
        }
        if (connection != null) {
            try {
                connection.close();
            }finally {
                connection = null;
            }
        }
    }

    public void closeDBResource(Connection connection, PreparedStatement preparedStatement) throws SQLException {
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            }finally {
                preparedStatement = null;
            }
        }
        if (connection != null) {
            try {
                connection.close();
            }finally {
                connection = null;
            }
        }
    }
}
