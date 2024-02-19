import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decoration.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductService>(context);
    
    return ChangeNotifierProvider(create: ( _ ) => ProductFormProvider(productsService.selectedProduct!),
    child: _ProductScreenBody(productsService: productsService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productsService,
  });


  final ProductService productsService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productsService.selectedProduct!.picture,),
                
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                     icon: const Icon(Icons.arrow_back_ios_new,size: 40,color: Colors.white,),),
                  ),
    
                  Positioned(
                  top: 50,
                  right: 20,
                  child: IconButton(
                    onPressed: () async{
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 100
                      );

                      if(pickedFile == null){
                        return;
                      }

                      productsService.updateSelectedProductImage(pickedFile.path);


                    },
                     icon: const Icon(Icons.camera_alt_outlined,size: 40,color: Colors.white,),),
                  ),
              ],
            ),
            const _ProductForm(),
            const SizedBox(height: 100,),
          ]
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: productsService.isSaving 
        ? null
        : () async{
          if (!productForm.isValidForm()) return;

          final String? imageUrl = await productsService.uploadImage();

          if (imageUrl != null) productForm.product.picture = imageUrl;

          await productsService.saveOrCreateProduct(productForm.product);

        },
        child:productsService.isSaving 
        ? const CircularProgressIndicator(color: Colors.white,)
        : const Icon(Icons.save_outlined,),
        ) ,
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm();

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _builBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10,),

              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if ( value == null || value.isEmpty ) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del precio',
                  labelText: 'Nombre:'
                )
              ),

              const SizedBox(height: 30,),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if( double.tryParse(value) == null){
                    product.price = 0;
                  }else{
                    product.price = double.parse(value);
                  }
                  },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:'
                )
              ),

              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                value: product.aveilable, 
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value)=> productForm.updateAvailability(value)
                ),

              const SizedBox(height: 30,),

            ],
          )
          ),
      ),
    );
  }

  BoxDecoration _builBoxDecoration() {
    return  BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 5),
          blurRadius: 5
        )
      ]
    );
  }
}