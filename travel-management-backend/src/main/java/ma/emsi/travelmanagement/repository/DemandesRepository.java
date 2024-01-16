package ma.emsi.travelmanagement.repository;

import ma.emsi.travelmanagement.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ma.emsi.travelmanagement.entities.Demande;

import java.util.List;
import java.util.Optional;

@Repository
public interface DemandesRepository extends JpaRepository<Demande, Integer> {
    List<Demande> findByDemandeur(User user);
}
