import 'package:get_it/get_it.dart';
import 'package:mvvm_sqlite_repository_getIt/repository/note_repos.dart';
import '../data/db_helper.dart';
final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DBHelper>(() => DBHelper());
  getIt.registerLazySingleton<NoteRepository>(() => NoteRepository(getIt<DBHelper>()));
}