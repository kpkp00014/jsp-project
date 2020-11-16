package project.room;

import java.util.ArrayList;
import java.util.Arrays;
import project.member.MemberBean;

public class RoomBean {
    // 멤버변수 선언
    private Integer r_id;
    private String r_name;
    private Integer game_num = 0;
    private ArrayList<MemberBean> r_member = new ArrayList<MemberBean>();

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

    public ArrayList<MemberBean> getR_member() {
        return r_member;
    }

    public void add_member(String id, String name) {
        MemberBean member = new MemberBean();
        member.setId(id);
        member.setName(name);
        member.initCard(5);
        this.r_member.add(member);
    }

    public void removeR_member(String id) {
        for (int counter = 0; counter < r_member.size(); counter++) {
            if (this.r_member.get(counter).getId() == id)
                this.r_member.remove(counter);
        }
    }

    public Boolean existR_member(String id) {
        for (int counter = 0; counter < r_member.size(); counter++) {
            if (this.r_member.get(counter).getId() == id)
                return true;
        }
        return false;
    }

    public Integer getR_memberSize() {
        return this.r_member.size();
    }

    public void finalize() {
        System.out.println("destory room");
    }

    public Integer getGame_num() {
        return this.game_num;
    }

    public void initGameNum() {
        this.game_num = 0;
    }

    public void addGameNum(Integer n) {
        this.game_num += n;
    }

    public ArrayList<Integer> getCard(String id) {
        for (int counter = 0; counter < r_member.size(); counter++) {
            if (this.r_member.get(counter).getId() == id) {
                return this.r_member.get(counter).getCardList();
            }
        }
        return null;

    }

    public void useCard(String id, int index) {
        for (int counter = 0; counter < r_member.size(); counter++) {
            if (this.r_member.get(counter).getId() == id) {
                MemberBean mb = this.r_member.get(counter);
                addGameNum(mb.useCard(index));
            }
        }
    }
}