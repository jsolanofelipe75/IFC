import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String id;
  String name;
  String email;
  String imagen;
  String createdAt;
  String celular;

  Usuario.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        name = doc.data['name'],
        email = doc.data['email'],
        imagen = doc.data['photoUrl'],
        createdAt = doc.data['createdAt'],
        celular = doc.data['celular'];
        
}