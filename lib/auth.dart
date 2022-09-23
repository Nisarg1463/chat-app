// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  FirebaseAuth _auth = await getAuth();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn()!;
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user!;

  assert(!user.isAnonymous);

  final User currentUser = _auth.currentUser!;

  assert(currentUser.uid == user.uid);

  return user;
}

Future<FirebaseAuth> getAuth() async {
  await Firebase.initializeApp();
  return FirebaseAuth.instance;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}
