import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PatientDetailsComponent } from './patient-details/patient-details.component';
import { ViewAppointmentComponent } from './view-appointment/view-appointment.component';
import { PatientBillingComponent } from './patient-billing/patient-billing.component';
import { ShowMedicalBillingComponent } from './patient-details/show-medical-billing/show-medical-billing.component';
import { ShowAppointmentComponent } from './view-appointment/show-appointment/show-appointment.component';
import { ShowBillingComponent } from './patient-billing/show-billing/show-billing.component';
import { SharedService } from './shared.service';

import {HttpClientModule} from '@angular/common/http';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent,
    PatientDetailsComponent,
    ViewAppointmentComponent,
    PatientBillingComponent,
    ShowMedicalBillingComponent,
    ShowAppointmentComponent,
    ShowBillingComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserAnimationsModule
  ],
  providers: [SharedService],
  bootstrap: [AppComponent]
})
export class AppModule { }
