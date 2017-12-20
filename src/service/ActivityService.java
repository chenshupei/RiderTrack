package service;

import bean.ActivityBean;

import java.util.List;

public interface ActivityService {
    int addActivity(ActivityBean activityBean);

    ActivityBean getActivity(int id);

    List<ActivityBean> fetchActivityList();

    boolean getRegisterState(String username, int activityID);

    int userJoinActivity(String username, int activityID);

    int userDeregisterActivity(String username, int activityID);

    int checkObserveAvailability(String username, int activityID);

    int setParticipantLocation(String username, int activityID, double x, double y);
}
