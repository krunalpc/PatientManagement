import { SharedService } from './../../shared.service';
import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-show-billing',
  templateUrl: './show-billing.component.html',
  styleUrls: ['./show-billing.component.css']
})
export class ShowBillingComponent implements OnInit {

  constructor(private service: SharedService) { }

  PatientBillingDetail: any = [];
  CardType: string[] = ['Cash', 'Card']

  @Input() patInfo:any;
  PayableAmount:string = '';
  PaymentMode:string = '';
  PatientID:string = '';

  ngOnInit(): void {
    this.refreshPatientBillingDetail();

    this.PayableAmount=this.patInfo.PayableAmount;
    this.PaymentMode=this.patInfo.PaymentMode;
    this.PatientID=this.patInfo.PatientID;
  }

  // tslint:disable-next-line: typedef
  refreshPatientBillingDetail(){
    this.service.getPatientBillingDetail().subscribe(data => {
        this.PatientBillingDetail = data;
    });
  }

  addBillingInfo(){
    var val = {PayableAmount:this.PayableAmount,
                PaymentMode:this.PaymentMode,
              PatientID:this.PatientID};

      alert(val.PayableAmount + "  " +val.PaymentMode );

    this.service.updatePatientBillingDetail(val).subscribe(res=>{
      alert(res.toString());
      this.refreshPatientBillingDetail();
    });
  }

}
