package ma.emsi.travelmanagement.services;

import jakarta.transaction.Transactional;
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
public class DemandesService {

    @Autowired
    private DemandesRepository demandesRepository;
    @Autowired
    private UserRepository userRepository;

<<<<<<< HEAD
	public List<Demandes> getAllDemandes() {
		return demandesRepository.findAll();
	}
=======
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

    public List<Demande> getDemandesByUser(String email) {
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            return demandesRepository.findByDemandeur(user.get());
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "user not found");
        }
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
>>>>>>> 19e59470a29d3a546d756c8f609a3fb0690edf06

	public Optional<Demandes> getDemandesById(int id) {
		return demandesRepository.findById(id);
	}

	public Demandes createDemandes(Demandes demandes) {

		if (demandes != null) {
			return demandesRepository.save(demandes);
		}
		return null;
	}

	public Demandes updateDemandes(int id, Demandes updatedDemandes) {
		if (id > 0 && updatedDemandes != null) {
			Optional<Demandes> existingDemandes = demandesRepository.findById(id);
			if (existingDemandes.isPresent()) {
				Demandes currentDemandes = existingDemandes.get();

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

		if (demandesRepository.existsById(id)) {
			demandesRepository.deleteById(id);
		}
	}
}
