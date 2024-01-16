package ma.emsi.travelmanagement.services;

import jakarta.transaction.Transactional;
import ma.emsi.travelmanagement.entities.Demande;
import ma.emsi.travelmanagement.entities.User;
import ma.emsi.travelmanagement.repository.DemandesRepository;
import ma.emsi.travelmanagement.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
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
        Optional<User> user = userRepository.findByEmail(demandes.getDemandeur().getEmail());
        if (user.isPresent()) {
            demandes.setDemandeur(user.get());
        } else {
            throw new RuntimeException("Your account not found.");
        }
        return demandesRepository.save(demandes);
    }

    public Demande updateDemandes(int id, Demande updatedDemandes) {
        if (demandesRepository.existsById(id)) {
            updatedDemandes.setId(id);
            return demandesRepository.save(updatedDemandes);
        }
        return null;
    }

    @Transactional
    public void deleteDemandes(int id) {
        demandesRepository.deleteById(id);
    }
}

