import {User} from "./user.model";

export class Demande {
    public id: number;
    public motif: string
    public ville: string
    public etat: string
    public frais: number
    public dateDebut: Date
    public dateFin: Date
    public demandeur: User
    public moyenTransport: string
}
