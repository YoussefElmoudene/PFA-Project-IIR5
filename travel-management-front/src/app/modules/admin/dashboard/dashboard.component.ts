import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {CdkScrollable} from "@angular/cdk/overlay";
import {DatePipe, NgForOf, NgIf} from "@angular/common";
import {MatButtonModule} from "@angular/material/button";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatIconModule} from "@angular/material/icon";
import {MatMenuModule} from "@angular/material/menu";
import {MatOptionModule} from "@angular/material/core";
import {MatSelectModule} from "@angular/material/select";
import {MatTooltipModule} from "@angular/material/tooltip";
import {MatDialog} from "@angular/material/dialog";
import {DemandeService} from "../../../controller/service/demande.service";
import {Demande} from "../../../controller/model/demande.model";
import {DemandeCreateComponent} from "./demande-create/demande-create.component";
import {ActivatedRoute} from "@angular/router";
import {FormsModule} from "@angular/forms";

@Component({
    selector: 'dashboard',
    standalone: true,
    templateUrl: './dashboard.component.html',
    encapsulation: ViewEncapsulation.None,
    imports: [
        CdkScrollable,
        DatePipe,
        MatButtonModule,
        MatFormFieldModule,
        MatIconModule,
        MatMenuModule,
        MatOptionModule,
        MatSelectModule,
        MatTooltipModule,
        NgForOf,
        NgIf,
        FormsModule
    ]
})
export class DashboardComponent implements OnInit {
    selectedType: string = 'all'

    constructor(public dialog: MatDialog,
                private activate: ActivatedRoute,
                private demandeService: DemandeService) {
    }


    get demandes(): Array<Demande> {
        return this.demandeService.demandes;
    }

    set demandes(value: Array<Demande>) {
        this.demandeService.demandes = value;
    }

    ngOnInit() {
        this.fetch_data();
    }

    private fetch_data() {
        const email = this.activate.snapshot.params.email
        if (email) {
            this.demandeService.findByUser(email).subscribe(res => {
                this.demandes = res
            })
        } else {
            this.demandeService.findAll().subscribe(res => {
                this.demandes = res
            })
        }
    }

    openCreate() {
        const dialogRef = this.dialog.open(DemandeCreateComponent);

        dialogRef.afterClosed().subscribe(result => {

        });
    }

    filterByType() {
        console.log(this.selectedType)
        if (this.selectedType === 'all') {
            this.fetch_data()
        } else {
            this.demandeService.findByEtat(this.selectedType).subscribe(res => {
                this.demandes = res
            })
        }
    }


    changeEtat(etat: string, demande: Demande) {
        demande.etat = etat
        this.demandeService.changeEtat(demande.id, etat)
            .subscribe(res => {
                console.log(res)
            }, error => {
                console.error(error)
            })
    }

    supprimer(demande: Demande) {
        this.demandeService.delete(demande.id)
            .subscribe(res => {
                const index = this.demandes.indexOf(demande)
                this.demandes.splice(index, 1)
            })
    }
}
