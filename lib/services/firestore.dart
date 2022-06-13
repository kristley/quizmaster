import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'auth.dart';
import 'models.dart';

class FirestoreService {
  static FirebaseFirestore get _db => FirebaseFirestore.instance;
  static FirebaseStorage get _storage => FirebaseStorage.instance;
  static var defaultCacheManager = DefaultCacheManager();

  static Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var topics = data.map((d) => Topic.fromJson(d));
    return topics.toList();
  }

  static Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }


  static Stream<Report> streamReport() {
    return AuthService.userStream.switchMap((user) {
      if (user == null) {
        return Stream.fromIterable([Report()]);
      }
      var ref = _db.collection('reports').doc(user.uid);
      return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
    });
  }

  static Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService.user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'topics': {quiz.topic: FieldValue.arrayUnion([quiz.id])}
    };

    return ref.set(data, SetOptions(merge: true));
  }

  static Future<String> downloadURL(String img) =>
      _storage.ref(img).getDownloadURL();
}