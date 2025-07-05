import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/study_model.dart';

class FirestoreService {
  CollectionReference get collection => FirebaseFirestore.instance.collection('users');

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future<void> saveStudy(Study study) async {
    try {
      await collection
          .doc(userId)
          .collection('studies')
          .add(study.toMap());
    } catch (e) {
      // opcional: logar o erro para debug
      print('Erro ao salvar estudo: $e');
      rethrow;
    }
  }

  Stream<List<Study>> getStudies() {
    return collection
        .doc(userId)
        .collection('studies')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Study.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
        });
  }
}
