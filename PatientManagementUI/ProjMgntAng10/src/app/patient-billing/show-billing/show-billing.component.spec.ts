import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ShowBillingComponent } from './show-billing.component';

describe('ShowBillingComponent', () => {
  let component: ShowBillingComponent;
  let fixture: ComponentFixture<ShowBillingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ShowBillingComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ShowBillingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
