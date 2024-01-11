import 'package:travel_management_mobile/model/user.model.dart';

class Demande {
  int id;
  String motif;
  String ville;
  String etat;
  double frais;
  DateTime dateDebut;
  DateTime dateFin;
  UserModel demandeur;
  String moyenTransport;

  Demande({
    required this.id,
    required this.motif,
    required this.ville,
    required this.etat,
    required this.frais,
    required this.dateDebut,
    required this.dateFin,
    required this.demandeur,
    required this.moyenTransport,
  });

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'],
      motif: json['motif'],
      ville: json['ville'],
      etat: json['etat'],
      frais: json['frais'],
      dateDebut: DateTime.parse(json['dateDebut']),
      dateFin: DateTime.parse(json['dateFin']),
      demandeur: UserModel.fromJson(json['demandeur']),
      moyenTransport: json['moyenTransport'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'motif': motif,
      'ville': ville,
      'etat': etat,
      'frais': frais,
      'dateDebut': dateDebut.toIso8601String(),
      'dateFin': dateFin.toIso8601String(),
      'demandeur': demandeur.toJson(),
      'moyenTransport': moyenTransport,
    };
  }
}
