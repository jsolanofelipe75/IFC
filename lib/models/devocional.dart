
import 'package:cloud_firestore/cloud_firestore.dart';

class Devocional{

  String id;
  String titulo;
  String descripcion;
  String imagen;

  Devocional.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        titulo = doc.data['titulo'],
        descripcion = doc.data['descripcion'],
        imagen = doc.data['imagen'];
}
List<Devocional> toDevList(QuerySnapshot query) =>
    query.documents.map((doc) => Devocional.fromFirestore(doc)).toList();