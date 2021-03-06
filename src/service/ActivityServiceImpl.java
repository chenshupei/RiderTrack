package service;

import bean.ActivityBean;
import bean.CommentBean;
import bean.UserPosition;
import bean.UserinfoBean;
import com.google.gson.Gson;
import dao.ActivityDao;
import dao.ActivityDaoImpl;


import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {

    private ActivityDao activityDao = new ActivityDaoImpl();

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

    @Override
    public boolean getRegisterState(String username, int activityID) {
        boolean state = false;
        try {
            state = activityDao.getRegisterState(username, activityID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return state;
    }

    @Override
    public int userJoinActivity(String username, int activityID) {
        int result = 0;
        try {
            result = activityDao.userJoinActivity(username, activityID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("service: " + result);
        return result;
    }

    @Override
    public int userDeregisterActivity(String username, int activityID) {
        int result = 0;
        try {
            result = activityDao.userDeregisterActivity(username, activityID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public int checkObserveAvailability(String username, int activityID) {
        int result = 0;
        try {
            result = activityDao.checkObserveAvailability(username, activityID);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public void setParticipantLocation(String username, int activityID, double x, double y) {
        try {
            activityDao.setParticipantLocation(username, activityID, x, y);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getActivityLocations(int activityID, String lastUpdate) {
        Gson gson = new Gson();
        Map<String, UserPosition> map;
        String json = "";
        try {
            map = activityDao.getActivityLocations(activityID, lastUpdate);
            json = gson.toJson(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public int addComments(int activityID, String username, String comments, LinkedList<String> urls) {
        int result = 0;
        try {
            result = activityDao.addComments(activityID, username, comments, urls);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public String getComments(int activityID) {
        String json = "";
        LinkedList<CommentBean> commentBeans;
        try {
            commentBeans = activityDao.getComments(activityID);
            Gson gson = new Gson();
            json = gson.toJson(commentBeans);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }
}
