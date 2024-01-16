import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ajouter extends StatefulWidget {
  const Ajouter({super.key});

  @override
  State<Ajouter> createState() => _AjouterState();
}

class _AjouterState extends State<Ajouter> {
  //  String titre = '';
  //  String contenu = '';
  final TextEditingController titreController = TextEditingController();
  final TextEditingController contenuController = TextEditingController();

   void ajouterNote() {
  String titre = titreController.text;
  String contenu = contenuController.text;

  if (titre.isNotEmpty && contenu.isNotEmpty) {
    FirebaseFirestore.instance.collection('notes').add({
      'titre': titre,
      'contenu': contenu,
    });
    Navigator.pop(context);
  } else {
    // Afficher un message d'erreur ou prendre une autre action
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur'),
          content: Text('Veuillez remplir tous les champs.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    'Ajouter une note',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Center(
                  child: Text(
                    'Bienvenue sur Note_app, votre application de note préférée',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  'Titre',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: titreController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir un titre.';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Titre',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Contenu',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: contenuController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir un titre.';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  maxLines:null, 
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Contenu',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: ajouterNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),),
                        child: Text(
                          'Ajouter',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}