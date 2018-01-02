package service;

import bean.ActivityBean;

import java.util.List;

import com.google.gson.Gson;

public interface ActivityService {
    int addActivity(ActivityBean activityBean);

    ActivityBean getActivity(int id);

    List<ActivityBean> fetchActivityList();

    boolean getRegisterState(String username, int activityID);

    int userJoinActivity(String username, int activityID);

    int userDeregisterActivity(String username, int activityID);

    int checkObserveAvailability(String username, int activityID);

    void setParticipantLocation(String username, int activityID, double x, double y);

    String getActivityLocations(int activityID, String lastUpdate);

    int addComments(int activityID, String username, String comments);
}
