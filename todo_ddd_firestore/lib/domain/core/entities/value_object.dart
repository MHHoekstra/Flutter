import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../errors/errors.dart';
import '../failures/failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  /// If contains an [ValueFailure] throws an [UnexpectedValueError], else return the [value]
  T getOrCrash() {
    return value.fold((l) => throw UnexpectedValueError(l), (r) => r);
  }

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'ValueObject($value)';
  }
}
