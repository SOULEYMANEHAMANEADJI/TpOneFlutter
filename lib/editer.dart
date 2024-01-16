import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditerNote extends StatefulWidget {
  final DocumentSnapshot note;

  EditerNote({required this.note});

  @override
  _EditerNoteState createState() => _EditerNoteState();
}

class _EditerNoteState extends State<EditerNote> {
  TextEditingController titreController = TextEditingController();
  TextEditingController contenuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titreController.text = widget.note['titre'] ?? '';
    contenuController.text = widget.note['contenu'] ?? '';
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
                    'Modifier votre note',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: Text(
                    "NB : La modification n'est possible que si les deux champs de saisis sont remplis.",
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
                  maxLines:
                      null, // Cette ligne permet d'avoir une taille automatique pour la saisie multiline
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
                        onPressed: mettreAJourNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),),
                        child: Text(
                          'Modifier',
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

  void mettreAJourNote() {
    String titre = titreController.text;
    String contenu = contenuController.text;

    if (titre.isNotEmpty && contenu.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('notes')
          .doc(widget.note.id)
          .update({
        'titre': titre,
        'contenu': contenu,
      });
      // Revenir à la page d'accueil après la mise à jour
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
}
