import 'package:my_finan/interactor/errors/failure_bank.dart';

class NoElementDataSourceError extends FailureBank {
  NoElementDataSourceError(super.message);
}

class DataSourceException extends FailureBank {
  DataSourceException(super.message);
}
