import {Component} from '@angular/core';
import {FormsModule} from "@angular/forms";
import {MatButtonModule} from "@angular/material/button";
import {MatDialogModule, MatDialogRef} from "@angular/material/dialog";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInputModule} from "@angular/material/input";
import {User} from "../../../../controller/model/user.model";
import {AuthService} from "../../../../core/auth/auth.service";
import {UserService} from "../../../../controller/service/user.service";

@Component({
    selector: 'app-demandeur-create',
    templateUrl: './demandeur-create.component.html',
    imports: [
        FormsModule,
        MatButtonModule,
        MatDialogModule,
        MatFormFieldModule,
        MatInputModule
    ],
    standalone: true
})
export class DemandeurCreateComponent {
    demandeur: User = new User()

    constructor(private auth: AuthService,
                private userService: UserService,
                private dialog: MatDialogRef<DemandeurCreateComponent>
    ) {
    }

    set demandeurs(value: Array<User>) {
        this.userService.demandeurs = value;
    }

    save() {
        this.auth.signUp(this.demandeur)
            .subscribe(res => {
                this.dialog.close('success')
            })
    }
}
