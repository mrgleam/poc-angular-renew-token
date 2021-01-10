import { Component, OnInit } from '@angular/core';
import { forkJoin } from 'rxjs';
import { BusinessService } from '../_services/business.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(private businessService: BusinessService) { }

  ngOnInit(): void {
    forkJoin([this.businessService.list(), this.businessService.list()]).subscribe(res => {
      console.log(res)
    })
  }

}
