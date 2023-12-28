package ma.emsi.travelmanagement.repository;

import ma.emsi.travelmanagement.entities.Role;
import ma.emsi.travelmanagement.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User,Integer> {
    User findUserByUsername(String username);
    Optional<User> findByEmail(String email);
    List<User> findAll();

    List<User> findByRole(Role role);
}
