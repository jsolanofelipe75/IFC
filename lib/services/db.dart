import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebas/models/devocional.dart';




Stream<List<Devocional>> getDevocionals() {
  return Firestore.instance
      .collection('devocionales')
      .snapshots()
      .map(toDevList);
}

