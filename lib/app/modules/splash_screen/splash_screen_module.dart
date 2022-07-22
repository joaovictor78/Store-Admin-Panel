import 'package:flutter_modular/flutter_modular.dart';

import 'splash_screen_page.dart';

class SplashScreenModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (_, __) => const SplashScreenPage())];
}
