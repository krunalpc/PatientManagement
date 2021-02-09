import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import {ViewAppointmentComponent} from './view-appointment/view-appointment.component';
import {PatientBillingComponent} from './patient-billing/patient-billing.component';
import {PatientDetailsComponent} from './patient-details/patient-details.component';

const routes: Routes = [
{path: 'patientDetails', component: PatientDetailsComponent},
{path: 'patientBilling', component: PatientBillingComponent},
{path: 'viewAppointment', component: ViewAppointmentComponent}

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
