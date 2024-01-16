package ma.emsi.travelmanagement.services;

import jakarta.persistence.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;
import ma.emsi.travelmanagement.entities.Demande;
import ma.emsi.travelmanagement.entities.User;
import ma.emsi.travelmanagement.repository.DemandesRepository;
import ma.emsi.travelmanagement.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class DemandesService {

    @Autowired
    private DemandesRepository demandesRepository;
    @Autowired
    private UserRepository userRepository;

    public List<Demande> getAllDemandes() {
        return demandesRepository.findAll();
    }

    public Optional<Demande> getDemandesById(int id) {
        return demandesRepository.findById(id);
    }

    public Demande createDemandes(Demande demandes) {
        log.info("demande {}",demandes.toString());
        Optional<User> user = userRepository.findById(demandes.getDemandeur().getId());
        log.info("user id {} toString {}",user.get().getId(),user.toString());
        if (user.isPresent()) {
            demandes.setDemandeur(user.get());
        } else {
            throw new RuntimeException("Your account not found.");
        }
        return demandesRepository.save(demandes);
    }

    public List<Demande> getDemandesByUser(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            return demandesRepository.findByDemandeur(user.get());
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "user not found");
        }
    }

    public Demande updateDemandes(int id, Demande updatedDemandes) {
        if (id > 0 && updatedDemandes != null) {
            Optional<Demande> existingDemandes = demandesRepository.findById(id);
            if (existingDemandes.isPresent()) {
                Demande currentDemandes = existingDemandes.get();
             
                currentDemandes.setMotif(updatedDemandes.getMotif());
                currentDemandes.setVille(updatedDemandes.getVille());
                currentDemandes.setEtat(updatedDemandes.getEtat());
                currentDemandes.setFrais(updatedDemandes.getFrais());
                currentDemandes.setDateDebut(updatedDemandes.getDateDebut());
                currentDemandes.setDateFin(updatedDemandes.getDateFin());
                currentDemandes.setDemandeur(updatedDemandes.getDemandeur());
                currentDemandes.setMoyenTransport(updatedDemandes.getMoyenTransport());
               
                return demandesRepository.save(currentDemandes);
            }
        }
        return null;
    }


    public void deleteDemandes(int id) {
        demandesRepository.deleteById(id);
    }

    public List<Demande> filterUserDemandesByEtat(User user,String etat) {
            log.info("user {} with etat {}",user.toString(),etat);
        return demandesRepository.findByDemandeurAndEtat(user, etat);
    }

    public Demande updateEtat(int id, String etat) {
        Demande demande = demandesRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Demande not found with id: " + id));
        log.info("new etat {} demande {}",etat,demande.toString());
        demande.setEtat(etat);
        return demandesRepository.save(demande);
    }
}
