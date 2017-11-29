package dao;

import bean.ActivityBean;
import bean.UserinfoBean;

import java.util.List;

public interface ActivityDao {
    int addActivity(ActivityBean activityBean) throws Exception;

    ActivityBean getActivity(int id) throws Exception;

    List<ActivityBean> fetchActivityList() throws Exception;
}
