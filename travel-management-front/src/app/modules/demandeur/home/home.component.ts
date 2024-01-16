import {Component, OnInit} from '@angular/core';
import {MatIconModule} from "@angular/material/icon";
import {CdkScrollable} from "@angular/cdk/overlay";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatSelectModule} from "@angular/material/select";
import {MatOptionModule} from "@angular/material/core";
import {DatePipe, I18nPluralPipe, NgClass, NgFor, NgIf, PercentPipe} from "@angular/common";
import {MatInputModule} from "@angular/material/input";
import {MatSlideToggleModule} from "@angular/material/slide-toggle";
import {MatTooltipModule} from "@angular/material/tooltip";
import {MatProgressBarModule} from "@angular/material/progress-bar";
import {MatButtonModule} from "@angular/material/button";
import {RouterLink} from "@angular/router";
import {FuseFindByKeyPipe} from "../../../../@fuse/pipes/find-by-key";
import {FormsModule} from "@angular/forms";
import {MatDialog} from "@angular/material/dialog";
import {CreateDemandeComponent} from "./create-demande/create-demande.component";
import {DemandeService} from "../../../controller/service/demande.service";
import {Demande} from "../../../controller/model/demande.model";
import {MatMenuModule} from "@angular/material/menu";
import {AuthService} from "../../../core/auth/auth.service";

@Component({
    selector: 'app-home',
    templateUrl: './home.component.html',
    standalone: true,
    imports: [CdkScrollable, MatFormFieldModule, MatSelectModule
        , MatOptionModule, NgFor, MatIconModule, MatInputModule,
        MatSlideToggleModule, NgIf, NgClass, MatTooltipModule,
        MatProgressBarModule, MatButtonModule, RouterLink,
        FuseFindByKeyPipe, PercentPipe, I18nPluralPipe, FormsModule, DatePipe, MatMenuModule],
})
export class HomeComponent implements OnInit {

    constructor(public dialog: MatDialog,
                private auth: AuthService,
                private demandeService: DemandeService) {
    }


    get demandes(): Array<Demande> {
        return this.demandeService.demandes;
    }

    set demandes(value: Array<Demande>) {
        this.demandeService.demandes = value;
    }

    ngOnInit() {
        this.demandeService.findByUser(this.auth._user?.email).subscribe(res => {
            this.demandes = res
        })
    }

    openCreate() {
        const dialogRef = this.dialog.open(CreateDemandeComponent);

        dialogRef.afterClosed().subscribe(result => {

        });
    }
}
