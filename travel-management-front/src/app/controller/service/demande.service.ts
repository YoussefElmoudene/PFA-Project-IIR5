import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Demande} from "../model/demande.model";
import {Observable} from "rxjs";
import {environment} from "../../../environments/environment";

@Injectable({
    providedIn: 'root'
})
export class DemandeService {
    private _demandes: Array<Demande> = new Array<Demande>()
    url = environment.URL + '/demandes/'

    constructor(private http: HttpClient) {
    }


    get demandes(): Array<Demande> {
        return this._demandes;
    }

    set demandes(value: Array<Demande>) {
        this._demandes = value;
    }

    public save(d: Demande): Observable<Demande> {
        return this.http.post<Demande>(this.url + 'create', d)
    }

    public findAll(): Observable<Demande[]> {
        return this.http.get<Demande[]>(this.url + 'all')
    }

    public findByUser(email): Observable<Demande[]> {
        return this.http.get<Demande[]>(this.url + `user/${email}`)
    }

    public findByEtat(etat): Observable<Demande[]> {
        return this.http.get<Demande[]>(this.url + `etat/${etat}`)
    }

    public changeEtat(id, etat): Observable<Demande> {
        return this.http.get<Demande>(this.url + `changeEtat/${id}/${etat}`)
    }

    delete(id: number): Observable<any> {
        return this.http.delete<any>(this.url + `delete/${id}`)
    }
}//
