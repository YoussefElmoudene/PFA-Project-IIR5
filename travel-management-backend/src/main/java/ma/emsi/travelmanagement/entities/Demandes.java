package ma.emsi.travelmanagement.entities;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Demandes {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String motif;
	private String ville ;
	 private String etat;
	 private float frais;
	 private Date dateDebut;
	 private Date dateFin;
	 @ManyToOne
	 private Demandeur demandeur;
	 private String moyenTransport;
}
