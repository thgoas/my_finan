import 'package:get_it/get_it.dart';
import 'package:my_finan/data/repositories/account_repository_imp.dart';
import 'package:my_finan/data/repositories/group_repository_imp.dart';
import 'package:my_finan/data/sources/account_data_source.dart';
import 'package:my_finan/data/sources/group_data_source.dart';
import 'package:my_finan/data/sources/local/account_data_source_sqlite.dart';
import 'package:my_finan/data/sources/local/group_data_source_sqlite.dart';
import 'package:my_finan/interactor/controllers/account_controller.dart';
import 'package:my_finan/interactor/controllers/group_controller.dart';
import 'package:my_finan/interactor/repositories/account_repository.dart';
import 'package:my_finan/interactor/repositories/group_respository.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;
    //data sources
    getIt.registerLazySingleton<GroupDataSource>(() => GroupDataSourceSqlite());
    getIt.registerLazySingleton<AccountDataSource>(
        () => AccountDataSourceSqlite());
    //repository
    getIt.registerLazySingleton<GroupRepository>(
        () => GroupRepositoryImp(getIt()));
    getIt.registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImp(getIt()));

    // usecases
    getIt.registerFactory<GroupController>(() => GroupController(getIt()));
    getIt.registerFactory<AccountController>(() => AccountController(getIt()));
  }
}
