import 'package:get_it/get_it.dart';
import 'package:my_finan/data/repositories/group_repository_imp.dart';
import 'package:my_finan/data/sources/group_data_source.dart';
import 'package:my_finan/data/sources/local/group_data_source_sqlite.dart';
import 'package:my_finan/interactor/models/group_model.dart';
import 'package:my_finan/interactor/repositories/group_respository.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;
    //data sources
    getIt.registerLazySingleton<GroupDataSource>(() => GroupDataSourceSqlite());
    //repository
    getIt.registerLazySingleton<GroupRepository>(
        () => GroupRepositoryImp(getIt()));
    //use cases
    // getIt.registerLazySingleton<NewGroupUseCase>(
    //     () => NewGroupUseCaseImp(getIt()));
    // getIt.registerLazySingleton<UpdateGroupUseCase>(
    //     () => UpdateGroupUseCaseImp(getIt()));
    // getIt.registerLazySingleton<GetAllGroupsUseCase>(
    //     () => GetAllGroupsUseCaseImp(getIt()));
    // getIt.registerLazySingleton<GetGroupByDescriptionUseCase>(
    //     () => GetGroupByDescriptionUseCaseImp(getIt()));
    // getIt.registerLazySingleton<GetGroupByIdUseCase>(
    //     () => GetGroupByIdUseCaseImp(getIt()));
    // getIt.registerLazySingleton<DeleteGroupUseCase>(
    //     () => DeleteGroupUseCaseImp(getIt()));

    getIt.registerFactory<GroupModel>(() => GroupModel(getIt()));
  }
}
