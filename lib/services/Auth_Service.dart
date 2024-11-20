import 'package:RunWalk/pages/akun_page.dart';
import 'package:RunWalk/pages/dummypage.dart';
import 'package:RunWalk/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } on FirebaseAuthException catch (e) {
      String pesan = '';
      if (e.code == 'weak-password') {
        pesan = 'meuni lemah pw teh';
      } else if (e.code == 'email-already-in-use') {
        pesan = 'geus di pake emailna blog';
      }
      Fluttertoast.showToast(
        msg: pesan,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dummypage()));

      // if (credential.user != null) {
      //   print("Login berhasil, pindah ke AkunPage");
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => AkunPage()),
      //   );
      // } else {
      //   print("Login gagal, userCredential.user == null");
      // }

    } on FirebaseAuthException catch (e) {
      String pesan = '';
      if (e.code == 'user-not-found') {
        pesan = 'user teu kapanggih';
      } else if (e.code == 'wrong-password') {
        pesan = 'password salah blog';
      } else if (e.code == 'invalid-email') {
        pesan = 'Format email tidak valid.';
      } else if (e.code == 'user-disabled') {
        pesan = 'Akun ini telah dinonaktifkan.';
      } else {
        pesan = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      Fluttertoast.showToast(
        msg: pesan,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }
}
