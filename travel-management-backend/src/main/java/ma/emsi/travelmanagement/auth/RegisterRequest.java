package ma.emsi.travelmanagement.auth;



import lombok.*;
import ma.emsi.travelmanagement.entities.Role;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {

    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private Role role;
    private String tel;
}