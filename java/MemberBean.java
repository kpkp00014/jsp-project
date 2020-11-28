package project.member;

import java.util.ArrayList;
import java.util.Arrays;

public class MemberBean {
    private String id;
    private String name;
    private ArrayList<Integer> card = new ArrayList<Integer>();
    private Boolean cardDraw = false;

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void reverseDraw() {
        this.cardDraw = !this.cardDraw;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Integer> getCard() {
        return this.card;
    }

    // 2~5 랜덤한 숫자의 카드 생성
    public void newCard() {
        Integer iValue = (int) (Math.random() * 3.5) + (int) (Math.random() * 1.5) + 2;
        this.card.add(iValue);
    }

    // n번째 카드 사용
    public Integer useCard(int n) {
        Integer card = this.card.get(n);
        this.card.remove(n);
        if (cardDraw) {
            newCard();
        }
        reverseDraw();
        return card;
    }

    // 카드를 전부 제거
    public void removeCard() {
        this.card.clear();
    }

    // 보유 카드 수
    public Integer getCardNum() {
        return this.card.size();
    }

    // 보유 카드 목록
    public ArrayList<Integer> getCardList() {
        return this.card;
    }

    // 카드 초기 생성
    public void initCard(int n) {
        removeCard();
        for (int i = 0; i < n; i++) {
            newCard();
        }
    }
}
