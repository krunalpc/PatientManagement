import { SharedService } from './../../shared.service';
import { Component, Input, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators} from '@angular/forms';

@Component({
  selector: 'app-show-medical-billing',
  templateUrl: './show-medical-billing.component.html',
  styleUrls: ['./show-medical-billing.component.css']
})
export class ShowMedicalBillingComponent implements OnInit {

  constructor(private service: SharedService) { }

  form = new FormGroup({
    gender: new FormControl('', Validators.required)
  });

  Salutations: any = ["Mr.", "Mrs."]
  ageType: string[] = ["Years", "Months"]
  countryList = [
    "USA",
    "India",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas (the)",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan"
  ]

  MedicalBillingList: any = [];

  Medical_Billing_Filter:string="";
  MedicalExamWithoutFilter:any=[];

  @Input() patInfo:any;
  PatientSalutation:string = '';
  PatientName:string = '';
  gender:string = '';
  DOB:string = '';
  Age:string = '';
  AgeType:string = '';
  AppointmentDate:string = '';
  PhoneNumber:string = '';
  Address:string = '';
  Address2:string = '';
  City:string = '';
  State:string = '';
  Postal:string = '';
  Country:string = '';

  ngOnInit(): void {
     this.refreshMedBillDetails();

    this.PatientSalutation=this.patInfo.PatientSalutation; 
    this.PatientName=this.patInfo.PatientName;
    this.gender=this.patInfo.gender;
    this.DOB=this.patInfo.DOB;
    this.Age=this.patInfo.Age;
    this.AgeType=this.patInfo.AgeType;
    this.AppointmentDate=this.patInfo.AppointmentDate;
    this.PhoneNumber=this.patInfo.PhoneNumber;
    this.Address=this.patInfo.Address;
    this.Address2=this.patInfo.Address2;
    this.City=this.patInfo.City;
    this.State=this.patInfo.State;
    this.Postal=this.patInfo.Postal;
    this.Country=this.patInfo.Country;
  }

  // tslint:disable-next-line: typedef
  refreshMedBillDetails(){
    this.service.getMedBillList().subscribe(data => {
        this.MedicalBillingList = data;
        this.MedicalExamWithoutFilter = data;
    });
  }

  FilterFn(){
    var Medical_Billing_Filter = this.Medical_Billing_Filter;

    this.MedicalBillingList = this.MedicalExamWithoutFilter.filter(function (el: { Medical_Billing: { toString: () => string; }; }){
      return el.Medical_Billing.toString().toLowerCase().includes(
        Medical_Billing_Filter.toString().trim().toLowerCase()
      )
    });
  }

  submit(){
    console.log(this.form.value);
  }
  changeCountry(e: { target: { value: any; }; }) {
    console.log(e.target.value);
  }

  addPatientDetails(){

    var patientDetails = {
      PatientSalutation:this.PatientSalutation, 
      PatientName:this.PatientName,
      gender:this.gender,
      DOB:this.DOB,
      Age:this.Age,
      AgeType:this.AgeType,
      AppointmentDate:this.AppointmentDate,
      PhoneNumber:this.PhoneNumber,
      Address:this.Address,
      Address2:this.Address2,
      City:this.City,
      State:this.State,
      Postal:this.Postal,
      Country:this.Country
    };

    alert(patientDetails);

    this.service.addPatientDetail(patientDetails).subscribe(res=>{
      alert(res.toString());
    });
  }

  sortResult(prop: string | number,asc: any){
    this.MedicalBillingList = this.MedicalExamWithoutFilter.sort(function(a: { [x: string]: number; },b: { [x: string]: number; }){
      if(asc){
          return (a[prop]>b[prop])?1 : ((a[prop]<b[prop]) ?-1 :0);
      }else{
        return (b[prop]>a[prop])?1 : ((b[prop]<a[prop]) ?-1 :0);
      }
    })
  }

  changeGender(selectedValue: string){
    if(selectedValue == 'Mrs.'){
    } else if (selectedValue == 'Mr.'){
    }
  }

}
