import 'package:my_finan/interactor/errors/failure_account.dart';

class NoElementDataSourceError extends FailureAccount {
  NoElementDataSourceError(super.message);
}

class DataSourceException extends FailureAccount {
  DataSourceException(super.message);
}
