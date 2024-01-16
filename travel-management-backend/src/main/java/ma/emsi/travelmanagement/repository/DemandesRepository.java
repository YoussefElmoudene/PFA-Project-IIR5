package ma.emsi.travelmanagement.repository;

import ma.emsi.travelmanagement.entities.Demande;
import ma.emsi.travelmanagement.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DemandesRepository extends JpaRepository<Demande, Integer> {
    List<Demande> findByDemandeur(User user);


    List<Demande> findByEtat(String etat);

    List<Demande> findByDemandeurAndEtat(User user, String etat);
}
