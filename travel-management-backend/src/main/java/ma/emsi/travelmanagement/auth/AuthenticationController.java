package ma.emsi.travelmanagement.auth;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import ma.emsi.travelmanagement.config.JwtService;
import ma.emsi.travelmanagement.entities.User;
import ma.emsi.travelmanagement.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

import static org.springframework.http.HttpStatus.OK;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@CrossOrigin
public class AuthenticationController {

    @Autowired
    private AuthenticationService service;
    @Autowired
    private UserService userService;
    @Autowired
    private JwtService jwtService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(@RequestBody RegisterRequest request) {
        System.out.println(request.getEmail());
        return ResponseEntity.ok(service.register(request));
    }

    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request) {
        return ResponseEntity.ok(service.authenticate(request));
    }

    @PostMapping("/refresh-token")
    public void refreshToken(HttpServletRequest request, HttpServletResponse response) throws IOException {
        service.refreshToken(request, response);
    }

    @PostMapping("/sign-in-with-token")
    public ResponseEntity<User> sign_in_using_token(@RequestBody TokenVo token) {
        System.out.println("token.getAccessToken() = " + token.getAccessToken());
        if (token != null) {
            String usernameFromToken = jwtService.extractUsername(token.getAccessToken());
            User user = userService.findUserByUsername(usernameFromToken);
            if (user != null) return new ResponseEntity<>(user, OK);
        }
        return new ResponseEntity<>(null, HttpStatus.UNAUTHORIZED);
    }


}

