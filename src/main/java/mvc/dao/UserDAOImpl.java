package mvc.dao;

import entity.User;
import mvc.controller.PageStateInfo;
import mvc.controller.UserPage;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

/**
 * Created by Rock-AngeL on 13.11.15.
 */

@Repository
@SuppressWarnings("unchecked")
public class UserDAOImpl implements UserDAO {
    @Autowired
    private SessionFactory sessionFactory;

    public void create(User user) {
        Session session = sessionFactory.getCurrentSession();
        user.setCreatedDate(Timestamp.valueOf(LocalDateTime.now()));
        Serializable id = session.save(user);
        session.flush();
    }

    public List<User> read() {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("SELECT u FROM User u");
        return (List<User>) query.list();
    }

    public User read(long id) {
        Session session = sessionFactory.getCurrentSession();
        User user = (User) session.get(User.class, id);
        return user;
    }

    public UserPage readPage(PageStateInfo pageStateInfo) {
        int rowsPerPage = pageStateInfo.getRowsPerPage();
        int start = (pageStateInfo.getPageNumber() - 1) * rowsPerPage;
        UserPage userPage = new UserPage();
        Session session = sessionFactory.getCurrentSession();
        String fld = pageStateInfo.getOrderField();
        fld = fld.isEmpty() ? "id" : fld;
        String fltFld = pageStateInfo.getFilterField();
        String fltFldVal = pageStateInfo.getFilterFieldValue();
        Query query;
        StringBuilder where = new StringBuilder("");
        String desc = pageStateInfo.isOrderFieldDesc() ? " DESC " : "";
        if (fltFld.isEmpty() || fltFldVal.isEmpty()) {
            where.append("id=id");
            query = session.createQuery("SELECT u FROM User u WHERE " + where.toString() + " ORDER BY " + fld + desc);
        } else {
            String like = "=";
            String likePref = "'";
            String likeSuf = "'";
            if (!pageStateInfo.isStrictFilter()) {
                like = " LIKE ";
                likePref = " '%";
                likeSuf = "%' ";
            }
            if ("wide-search".equals(fltFld)) {
                Field[] fields = User.class.getDeclaredFields();
                where = where.append(fields[0].getName()).append(like).append(likePref).append(fltFldVal).append(likeSuf);
                for (int i = 1; i < fields.length; i++) {
                    where.append(" OR ").append(fields[i].getName()).append(like).append(likePref).append(fltFldVal).append(likeSuf);
                }
            } else {
                where = new StringBuilder(fltFld + like + likePref + fltFldVal + likeSuf);
            }
            query = session.createQuery("SELECT u FROM User u WHERE " + where.toString() + " ORDER BY " + fld + desc);
        }
        query.setFirstResult(start);
        query.setMaxResults(rowsPerPage);
        //
        //query.setParameter("fld", fld.isEmpty() ? "id" : fld);
        userPage.setPageList((List<User>) query.list());
        //
        query = session.createQuery("SELECT COUNT(u) FROM User u WHERE " + where.toString());
        userPage.setPagesCount((int) ((Long) query.uniqueResult() + (rowsPerPage - 1)) / rowsPerPage);
        return userPage;
    }

    public void update(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.update(user);
        session.flush();
    }

    public Integer delete(long id) {
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery("DELETE User WHERE id = :id");
        query.setParameter("id", id);
        return query.executeUpdate();
    }
}
