package project.room;

import java.util.ArrayList;
import java.util.List;

import project.room.RoomBean;

public class RoomManager {
    ArrayList<RoomBean> roomlist = new ArrayList<RoomBean>();

    public void add(RoomBean room) {
        roomlist.add(room);
    }

    public ArrayList<RoomBean> getRoomList() {
        return roomlist;
    }

    public void getR_id(Integer r_id) {
        for (RoomBean rb : roomlist) {
            if (rb.getR_id().equals(r_id))
                roomlist.remove(rb);
        }
    }

    public void remove(RoomBean room) {
        roomlist.remove(room);
        room.finalize();
    }
}
