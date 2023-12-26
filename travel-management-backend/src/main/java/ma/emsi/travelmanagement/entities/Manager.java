package ma.emsi.travelmanagement.entities;

import java.util.List;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@DiscriminatorValue("manager")
public class Manager extends User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	

}
