sealed class Either<L, R> {
  const Either();

  factory Either.left(L l) => Left(l);
  factory Either.right(R r) => Right(r);

  T fold<T>(T Function(L) left, T Function(R) right) => switch (this) {
        Left(:final value) => left(value),
        Right(:final value) => right(value),
      };

  bool isLeft() => switch (this) {
        Left() => true,
        Right() => false,
      };

  bool isRight() => !isLeft();
}

class Left<L, R> extends Either<L, R> {
  final L _l;
  const Left(this._l);
  L get value => _l;
}

class Right<L, R> extends Either<L, R> {
  final R _r;
  const Right(this._r);
  R get value => _r;
}

/// Extension on Either to provide left and right getters
extension EitherExtension<L, R> on Either<L, R> {
  /// Gets the left value if this is a Left, throws if it's a Right
  L get left {
    return fold((left) => left, (right) => throw StateError('Either is Right, not Left'));
  }

  /// Gets the right value if this is a Right, throws if it's a Left
  R get right {
    return fold((left) => throw StateError('Either is Left, not Right'), (right) => right);
  }
}
