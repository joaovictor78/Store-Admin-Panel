import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../design_system/styles/color_palettes.dart';
import '../../design_system/utils/sizes.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  ValueNotifier<int> selectedPageValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    Modular.to.navigate('/start/home/list-products');
    Modular.to.addListener(onChangeRoute);
  }

  void onChangeRoute() {
    if (Modular.to.path.contains('home')) {
      selectedPageValueNotifier.value = 0;
    }

    if (Modular.to.path.contains('settings')) {
      selectedPageValueNotifier.value = 1;
    }
  }

  @override
  void dispose() {
    Modular.to.removeListener(onChangeRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: const RouterOutlet(),
          bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).primaryColor,
                primaryColor: Theme.of(context).colorScheme.secondary,
                textTheme: Theme.of(context).textTheme.copyWith(
                    caption: TextStyle(color: ColorPalettes.accentPrimary)),
              ),
              child: StatefulBuilder(
                  builder: (context, setState) => SizedBox(
                        height: 80,
                        child: BottomAppBar(
                          notchMargin: Sizes.dp8(context),
                          child: ValueListenableBuilder(
                            valueListenable: selectedPageValueNotifier,
                            builder: (context, selectedPage, child) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextButton(
                                    onPressed: () {
                                      Modular.to.navigate(
                                          "/start/home/list-products");
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.home_rounded,
                                          size: 35,
                                          color: selectedPage == 0
                                              ? ColorPalettes.accentPrimary
                                              : ColorPalettes.black12,
                                        ),
                                        Text(
                                          "Home",
                                          style: GoogleFonts.rubik(
                                              fontWeight: selectedPage == 0
                                                  ? FontWeight.w800
                                                  : FontWeight.w400,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextButton(
                                    onPressed: () {
                                      Modular.to.navigate("/start/settings");
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          size: 35,
                                          color: selectedPage == 1
                                              ? ColorPalettes.accentPrimary
                                              : ColorPalettes.black12,
                                        ),
                                        Text(
                                          "Settings",
                                          style: GoogleFonts.rubik(
                                              fontWeight: selectedPage == 1
                                                  ? FontWeight.w800
                                                  : FontWeight.w400,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )))),
    );
  }
}
