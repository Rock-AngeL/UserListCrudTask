package mvc.dao;

import entity.User;
import mvc.controller.PageStateInfo;
import mvc.controller.UserPage;

import java.util.List;

/**
 * Created by Rock-AngeL on 13.11.15.
 */
public interface UserDAO {
    void create(User user);
    List read();
    User read(long id);
    UserPage readPage(PageStateInfo pageStateInfo);
    void update(User user);
    Integer delete(long id);
}
