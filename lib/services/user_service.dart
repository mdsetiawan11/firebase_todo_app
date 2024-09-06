import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot> getUserProfile(String uid) async {
    try {
      QuerySnapshot userProfileSnapshot =
          await users.where('uid', isEqualTo: uid).get();
      if (userProfileSnapshot.docs.isNotEmpty) {
        return userProfileSnapshot.docs.first;
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }
}
