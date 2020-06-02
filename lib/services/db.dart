import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebas/models/devocional.dart';
import 'package:pruebas/models/event.dart';

Stream<List<Evento>> getEvents() {
  return Firestore.instance
      .collection('noticias')
      .snapshots()
      .map(toEventoList);
}

Stream<List<Devocional>> getDevocionals() {
  return Firestore.instance
      .collection('devocionales')
      .snapshots()
      .map(toDevList);
}

