import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';
import '../../core/entities/value_object.dart';
import '../../core/validators/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(
    this.value,
  );
}
