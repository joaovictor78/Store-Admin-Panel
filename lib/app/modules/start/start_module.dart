import 'package:flutter_modular/flutter_modular.dart';
import '../manage_products/manage_products_module.dart';
import '../settings/settings_module.dart';
import 'start_page.dart';

class StartModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/",
            child: (context, _) => const StartPage(),
            children: [
              ModuleRoute('/home',
                  module: ManageProductsModule(),
                  transition: TransitionType.fadeIn),
              ModuleRoute('/settings',
                  module: SettingsModule(), transition: TransitionType.fadeIn)
            ],
            transition: TransitionType.fadeIn)
      ];
}
