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
