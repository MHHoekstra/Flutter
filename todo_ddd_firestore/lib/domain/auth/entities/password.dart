import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';
import '../../core/entities/value_object.dart';
import '../../core/validators/value_validators.dart';

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  const Password._(
    this.value,
  );

  factory Password(String input) {
    return Password._(validatePassword(input));
  }
}
