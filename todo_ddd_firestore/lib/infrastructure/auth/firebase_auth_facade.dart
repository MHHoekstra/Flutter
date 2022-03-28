import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/failures/auth_failure.dart';
import '../../domain/auth/entities/email_address.dart';
import '../../domain/auth/repositories/i_auth_facade.dart';
import '../../domain/auth/entities/password.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(const PasswordTooWeak());
      } else if (e.code == 'email-already-in-use') {
        return left(const EmailAlreadyInUse());
      } else if (e.code == 'invalid-email') {
        return left(const InvalidEmail());
      } else {
        return left(const ServerError());
      }
    } catch (e) {
      return left(const ServerError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  }) async {
    final emailStr = email.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      var isInvalidEmailOrPasswordCombination = e.code == 'user-disabled' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password';

      if (e.code == 'invalid-email') {
        return left(const InvalidEmail());
      } else if (isInvalidEmailOrPasswordCombination) {
        return left(const InvalidEmailAndPasswordCombination());
      } else {
        return left(const ServerError());
      }
    } catch (e) {
      return left(const ServerError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return right(unit);
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }
}
