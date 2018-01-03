package bean;

import java.util.LinkedList;

public class CommentBean {

    private String username;
    private String myName;
    private String datetime;
    private String content;
    private int countLike;
    private LinkedList<String> urls;

    public CommentBean(String username, String name, String content, String datetime, int countLike) {
        urls = new LinkedList<>();
        setUsername(username);
        setName(name);
        setContent(content);
        setDatetime(datetime);
        setCountLike(countLike);
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return myName;
    }

    public void setName(String name) {
        this.myName = name;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCountLike() {
        return countLike;
    }

    public void setCountLike(int countLike) {
        this.countLike = countLike;
    }


    public LinkedList<String> getUrls() {
        return urls;
    }

    public void setUrls(LinkedList<String> urls) {
        this.urls = urls;
    }

    public void addUrl(String url) {
        getUrls().add(url);
    }
}
