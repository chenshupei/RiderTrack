package service;

import bean.ActivityBean;
import dao.ActivityDao;
import dao.ActivityDaoImpl;

import java.util.List;

public class ActivityServiceImpl implements ActivityService {

    ActivityDao activityDao = new ActivityDaoImpl();

    @Override
    public int addActivity(ActivityBean activityBean){
        int result = 0;
        try {
            result = activityDao.addActivity(activityBean);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public ActivityBean getActivity(int id) {
        ActivityBean activity = null;
        try {
            activity = activityDao.getActivity(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activity;
    }

    @Override
    public List<ActivityBean> fetchActivityList() {
        List<ActivityBean> activityList = null;
        try {
            activityList = activityDao.fetchActivityList();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return activityList;
    }
}
