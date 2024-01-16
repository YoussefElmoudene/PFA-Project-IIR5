import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_management_mobile/core/api.url.dart';
import 'package:travel_management_mobile/model/demande.model.dart';
import 'package:travel_management_mobile/service/storage.service.dart';
import 'package:travel_management_mobile/service/user.service.dart';

class DemandeService {
  Future<List<Demande>> getAllDemandes() async {
    final token = await StorageService().getToken();

    final response = await http.get(
      Uri.parse('${ApiUrl.springUrl}/demandes/all'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Demande> demandes = data.map((e) => Demande.fromJson(e)).toList();
      return demandes;
    } else {
      throw Exception('Failed to load demandes');
    }
  }

  Future<Demande> getDemandesById(int id) async {
    final token = await StorageService().getToken();

    final response = await http.get(
      Uri.parse('${ApiUrl.springUrl}/demandes/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Demande demande = Demande.fromJson(data);
      return demande;
    } else {
      throw Exception('Failed to load demande');
    }
  }

  Future<List<Demande>> getDemandesByUser() async {
    final token = await StorageService().getToken();
    final Map<String, dynamic>? decodedToken =
        await UserService().decodeToken();
    final response = await http.get(
      Uri.parse('${ApiUrl.springUrl}/demandes/user/${decodedToken!['sub']}'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> dataList = json.decode(response.body);
      List<Demande> demandesList =
          dataList.map((data) => Demande.fromJson(data)).toList();
      return demandesList;
    } else {
      throw Exception('Failed to load demandes');
    }
  }

  Future<http.Response> createDemandes(Demande demande) async {
    final token = await StorageService().getToken();

    final response = await http.post(
      Uri.parse('${ApiUrl.springUrl}/demandes/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(demande.toJson()),
    );

    if (response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to create demande');
    }
  }

  Future<http.Response> updateDemandes(int id, Demande updatedDemande) async {
    final token = await StorageService().getToken();

    final response = await http.put(
      Uri.parse('${ApiUrl.springUrl}/demandes/update/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(updatedDemande.toJson()),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to update demande');
    }
  }

  Future<http.Response> deleteDemandes(int id) async {
    final token = await StorageService().getToken();

    final response = await http.delete(
      Uri.parse('${ApiUrl.springUrl}/demandes/delete/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response;
  }

  Future<List<Demande>> filterDemandesByEtatAndCurrentUser(String etat) async {
    final token = await StorageService().getToken();
    final Map<String, dynamic>? decodedToken =
        await UserService().decodeToken();
    final response = await http.get(
      Uri.parse(
          '${ApiUrl.springUrl}/demandes/filterByEtat?etat=$etat&id=${decodedToken?['id']}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> dataList = json.decode(response.body);
      List<Demande> demandesList =
          dataList.map((data) => Demande.fromJson(data)).toList();
      return demandesList;
    } else {
      throw Exception('Failed to load filtered demandes');
    }
  }

  Future<bool> updateDemandeEtat(int id, String etat) async {
    try {
      final token = await StorageService().getToken();
      final response = await http.put(
        Uri.parse('${ApiUrl.springUrl}/demandes/updateEtat?id=$id&etat=$etat'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 404) {
        return false;
      } else {
        print(
            'Error updating demande etat. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating demande etat: $e');
      throw e;
    }
  }
}
