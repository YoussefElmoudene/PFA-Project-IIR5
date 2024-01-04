package ma.emsi.travelmanagement.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Demande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Lob
    @Column(length = 10000)
    private String motif;
    private String ville;
    private String etat;
    private float frais;
    private Date dateDebut;
    private Date dateFin;
    @ManyToOne
    private User demandeur;
    private String moyenTransport;
}
