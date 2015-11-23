package mvc.controller;

import entity.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Created by Rock-AngeL on 13.11.15.
 */
@Component
public class UserValidator implements Validator {
    public boolean supports(Class<?> aClass) {
        return true;
    }

    public void validate(Object o, Errors errors) {
        User user = (User)o;
        if (user.getName().length()<3){ //минимальное кол-во символов - 3
            errors.reject("name_err", "1");
        }
        if (user.getName().length()>25){ //max кол-во символов - 25
            errors.reject("name_err", "2");
        }
        if (user.getAge()<5){ //мин возраст
            errors.reject("age_err", "1");
        }
        if (user.getAge()>100){ //max возраст
            errors.reject("age_err", "2");
        }
    }
}
