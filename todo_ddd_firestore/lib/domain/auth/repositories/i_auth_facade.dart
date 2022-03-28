import 'package:dartz/dartz.dart';

import '../failures/auth_failure.dart';
import '../entities/email_address.dart';
import '../entities/password.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress email,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
