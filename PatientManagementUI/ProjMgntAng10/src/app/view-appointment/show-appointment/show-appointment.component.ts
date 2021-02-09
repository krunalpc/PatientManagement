import { SharedService } from './../../shared.service';
import { Component, Input, OnInit } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';

@Component({
  selector: 'app-show-appointment',
  templateUrl: './show-appointment.component.html',
  styleUrls: ['./show-appointment.component.css']
})
export class ShowAppointmentComponent implements OnInit {

  constructor(private service: SharedService) { }

  AppointmentList: any = [];
  statusType: string[] = ["Not yet Billed", "Due Billed", "Fully Billed"]

  @Input() emp:any;
  FromDate:string = '';
  FromTo:string = '';
  PaymentStatus:string = '';
  searchCriteria:string = '';

  ngOnInit(): void {
     this.refreshAppointmentList();

    this.FromDate=this.emp.FromDate; 
    this.FromTo=this.emp.FromTo;
    this.PaymentStatus=this.emp.PaymentStatus;
    this.searchCriteria=this.emp.searchCriteria;
  }

  // tslint:disable-next-line: typedef
  refreshAppointmentList(){

    this.service.getPatientDetail().subscribe(data => {
        this.AppointmentList = data;
    });

  }

  searchAppointments(){

    var patientDetails = {
      FromDate:this.FromDate, 
      FromTo:this.FromTo,
      PaymentStatus:this.PaymentStatus,
      searchCriteria:this.searchCriteria
    };

    alert(patientDetails);

    this.service.getPatientDetail().subscribe(data => {
      this.AppointmentList = data;
    });

  };

}
