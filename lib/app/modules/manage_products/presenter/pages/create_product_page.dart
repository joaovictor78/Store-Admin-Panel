import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:store_admin_panel/app/modules/manage_products/domain/dtos/product_dto.dart';
import '../../../../design_system/styles/color_palettes.dart';
import '../../../../design_system/utils/sizes.dart';
import '../../../../design_system/widgets/custom_button_widget.dart';
import '../../../../design_system/widgets/custom_input_widget.dart';
import '../../domain/entities/product.dart';
import '../bloc/manage_products_bloc.dart';
import '../components/custom_description_input_component.dart';
import '../components/custom_rating_input_component.dart';
import '../components/pre_view_product_card_component.dart';
import '../events/manage_products_events.dart';
import '../models/products_model.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  late ManageProductsBloc manageProductsBloc;
  late MoneyMaskedTextController priceTextController;
  ValueNotifier<ProductModel> productModel =
      ValueNotifier<ProductModel>(ProductModel(image: File("")));
  final ImagePicker _picker = ImagePicker();

  double ratting = 0;
  @override
  void initState() {
    manageProductsBloc = Modular.get<ManageProductsBloc>();
    ratting = 3;
    priceTextController = MoneyMaskedTextController(
        leftSymbol: 'R\$ ',
        decimalSeparator: ',',
        thousandSeparator: '.',
        initialValue: 0);
    super.initState();
  }

  @override
  void dispose() {
    priceTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(stops: const [
              0.2,
              5
            ], colors: [
              ColorPalettes.lightYellow,
              ColorPalettes.lightPrimary,
            ]),
          ),
        ),
        title: Text("Criar Produto",
            style:
                GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(LineIcons.angleLeft)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButtonWidget(
        title: "CRIAR PRODUTO",
        onPressed: () {
          String messageError = productModel.value.verify();
          if (messageError.isEmpty) {
            manageProductsBloc
                .add(CreateProductEvent(productModel.value.convertToDTO()));
          } else {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(messageError),
              action: SnackBarAction(
                textColor: Colors.white,
                label: 'Ok',
                onPressed: () {},
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: productModel,
            builder: (context, ProductModel product, __) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Sizes.dp29(context)),
                    Text("Pré-Visualização:",
                        style: GoogleFonts.inter(fontSize: 15)),
                    SizedBox(height: Sizes.dp21(context)),
                    PreViewProductCardComponent(
                        productModel: product,
                        onEditImage: () async {
                          XFile? imageSelected = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (imageSelected != null) {
                            productModel.value = product.copyWith(
                                image: File(imageSelected.path));
                          }
                        }),
                    SizedBox(height: Sizes.dp21(context)),
                    CustomInputWidget(
                      hintText: "Informe o nome",
                      labelText: "Nome",
                      icon: LineIcons.edit,
                      onChanged: (text) {
                        productModel.value = product.copyWith(name: text);
                      },
                    ),
                    CustomInputWidget(
                      hintText: "Informe o tipo",
                      labelText: "Tipo",
                      onChanged: (text) {
                        productModel.value = product.copyWith(type: text);
                      },
                      icon: LineIcons.alternateSortAlphabeticalUp,
                    ),
                    CustomInputWidget(
                      hintText: "Informe o preço",
                      labelText: "Preço",
                      keyboardType: TextInputType.number,
                      controller: priceTextController,
                      onChanged: (value) {
                        productModel.value = product.copyWith(
                            price: priceTextController.numberValue);
                      },
                      icon: LineIcons.coins,
                    ),
                    CustomDescriptionInputComponent(onChanged: (text) {
                      productModel.value = product.copyWith(description: text);
                    }),
                    CustomRatingInputComponent(onRatingUpdate: (rating) {
                      productModel.value = product.copyWith(ratting: rating);
                    }),
                    SizedBox(height: Sizes.dp29(context) * 3)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
