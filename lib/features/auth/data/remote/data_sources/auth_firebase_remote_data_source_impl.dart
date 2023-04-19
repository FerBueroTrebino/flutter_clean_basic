import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dayoff/features/auth/domain/entities/user_entity.dart';
import 'package:dayoff/features/auth/data/remote/models/user_model.dart';
import 'package:dayoff/features/auth/data/remote/data_sources/auth_firebase_remote_data_source.dart';

class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthFirebaseRemoteDataSourceImpl(
      {required this.auth, required this.firestore});

  @override
  Future<void> getUserIdAndCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");

    final uid = await getCurrentUId();

    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
}
