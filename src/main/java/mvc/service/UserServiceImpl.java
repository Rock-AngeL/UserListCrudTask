package mvc.service;

import entity.User;
import mvc.controller.PageStateInfo;
import mvc.controller.UserPage;
import mvc.dao.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Rock-AngeL on 13.11.15.
 */

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDAO userDAO;

    public void create(User user)
    {
        userDAO.create(user);
    }

    public List<User> read() {
        return userDAO.read();
    }

    public User read(long id) {
        return userDAO.read(id);
    }

    public UserPage readPage(PageStateInfo pageStateInfo) {
        return userDAO.readPage(pageStateInfo);
    }

    public void update(User user) {
        userDAO.update(user);
    }

    public Integer delete(long id) {
        return userDAO.delete(id);
    }
}
