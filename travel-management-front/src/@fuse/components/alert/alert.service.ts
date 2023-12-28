import { Injectable } from '@angular/core';
import { Observable, ReplaySubject } from 'rxjs';


class alertModel {
    name: string;
    message: string


    constructor(name?: string, message?: string) {
        this.name = name;
        this.message = message;
    }
}
@Injectable({providedIn: 'root'})
export class FuseAlertService
{
    private readonly _onDismiss: ReplaySubject<string> = new ReplaySubject<string>(1);
    private readonly _onShow: ReplaySubject<string> = new ReplaySubject<string>(1);

    /**
     * Constructor
     */
    constructor()
    {
    }

    // -----------------------------------------------------------------------------------------------------
    // @ Accessors
    // -----------------------------------------------------------------------------------------------------

    /**
     * Getter for onDismiss
     */
    get onDismiss(): Observable<any>
    {
        return this._onDismiss.asObservable();
    }





    /**
     * Getter for onShow
     */
    get onShow(): Observable<any>
    {
        return this._onShow.asObservable();
    }

    // -----------------------------------------------------------------------------------------------------
    // @ Public methods
    // -----------------------------------------------------------------------------------------------------

    /**
     * Dismiss the alert
     *
     * @param name
     */
    dismiss(name: string): void
    {
        // Return if the name is not provided
        if ( !name )
        {
            return;
        }

        // Execute the observable
        this._onDismiss.next(name);
    }

    /**
     * Show the dismissed alert
     *
     * @param name
     */
    show(name: string, message: string, timeout?: number): void {
        if (!timeout) {
            timeout = 2000 // if not specific set timeout t0 1s
        }
        // Return if the name is not provided
        if (!name) {
            return;
        }
        // Execute the observable
        // @ts-ignore
        this._onShow.next(new alertModel(name, message));

        //dismiss alert after 1s
        const timer = setInterval(() => {
            this.dismiss(name)
            clearInterval(timer);
        }, timeout);
    }

}
