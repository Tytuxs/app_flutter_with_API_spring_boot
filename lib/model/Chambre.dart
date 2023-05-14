import 'dart:convert';

class Chambre {
  int numero_chambre = 0;
  String type_chambre = "";
  String categorie = "";
  int nb_occupants = 0;
  double prix_htva = 0;

  Chambre({
    required this.numero_chambre,
    required this.type_chambre,
    required this.categorie,
    required this.nb_occupants,
    required this.prix_htva
  });

  String ChambreToJson(Chambre data) => json.encode(data.toJson());

  Chambre.fromJson(Map<String, dynamic> json) {
    numero_chambre = json['numero_chambre'];
    type_chambre = json['type_chambre'];
    categorie = json['categorie'];
    nb_occupants = json['nb_occupants'];
    prix_htva = json['prix_htva'];
  }

  Map<String, dynamic> toJson() => {
    "numero_chambre": numero_chambre,
    "type_chambre": type_chambre,
    "categorie": categorie,
    "nb_occupants": nb_occupants,
    "prix_htva": prix_htva,
  };

  @override
  String toString() {
    return 'Pokemon{numero_chambre: $numero_chambre, type_chambre: $type_chambre, categorie: $categorie, nb_occupants: $nb_occupants, prix_htva: $prix_htva,}';
  }
}