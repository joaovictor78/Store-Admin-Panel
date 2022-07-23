import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../design_system/styles/color_palettes.dart';
import '../../../../design_system/utils/sizes.dart';
import '../../../../design_system/widgets/custom_dialog_widget.dart';
import '../../domain/entities/product.dart';
import '../bloc/manage_products_bloc.dart';
import '../components/product_card_component.dart';
import '../components/search_bar_component.dart';
import '../events/manage_products_events.dart';
import '../states/manage_products_state.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({Key? key}) : super(key: key);

  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  late ManageProductsBloc bloc;
  @override
  void initState() {
    bloc = Modular.get<ManageProductsBloc>();
    bloc.add(FetchProductsEvent(filterTerm: ""));
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<ManageProductsBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed('/manage_products/create-product');
        },
        child: Icon(
          Icons.add,
          color: ColorPalettes.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Sizes.dp29(context) * 8,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorPalettes.lightYellow, ColorPalettes.lightPrimary],
                stops: const [
                  0.1,
                  0.4,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        "Admin Painel Store",
                        style: GoogleFonts.rubik(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Sizes.dp19(context)),
                Text(
                  "Produtos",
                  style: GoogleFonts.rubik(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                SearchBarComponent(
                  onChanged: (term) =>
                      bloc.add(FetchProductsEvent(filterTerm: term)),
                )
              ],
            ),
          ),
          Expanded(
              child: BlocBuilder<ManageProductsBloc, ManageProductsState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: (() {
                          if (state is LoadingManageProductsState) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ));
                          }
                          if (state is ResultManageProductsState) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.products.length,
                                itemBuilder: (_, index) {
                                  return ProductCardComponent(
                                    product: state.products[index],
                                    onPressedSettings: () {
                                      _showCustomBottomSheet(
                                          context, state.products[index]);
                                    },
                                  );
                                });
                          }
                        }()));
                  }))
        ],
      ),
    );
  }
}

void _showCustomBottomSheet(context, Product productSelected) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext bc) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 4,
                width: 100,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "O que você deseja fazer com\nesse produto?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _customCircleButton(
                      "Editar",
                      Colors.black,
                      "assets/image-icons/box-icon.png",
                      context, onPressed: () {
                    Modular.to.pushNamed('/manage_products/update-product',
                        arguments: productSelected);
                  }),
                  SizedBox(width: Sizes.dp19(context)),
                  _customCircleButton("Remover", Colors.red,
                      "assets/image-icons/remove-icon.png", context,
                      onPressed: () => _showCustomDialogForRemoveProduct(
                              context, onCanceled: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          }, onConfirmed: () {
                            final bloc = Modular.get<ManageProductsBloc>();
                            bloc.add(
                                RemoveProductEvent(id: productSelected.id));
                            Navigator.of(context, rootNavigator: true).pop();
                          }))
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      });
}

Widget _customCircleButton(
    String tag, Color color, String pathImage, BuildContext context,
    {void Function()? onPressed}) {
  return TextButton(
    onPressed: onPressed,
    child: Column(
      children: [
        CustomPaint(
          painter: CirclePainter(color: color),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset(pathImage),
          ),
        ),
        SizedBox(height: Sizes.dp11(context)),
        Text(
          tag,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 15, color: color, fontWeight: FontWeight.w700),
        )
      ],
    ),
  );
}

class CirclePainter extends CustomPainter {
  late Color color;
  late Paint _paint;
  CirclePainter({this.color = Colors.black}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void _showCustomDialogForRemoveProduct(BuildContext context,
    {void Function()? onConfirmed, void Function()? onCanceled}) {
  Navigator.pop(context);

  showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return CustomDialogWidget(
          tag: "Quer excluir esse produto?",
          description:
              "Ao confirmar, não será possivel recuperar\no produto excluido. ",
          confirmedButtonDescription: "Excluir produto",
          cancelButtonDescription: "Cancelar",
          onConfirmed: onConfirmed,
          onCanceled: onCanceled,
        );
      });
}
