import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        // add authorization header with jwt token if available
        const token = localStorage.getItem('token') || '';
        if (token) {
            let ptoken = JSON.parse(token);
            request = request.clone({
                setHeaders: { 
                    Authorization: `Bearer ${ptoken}`
                }
            });
        }

        return next.handle(request);
    }
}