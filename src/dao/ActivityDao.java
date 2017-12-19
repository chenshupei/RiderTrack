package dao;

import bean.ActivityBean;
import bean.UserinfoBean;

import java.util.List;

public interface ActivityDao {
    int addActivity(ActivityBean activityBean) throws Exception;

    ActivityBean getActivity(int id) throws Exception;

    List<ActivityBean> fetchActivityList() throws Exception;

    boolean getRegisterState(String username, int activityID) throws Exception;

    int userJoinActivity(String username, int activityID) throws Exception;

    int userDeregisterActivity(String username, int activityID) throws Exception;

    int checkObserveAvailability(String username, int activityID) throws Exception;
}
