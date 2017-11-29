package service;

import bean.ActivityBean;

import java.util.List;

public interface ActivityService {
    int addActivity(ActivityBean activityBean);

    ActivityBean getActivity(int id);

    List<ActivityBean> fetchActivityList();
}
