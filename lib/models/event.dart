import 'package:cloud_firestore/cloud_firestore.dart';

class Evento {
  String id;
  String titulo;
  String descripcion;
  String imagen;

  Evento.fromFirestore(DocumentSnapshot doc)
      : id = doc.documentID,
        titulo = doc.data['titulo'],
        descripcion = doc.data['descripcion'],
        imagen = doc.data['imagen'];
}

List<Evento> toEventoList(QuerySnapshot query) =>
    query.documents.map((doc) => Evento.fromFirestore(doc)).toList();
