import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp1/ajouter.dart';
import 'package:tp1/editer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, String>> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        backgroundColor: Colors.blue,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Notes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Icon(Icons.more_vert, color: Colors.white,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var note = snapshot.data!.docs[index];
                return ListTile(
                  title: Text(note['titre'] ?? ''),
                  subtitle: Text(note['contenu'] ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,
                        color: Colors.blue,),
                        onPressed: () {
                          editerNote(context, note);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                        color: Colors.red,),
                        onPressed: () {
                          supprimerNote(note['titre'] ?? '');
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("Erreur de chargement des notes");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),      
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Ajouter())),
        child: Icon(Icons.add),
      ),
    );
  }
  void supprimerNote(String titre) {
    FirebaseFirestore.instance
        .collection('notes')
        .where('titre', isEqualTo: titre)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
}

void editerNote(BuildContext context, DocumentSnapshot note) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditerNote(note: note),
    ),
  );
}
