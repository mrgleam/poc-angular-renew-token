import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

export interface AddBusinessRequest {
  business: Business
}

export interface Business {
  name: string,
  description: string
}

@Injectable()
export class BusinessService {
    constructor(private http: HttpClient) {
    }

    list() {
      return this.http.get<any>(`${environment.apiUrl}/businesses`);
    }

    add(data: AddBusinessRequest) {
      return this.http.post<any>(`${environment.apiUrl}/businesses`, data);
    }
}