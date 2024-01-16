import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable} from "rxjs";
import {environment} from "../../../environments/environment";
import {User} from "../model/user.model";

@Injectable({
    providedIn: 'root'
})
export class UserService {
    private _demandeurs: Array<User> = new Array<User>()
    url = environment.URL + '/users/'

    constructor(private http: HttpClient) {
    }


    get demandeurs(): Array<User> {
        return this._demandeurs;
    }

    set demandeurs(value: Array<User>) {
        this._demandeurs = value;
    }

    public save(d: User): Observable<User> {
        return this.http.post<User>(this.url + 'create', d)
    }

    public findAll(): Observable<User[]> {
        return this.http.get<User[]>(this.url + 'all')
    }

    public findByRole(role) {
        this.http.get<User[]>(this.url + `role/${role}`)
            .subscribe(res => {
                this.demandeurs = res
            }, error => {
                console.error(error)
            })
    }
}
