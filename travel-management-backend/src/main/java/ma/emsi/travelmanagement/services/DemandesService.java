package ma.emsi.travelmanagement.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ma.emsi.travelmanagement.entities.Demandes;
import ma.emsi.travelmanagement.repository.DemandesRepository;

@Service
public class DemandesService {

	@Autowired
	private DemandesRepository demandesRepository;

	    public List<Demandes> getAllDemandes() {
	        return demandesRepository.findAll();
	    }

	    public Optional<Demandes> getDemandesById(int id) {
	        return demandesRepository.findById(id);
	    }

	    public Demandes createDemandes(Demandes demandes) {
	        return demandesRepository.save(demandes);
	    }

	    public Demandes updateDemandes(int id, Demandes updatedDemandes) {
	        if (demandesRepository.existsById(id)) {
	            updatedDemandes.setId(id);
	            return demandesRepository.save(updatedDemandes);
	        }
	        return null;
	    }

	    public void deleteDemandes(int id) {
	        demandesRepository.deleteById(id);
	    }
	}

