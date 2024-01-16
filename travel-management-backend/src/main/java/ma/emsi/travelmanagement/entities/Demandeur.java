package ma.emsi.travelmanagement.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@DiscriminatorValue("demandeur")
public class Demandeur extends User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
}
