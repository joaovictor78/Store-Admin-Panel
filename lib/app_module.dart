import 'package:flutter_modular/flutter_modular.dart';
import 'app/modules/manage_products/manage_products_module.dart';
import 'app/modules/splash_screen/splash_screen_module.dart';
import 'app/modules/start/start_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SplashScreenModule()),
        ModuleRoute('/start', module: StartModule()),
        ModuleRoute('/manage_products', module: ManageProductsModule()),
      ];
}
