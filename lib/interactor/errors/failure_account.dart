abstract class FailureAccount implements Exception {
  final String message;

  FailureAccount(this.message);
}

class InvalidIdError extends FailureAccount {
  InvalidIdError(super.message);
}

class InvalidDescriptionError extends FailureAccount {
  InvalidDescriptionError(super.message);
}

class InvalidFieldsError extends FailureAccount {
  InvalidFieldsError(super.message);
}

class GenericError extends FailureAccount {
  GenericError(super.message);
}
