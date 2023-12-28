import {NgIf} from '@angular/common';
import {Component, OnInit, ViewChild, ViewEncapsulation} from '@angular/core';
import {
    FormsModule,
    NgForm,
    ReactiveFormsModule,
    UntypedFormBuilder,
    UntypedFormGroup,
    Validators
} from '@angular/forms';
import {MatButtonModule} from '@angular/material/button';
import {MatCheckboxModule} from '@angular/material/checkbox';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatIconModule} from '@angular/material/icon';
import {MatInputModule} from '@angular/material/input';
import {MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import {ActivatedRoute, Router, RouterLink} from '@angular/router';
import {fuseAnimations} from '@fuse/animations';
import {FuseAlertComponent, FuseAlertService} from '@fuse/components/alert';
import {AuthService} from 'app/core/auth/auth.service';
import {Role} from "../../../controller/enum/Role";

@Component({
    selector: 'auth-sign-in',
    templateUrl: './sign-in.component.html',
    encapsulation: ViewEncapsulation.None,
    animations: fuseAnimations,
    standalone: true,
    imports: [RouterLink, FuseAlertComponent, NgIf, FormsModule, ReactiveFormsModule, MatFormFieldModule, MatInputModule, MatButtonModule, MatIconModule, MatCheckboxModule, MatProgressSpinnerModule],
})
export class AuthSignInComponent implements OnInit {
    @ViewChild('signInNgForm') signInNgForm: NgForm;

    signInForm: UntypedFormGroup;
    showAlert: boolean = false;

    /**
     * Constructor
     */
    constructor(
        private _activatedRoute: ActivatedRoute,
        private _authService: AuthService,
        private _formBuilder: UntypedFormBuilder,
        private alert: FuseAlertService,
        private _router: Router,
    ) {
    }

    // -----------------------------------------------------------------------------------------------------
    // @ Lifecycle hooks
    // -----------------------------------------------------------------------------------------------------

    /**
     * On init
     */
    ngOnInit(): void {
        // Create the form
        this.signInForm = this._formBuilder.group({
            email: ['youssef@gmail.com', [Validators.required, Validators.email]],
            password: ['youssef123', Validators.required]
        });
    }

    // -----------------------------------------------------------------------------------------------------
    // @ Public methods
    // -----------------------------------------------------------------------------------------------------

    /**
     * Sign in
     */
    signIn(): void {
        // Return if the form is invalid
        if (this.signInForm.invalid) {
            return;
        }

        // Disable the form
        this.signInForm.disable();
        // Sign in
        this._authService.signIn(this.signInForm.value)
            .subscribe(
                (authority) => {

                    if (authority === Role.ROLE_ADMIN) {
                        location.href = '/admin/dashboard'
                    } else if (authority === Role.ROLE_DEMANDEUR) {
                        location.href = '/demandeur/home'
                    } else {
                        this._authService.signOut();
                        // Re-enable the form
                        this.signInForm.enable();

                        // Reset the form
                        this.signInNgForm.resetForm();

                        // Set the alert
                        // this.alert.show(
                        //     'warning',
                        //     'Your account is not valid account, please contact administration.')

                    }
                },
                (error) => {
                    console.log(error)
                    // Re-enable the form
                    this.signInForm.enable();

                    //user enabled 2-step auth, redirect user to insert code sent in mail
                    // if (error?.status === 307) {
                    //     this.alert.show('info', 'The verification code sent to your email.', 20000)
                    //     const email = this.signInForm.get('email').value
                    //     this._router.navigate([`confirmation-code/${email}`])
                    // } else {
                    //
                    //     if (error?.error?.toString()?.includes("Your account is not verified")
                    //         || error?.error?.toString()?.includes("User is disabled")) {
                    //         this.showAlert = true
                    //     }
                    //     this.alert.show('info', error?.error || 'Wrong email or password.', 20000)
                    // }
                },
            );
    }
}
