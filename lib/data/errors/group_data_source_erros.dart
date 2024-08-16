import 'package:my_finan/interactor/errors/failure_group.dart';

class NoElementDataSourceError extends FailureGroup {
  NoElementDataSourceError(super.message);
}

class DataSourceException extends FailureGroup {
  DataSourceException(super.message);
}
