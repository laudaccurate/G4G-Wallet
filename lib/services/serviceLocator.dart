// @dart=2.9
import 'package:get_it/get_it.dart';
import '../utils/global_services.dart';
import 'localStorage.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerLazySingleton<LocalStorageService>(() => instance);
  locator.registerLazySingleton<GlobalServices>(() => GlobalServices());
  // LocalStorageService
}
