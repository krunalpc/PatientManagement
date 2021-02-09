import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {Observable} from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SharedService {
readonly APIUrl = 'http://localhost:56322/api';

  constructor(private http: HttpClient) { }

  // This is for the **** Add Patient Screen ****
  // To get list of Medical Billing Masters
  getMedBillList(): Observable<any[]>{
    return this.http.get<any>(this.APIUrl + '/Medical_Billing_Master');
  }

  // This is for the **** Add Patient Screen ****
  // To Save list of Patient infomration
  // tslint:disable-next-line: typedef
  addPatientDetail(val: any){
    return this.http.post(this.APIUrl + '/Patient_Detail_Master', val);
  }

  // This is for the **** View Appointment ****
  // To get list of Medical Billing Masters
  getPatientDetail(): Observable<any[]>{
    return this.http.get<any>(this.APIUrl + '/Patient_Detail_Master');
  }
  // getPatientDetail(val: any){
  //   return this.http.get<any>(this.APIUrl + '/Patient_Detail_Master', val);
  // }

  // This is for the **** Patient Billing ****
  // To get list of Medical Billing Masters
  getPatientBillingDetail(): Observable<any[]>{
    return this.http.get<any>(this.APIUrl + '/Patient_Billing_Transaction');
  }

  // This is for the **** Patient Billing ****
  // To Save list of Patient infomration
  // tslint:disable-next-line: typedef
  updatePatientBillingDetail(val: any){
    return this.http.put(this.APIUrl + '/Patient_Billing_Transaction', val);
  }

}
