package ma.emsi.travelmanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ma.emsi.travelmanagement.entities.Demandes;

@Repository
public interface DemandesRepository extends JpaRepository<Demandes, Integer> {

}
