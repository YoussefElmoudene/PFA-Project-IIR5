import {Component} from '@angular/core';
import {Demande} from "../../../../controller/model/demande.model";
import {DemandeService} from "../../../../controller/service/demande.service";
import {AuthService} from "../../../../core/auth/auth.service";
import {MatButtonModule} from "@angular/material/button";
import {MatDialogModule} from "@angular/material/dialog";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatInputModule} from "@angular/material/input";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";

@Component({
    selector: 'app-demande-create',
    templateUrl: './demande-create.component.html',
    imports: [
        MatButtonModule,
        MatDialogModule,
        MatFormFieldModule,
        MatInputModule,
        ReactiveFormsModule,
        FormsModule
    ],
    standalone: true
})
export class DemandeCreateComponent {
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
        this.demande.etat = 'PENDING'
        this.demandeService.save(this.demande)
            .subscribe(response => {
                console.log(response)
                this.demandes.push({...response})
            }, error => {
                console.error(error)
            })
    }
}

