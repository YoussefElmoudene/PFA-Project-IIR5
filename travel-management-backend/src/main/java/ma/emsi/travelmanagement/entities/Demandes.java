package ma.emsi.travelmanagement.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Demandes {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

}
