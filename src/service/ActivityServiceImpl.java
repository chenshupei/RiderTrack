package service;

import bean.ActivityBean;
import bean.UserPosition;
import bean.UserinfoBean;
import com.google.gson.Gson;
import dao.ActivityDao;
import dao.ActivityDaoImpl;


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

//    public static void main(String[] args) {
//        ActivityDao activityDao = new ActivityDaoImpl();
//        System.out.println("In service");
//        System.out.println("After gson init");
//        Map<String, UserPosition> map;
//        System.out.println("After map init");
//        String json = "";
//        try {
//            System.out.println("In service try block");
//            map = activityDao.getActivityLocations(35);
//            Gson gson = new Gson();
//            for (UserPosition userPosition : map.values()) {
//                json = gson.toJson(userPosition);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        System.out.println("Activity service");
//        System.out.println(json);
//
//    }
}
