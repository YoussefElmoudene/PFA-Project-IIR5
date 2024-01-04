import {Component} from '@angular/core';
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

@Component({
    selector: 'app-home',
    templateUrl: './home.component.html',
    standalone: true,
    imports: [CdkScrollable, MatFormFieldModule, MatSelectModule
        , MatOptionModule, NgFor, MatIconModule, MatInputModule,
        MatSlideToggleModule, NgIf, NgClass, MatTooltipModule,
        MatProgressBarModule, MatButtonModule, RouterLink,
        FuseFindByKeyPipe, PercentPipe, I18nPluralPipe, FormsModule, DatePipe],

    styleUrls: ['./home.component.scss']
})
export class HomeComponent {
    startTime = new Date()
    endTime = new Date()
    constructor() {
    }
}
