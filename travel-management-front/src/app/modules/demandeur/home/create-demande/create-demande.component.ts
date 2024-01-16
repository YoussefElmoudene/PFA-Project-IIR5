import {Component} from '@angular/core';
import {MatDialogModule} from "@angular/material/dialog";
import {MatButtonModule} from "@angular/material/button";
import {MatFormFieldModule} from "@angular/material/form-field";
import {FormsModule} from "@angular/forms";
import {MatInputModule} from "@angular/material/input";
import {Demande} from "../../../../controller/model/demande.model";
import {DemandeService} from "../../../../controller/service/demande.service";
import {AuthService} from "../../../../core/auth/auth.service";

@Component({
    selector: 'app-create-demande',
    templateUrl: './create-demande.component.html',
    imports: [
        MatDialogModule,
        MatButtonModule,
        MatFormFieldModule,
        FormsModule,
        MatInputModule
    ],
    standalone: true
})
export class CreateDemandeComponent {
    demande: Demande = new Demande()

    constructor(private demandeService: DemandeService,
                private auth: AuthService) {
        console.log(this.auth._user)
    }

    get demandes(): Array<Demande> {
        return this.demandeService.demandes;
    }

    set demandes(value: Array<Demande>) {
        this.demandeService.demandes = value;
    }

    save() {
        this.demande.demandeur = this.auth._user
        this.demande.etat = 'coming'
        this.demandeService.save(this.demande)
            .subscribe(response => {
                console.log(response)
                this.demandes.push({...response})
            }, error => {
                console.error(error)
            })
    }
}
