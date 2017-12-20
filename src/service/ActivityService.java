package service;

import bean.ActivityBean;
import bean.UserinfoBean;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    int addActivity(ActivityBean activityBean);

    ActivityBean getActivity(int id);

    List<ActivityBean> fetchActivityList();

    boolean getRegisterState(String username, int activityID);

    int userJoinActivity(String username, int activityID);

    int userDeregisterActivity(String username, int activityID);

    int checkObserveAvailability(String username, int activityID);

    void setParticipantLocation(String username, int activityID, double x, double y);

    Map<UserinfoBean, Double[][]> getActivityLocations(int activityID);
}
