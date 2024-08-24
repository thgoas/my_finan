abstract class FailureBank implements Exception {
  final String message;

  FailureBank(this.message);
}

class InvalidIdError extends FailureBank {
  InvalidIdError(super.message);
}

class InvalidDescriptionError extends FailureBank {
  InvalidDescriptionError(super.message);
}

class InvalidFieldsError extends FailureBank {
  InvalidFieldsError(super.message);
}

class GenericError extends FailureBank {
  GenericError(super.message);
}
