package ma.emsi.travelmanagement.services;

import ma.emsi.travelmanagement.entities.Role;
import ma.emsi.travelmanagement.entities.User;
import ma.emsi.travelmanagement.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userDao;

    public List<User> findAll() {
        return userDao.findAll();
    }

    public User save(User user) {
        return userDao.save(user);
    }

    public Optional<User> findById(Integer id) {
        return userDao.findById(id);
    }

    @Transactional
    public void deleteById(Integer id) {
        userDao.deleteById(id);
    }

    public User findUserByUsername(String username) {
        return userDao.findUserByUsername(username);
    }

    public Optional<User> findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    public List<User> findByRole(Role role) {
        return userDao.findByRole(role);
    }

    public void updateUser(int id,User userInfo) {
        User user=userDao.findById(id).orElseThrow(() -> new IllegalArgumentException("app not found with id " + id));
        user.setFirstName(userInfo.getFirstName());
        user.setLastName(userInfo.getLastName());
        user.setTel(userInfo.getTel());
        userDao.save(user);
    }
}