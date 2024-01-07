import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/demande_model.dart';
import '../toasts/toast_notifications.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getDemandes() async {
    QuerySnapshot snapshot = await _firestore.collection('demandes').get();
    return snapshot.docs;
  }

  Stream<QuerySnapshot> getDemandesStream() {
    return _firestore.collection('demandes').snapshots();
  }

  Future<void> addDemande(Demande demande) async {
    await _firestore.collection('demandes').add({
      'dateStart': demande.dateStart,
      'dateEnd': demande.dateEnd,
      'amount': demande.amount,
      'city': demande.city,
      'vehicle': demande.vehicle,
    });
  }
  Future<void> updateDemande(String documentId, Demande updatedDemande) async {
    await _firestore.collection('demandes').doc(documentId).update({
      'dateStart': updatedDemande.dateStart,
      'dateEnd': updatedDemande.dateEnd,
      'amount': updatedDemande.amount,
      'city': updatedDemande.city,
      'vehicle': updatedDemande.vehicle,
    });
  }

  void deleteDemande(QueryDocumentSnapshot demande) async {
    await _firestore.collection('demandes').doc(demande.id).delete();

  }
}
