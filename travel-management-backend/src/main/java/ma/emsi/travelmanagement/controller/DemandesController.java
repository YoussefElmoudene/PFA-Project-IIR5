package ma.emsi.travelmanagement.controller;

import ma.emsi.travelmanagement.entities.Demandes;
import ma.emsi.travelmanagement.services.DemandesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/demandes")
public class DemandesController {

	@Autowired
	private DemandesService demandesService;

	@GetMapping("/all")
	public ResponseEntity<List<Demandes>> getAllDemandes() {
		List<Demandes> demandesList = demandesService.getAllDemandes();
		return new ResponseEntity<>(demandesList, HttpStatus.OK);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Demandes> getDemandesById(@PathVariable int id) {
		return demandesService.getDemandesById(id).map(demandes -> new ResponseEntity<>(demandes, HttpStatus.OK))
				.orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
	}

	@PostMapping("/create")
	public ResponseEntity<Demandes> createDemandes(@RequestBody Demandes demandes) {
		Demandes createdDemandes = demandesService.createDemandes(demandes);
		return new ResponseEntity<>(createdDemandes, HttpStatus.CREATED);
	}

	@PutMapping("update/{id}")
	public ResponseEntity<Demandes> updateDemandes(@PathVariable int id, @RequestBody Demandes updatedDemandes) {
		Demandes updatedEntity = demandesService.updateDemandes(id, updatedDemandes);
		return updatedEntity != null ? new ResponseEntity<>(updatedEntity, HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	@DeleteMapping("delete/{id}")
	public ResponseEntity<Void> deleteDemandes(@PathVariable int id) {
		demandesService.deleteDemandes(id);
		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}
	 @GetMapping("/changeEtat/{id}")
	    public ResponseEntity<Demandes> changeDemandeEtat(@PathVariable int id, @RequestParam String etat) {
	        Optional<Demandes> optionalDemandes = demandesService.getDemandesById(id);

	        if (optionalDemandes.isPresent()) {
	            Demandes demandes = optionalDemandes.get();
	            demandes.setEtat(etat);
	            Demandes updatedDemandes = demandesService.updateDemandes(id, demandes);
	            return new ResponseEntity<>(updatedDemandes, HttpStatus.OK);
	        } else {
	            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	        }
	    }
}