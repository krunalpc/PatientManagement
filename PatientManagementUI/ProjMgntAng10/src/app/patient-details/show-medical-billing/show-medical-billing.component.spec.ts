import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ShowMedicalBillingComponent } from './show-medical-billing.component';

describe('ShowMedicalBillingComponent', () => {
  let component: ShowMedicalBillingComponent;
  let fixture: ComponentFixture<ShowMedicalBillingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ShowMedicalBillingComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ShowMedicalBillingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
