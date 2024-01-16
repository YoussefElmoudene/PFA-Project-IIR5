import {Routes} from '@angular/router';
import {DashboardComponent} from 'app/modules/admin/dashboard/dashboard.component';
import {DemandeurListComponent} from "./demandeurs/demandeur-list/demandeur-list.component";

export default [
    {
        path: 'home',
        component: DashboardComponent,
    },
    {
        path: 'demandes/:email',
        component: DashboardComponent,
    },
    {
        path: 'users',
        component: DemandeurListComponent,
    },
] as Routes;
