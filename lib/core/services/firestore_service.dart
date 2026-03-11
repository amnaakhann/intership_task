import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create or Update a document
  Future<void> setDocument(String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      // ignore: avoid_print
      print('[FirestoreService] setDocument $collectionPath/$docId');
      await _firestore.collection(collectionPath).doc(docId).set(data).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      // ignore: avoid_print
      print('[FirestoreService] setDocument timed out for $collectionPath/$docId');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Add a document (auto-generated ID)
  Future<DocumentReference> addDocument(String collectionPath, Map<String, dynamic> data) async {
    try {
      return await _firestore.collection(collectionPath).add(data).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      // ignore: avoid_print
      print('[FirestoreService] addDocument timed out for $collectionPath');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Get a document
  Future<DocumentSnapshot> getDocument(String collectionPath, String docId) async {
    try {
      return await _firestore.collection(collectionPath).doc(docId).get().timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      // ignore: avoid_print
      print('[FirestoreService] getDocument timed out for $collectionPath/$docId');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Delete a document
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete().timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      // ignore: avoid_print
      print('[FirestoreService] deleteDocument timed out for $collectionPath/$docId');
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Stream of a collection
  Stream<QuerySnapshot> streamCollection(String collectionPath) {
    return _firestore.collection(collectionPath).snapshots();
  }
}
