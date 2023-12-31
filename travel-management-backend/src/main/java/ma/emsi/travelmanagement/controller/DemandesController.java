package ma.emsi.travelmanagement.controller;

import ma.emsi.travelmanagement.entities.Demande;
import ma.emsi.travelmanagement.services.DemandesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/demandes")
public class DemandesController {

	@Autowired
	private DemandesService demandesService;

	@GetMapping("/all")
	public ResponseEntity<List<Demande>> getAllDemandes() {
		List<Demande> demandesList = demandesService.getAllDemandes();
		return new ResponseEntity<>(demandesList, HttpStatus.OK);
	}

	@GetMapping("/{id}")
	public ResponseEntity<Demande> getDemandesById(@PathVariable int id) {
		return demandesService.getDemandesById(id).map(demandes -> new ResponseEntity<>(demandes, HttpStatus.OK))
				.orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND));
	}

	@PostMapping("/create")
	public ResponseEntity<Demande> createDemandes(@RequestBody Demande demandes) {
		Demande createdDemandes = demandesService.createDemandes(demandes);
		return new ResponseEntity<>(createdDemandes, HttpStatus.CREATED);
	}

	@PutMapping("update/{id}")
	public ResponseEntity<Demande> updateDemandes(@PathVariable int id, @RequestBody Demande updatedDemandes) {
		Demande updatedEntity = demandesService.updateDemandes(id, updatedDemandes);
		return updatedEntity != null ? new ResponseEntity<>(updatedEntity, HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	@DeleteMapping("delete/{id}")
	public ResponseEntity<Void> deleteDemandes(@PathVariable int id) {
		demandesService.deleteDemandes(id);
		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}
}