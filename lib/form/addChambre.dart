import 'dart:convert';

import 'package:app_flutter/common/myAlertDialog.dart';
import 'package:flutter/material.dart';
import '../model/Chambre.dart';
import 'package:http/http.dart' as http;

class AddChambre extends StatefulWidget {
  const AddChambre({Key? key}) : super(key: key);

  @override
  State<AddChambre> createState() => _AddChambreState();
}

class _AddChambreState extends State<AddChambre> {
  TextEditingController numeroChambreController = TextEditingController(text: 51.toString());
  TextEditingController typeChambreController = TextEditingController(text: "Simple");
  TextEditingController categorieController = TextEditingController(text: "Motel");
  TextEditingController nbOccupantsController = TextEditingController(text: 1.toString());
  TextEditingController prixHtvaController = TextEditingController(text: 15.25.toString());

  void addChambre() async {
    Chambre chambre = Chambre(
      numero_chambre: int.parse(numeroChambreController.text),
      type_chambre: typeChambreController.text,
      categorie: categorieController.text,
      nb_occupants: int.parse(nbOccupantsController.text),
      prix_htva: double.parse(prixHtvaController.text)
    );

    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http.post(
      Uri.parse("http://localhost:8080/add"),
      headers: headers,
      body: jsonEncode(chambre)
    );

    String message;

    if(response.statusCode == 200) {
      message = response.body;
    } else {
      message = "Error connexion API";
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return MyAlertDialog(title: "Reponse API", content: message);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: numeroChambreController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'numero chambre',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: categorieController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'categorie',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: typeChambreController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'type chambre',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: nbOccupantsController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'nombre occupants',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: prixHtvaController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'prix htva',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () => addChambre(),
          child: Text("ajouter")
        )
      ],
    );
  }
}