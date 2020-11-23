package project.room;

import java.util.ArrayList;
import java.util.Arrays;
import java.lang.Math;
import project.member.MemberBean;

public class RoomBean {
    // 멤버변수 선언
    private Integer r_id;
    private String r_name;
    private Integer game_num = 0;
    private ArrayList<MemberBean> r_member = new ArrayList<MemberBean>();
    private String current_user = null;
    private Integer current_status = 0;
    private String loser = null;
    // status 0 = game prepare state
    // state 1 = in game state
    // state 2 = game finished state
    // state 3 = abnormal finish state

    public Integer getR_id() {
        return r_id;
    }

    public void setR_id(int r_id) {
        this.r_id = r_id;
    }

    public String getR_name() {
        return r_name;
    }

    public String get_currentUser() {
        return this.current_user;
    }

    public Integer get_currentStatus() {
        return this.current_status;
    }

    public String get_loser() {
        return this.loser;
    }

    public void setR_name(String r_name) {
        this.r_name = r_name;
    }

    public ArrayList<MemberBean> getR_member() {
        return r_member;
    }

    public void add_member(String id, String name) {
        if (this.current_status == 0) {
            MemberBean member = new MemberBean();
            member.setId(id);
            member.setName(name);
            member.initCard(7);
            this.r_member.add(member);
        }
    }

    public void removeR_member(String id) {
        for (int counter = 0; counter < getR_memberSize(); counter++) {
            if (this.r_member.get(counter).getId() == id) {
                if (this.current_status == 1) {
                    // if ingame?
                    this.current_status = 3;
                    this.loser = this.r_member.get(counter).getId();
                }
                this.r_member.remove(counter);

            }

        }
    }

    public Boolean existR_member(String id) {
        for (int counter = 0; counter < getR_memberSize(); counter++) {
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
        this.current_user = null;
        this.current_status = 0;
        this.loser = null;
    }

    public void addGameNum(Integer n) {
        this.game_num += n;
    }

    public ArrayList<Integer> getCard(String id) {
        for (int counter = 0; counter < getR_memberSize(); counter++) {
            if (this.r_member.get(counter).getId() == id) {
                return this.r_member.get(counter).getCardList();
            }
        }
        return null;

    }

    public void useCard(String id, int index) {
        if (this.current_status == 1) {
            for (int counter = 0; counter < getR_memberSize(); counter++) {
                if (this.r_member.get(counter).getId() == id) {
                    MemberBean mb = this.r_member.get(counter);
                    addGameNum(mb.useCard(index));
                }
            }
            score_check();
            next_user();
        }
    }

    public void next_user() {
        // current user id -> get array index
        int index = 0;
        for (int counter = 0; counter < getR_memberSize(); counter++) {
            if (this.r_member.get(counter).getName() == this.current_user) {
                index = counter;
            }
        }
        // next index
        if (index + 1 == getR_memberSize()) {
            this.current_user = this.r_member.get(0).getName();
        } else {
            this.current_user = this.r_member.get(index + 1).getName();
        }
    }

    public void game_start() {
        // 게임이 준비 상태이고, 멤버수가 2인 이상일 때 시작 가능
        if (this.current_status == 0 && getR_memberSize() > 1) {
            // make current state 0 => 1
            this.current_status = 1;

            // set random player to start fisrt
            double randomValue = Math.random();
            int playerIndex = (int) (randomValue * getR_memberSize());

            this.current_user = this.r_member.get(playerIndex).getName();
        }
    }

    public void score_check() {
        // if current num is bigger than 60, game finish
        if (this.game_num >= 60) {
            this.current_status = 2;
            this.loser = this.current_user;
        }
    }
}