package project.room;

import java.util.ArrayList;
import java.util.Arrays;

public class RoomBean {
    // 멤버변수 선언
    private Integer r_id;
    private String r_name;
    private ArrayList<String> r_member = new ArrayList<String>();

    public Integer getR_id() {
        return r_id;
    }

    public void setR_id(int r_id) {
        this.r_id = r_id;
    }

    public String getR_name() {
        return r_name;
    }

    public void setR_name(String r_name) {
        this.r_name = r_name;
    }

    public ArrayList<String> getR_member() {
        return r_member;
    }

    public void addR_member(String r_member) {
        this.r_member.add(r_member);
    }

    public void removeR_member(String r_member) {
        this.r_member.remove(r_member);
    }

    public Boolean existR_member(String r_member) {
        if (this.r_member.contains(r_member))
            return true;
        else
            return false;
    }

    public Integer getR_memberSize() {
        return this.r_member.size();
    }

    public void finalize() {
        System.out.println("destory room");
    }

}