package ma.emsi.travelmanagement.auth;



import lombok.*;
import ma.emsi.travelmanagement.entities.Role;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {

    private String firstname;
    private String lastname;
    private String email;
    private String password;
    private Role role;
    private String username;
    private String tel;
}