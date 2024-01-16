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
        NgIf
    ]
})
export class DashboardComponent implements OnInit {
    constructor(public dialog: MatDialog,
                private demandeService: DemandeService) {
    }


    get demandes(): Array<Demande> {
        return this.demandeService.demandes;
    }

    set demandes(value: Array<Demande>) {
        this.demandeService.demandes = value;
    }

    ngOnInit() {
        this.demandeService.findAll().subscribe(res => {
            this.demandes = res
        })
    }

    openCreate() {
        const dialogRef = this.dialog.open(DemandeCreateComponent);

        dialogRef.afterClosed().subscribe(result => {

        });
    }
}
