import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../design_system/styles/color_palettes.dart';
import '../../../../design_system/utils/sizes.dart';
import '../../../../design_system/widgets/custom_button_widget.dart';
import '../../../../design_system/widgets/custom_input_widget.dart';
import '../../domain/dtos/product_dto.dart';
import '../../domain/entities/product.dart';
import '../../domain/value_objects/product_image_vo.dart';
import '../bloc/manage_products_bloc.dart';
import '../components/custom_description_input_component.dart';
import '../components/custom_rating_input_component.dart';
import '../components/pre_view_product_card_component.dart';
import '../events/manage_products_events.dart';
import '../models/products_model.dart';

// ignore: must_be_immutable
class UpdateProductPage extends StatefulWidget {
  Product product;
  // ignore: use_key_in_widget_constructors
  UpdateProductPage(this.product);

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  late ManageProductsBloc manageProductsBloc;
  late MoneyMaskedTextController priceTextController;
  ValueNotifier<ProductModel> productModel =
      ValueNotifier<ProductModel>(ProductModel());
  final ImagePicker _picker = ImagePicker();

  double ratting = 0;
  @override
  void initState() {
    manageProductsBloc = Modular.get<ManageProductsBloc>();
    ratting = widget.product.rating;
    priceTextController = MoneyMaskedTextController(
        leftSymbol: 'R\$ ',
        decimalSeparator: ',',
        thousandSeparator: '.',
        initialValue: widget.product.price);
    productModel.value = ProductModel.from(widget.product);
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
        title: Text("Editar Produto",
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
        title: "SALVAR ALTERAÇÕES",
        onPressed: () {
          String messageError = productModel.value.verify();
          if (messageError.isEmpty) {
            ProductDTO productDTO = productModel.value.convertToDTO();
            productDTO.id = widget.product.id;
            manageProductsBloc.add(UpdateProductEvent(productDTO));
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
                                productImageData: ProductImageVO(
                                    imagePath: imageSelected.path));
                          }
                        }),
                    SizedBox(height: Sizes.dp21(context)),
                    CustomInputWidget(
                      hintText: "Informe o nome",
                      labelText: "Nome",
                      initialValue: product.name,
                      icon: LineIcons.edit,
                      onChanged: (text) {
                        productModel.value = product.copyWith(name: text);
                      },
                    ),
                    CustomInputWidget(
                      hintText: "Informe o tipo",
                      labelText: "Tipo",
                      initialValue: product.type,
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
                    CustomDescriptionInputComponent(
                        initialValue: product.description,
                        onChanged: (text) {
                          productModel.value =
                              product.copyWith(description: text);
                        }),
                    CustomRatingInputComponent(
                        initialRating: product.rating,
                        onRatingUpdate: (rating) {
                          productModel.value = product.copyWith(rating: rating);
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
