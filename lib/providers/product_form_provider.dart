import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{
  ProductFormProvider(this.product);

  GlobalKey<FormState> formKey = GlobalKey();


  Product product;

  updateAvailability (bool value){
    product.aveilable = value;
    notifyListeners();
  }


  bool isValidForm(){


    return formKey.currentState?.validate() ?? false;
  }
}