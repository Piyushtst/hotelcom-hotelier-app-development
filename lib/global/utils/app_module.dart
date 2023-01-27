import 'package:kiwi/kiwi.dart';
import '../widgets/custom_dialogs.dart';

part "app_module.g.dart";

abstract class AppModule {
  // @Register.singleton(ConnectivityService)
  @Register.singleton(CustomDialogs)
  void configure();
}

void setup() {
  var appModule = _$AppModule();
  appModule.configure();
}
