import {Component, OnInit} from '@angular/core';
import {CdkScrollable} from "@angular/cdk/overlay";
import {UserService} from "../../../../controller/service/user.service";
import {Role} from "../../../../controller/enum/Role";
import {User} from "../../../../controller/model/user.model";
import {NgForOf} from "@angular/common";
import {MatButtonModule} from "@angular/material/button";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatOptionModule} from "@angular/material/core";
import {MatSelectModule} from "@angular/material/select";
import {FormsModule} from "@angular/forms";
import {MatInputModule} from "@angular/material/input";
import {MatDialog} from "@angular/material/dialog";
import {DemandeurCreateComponent} from "../demandeur-create/demandeur-create.component";
import {MatMenuModule} from "@angular/material/menu";
import {MatIconModule} from "@angular/material/icon";
import {RouterLink} from "@angular/router";

@Component({
    selector: 'app-demandeur-list',
    templateUrl: './demandeur-list.component.html',
    imports: [
        CdkScrollable,
        NgForOf,
        MatButtonModule,
        MatFormFieldModule,
        MatOptionModule,
        MatSelectModule,
        FormsModule,
        MatInputModule,
        MatMenuModule,
        MatIconModule,
        RouterLink
    ],
    standalone: true
})
export class DemandeurListComponent implements OnInit {

    constructor(private userService: UserService,
                private dialog: MatDialog) {
    }

    get demandeurs(): Array<User> {
        return this.userService.demandeurs;
    }

    set demandeurs(value: Array<User>) {
        this.userService.demandeurs = value;
    }

    ngOnInit() {
        this.userService.findByRole(Role.ROLE_DEMANDEUR)
    }

    openCreate() {
        const d = this.dialog.open(DemandeurCreateComponent)
        d.afterClosed().subscribe(result => {
            this.userService.findByRole(Role.ROLE_DEMANDEUR)
        })
    }

    criteria(value: string) {
        if (value && value !== '*' && value?.length > 1) {
            value = value.toLowerCase()
            this.demandeurs = this.demandeurs.filter(s =>
                s.firstName?.toLowerCase()?.includes(value) ||
                s.email?.toLowerCase()?.includes(value) ||
                s.lastName?.toLowerCase()?.includes(value)
            )
        } else {
            this.userService.findByRole(Role.ROLE_DEMANDEUR)
        }
    }

    supprimer(item: User) {
        this.userService.delete(item.id)
            .subscribe(res => {
                const index = this.demandeurs.indexOf(item)
                this.demandeurs.splice(index, 1)
            }, error => {
                console.error(error)
            })
    }
}
