
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:productos_app/models/models.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';



class ProductService extends ChangeNotifier{

  final String? _baseUrl= dotenv.env['FIRE_BASE'];
  final List<Product> products = [];
  late Product? selectedProduct;
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  final storage = const FlutterSecureStorage();

  
  ProductService(){
    loadProducts();
  }


  Future loadProducts() async {

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl!,'products.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode( resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id =  key;
      products.add(tempProduct);
    });

    isLoading=false;
    notifyListeners();

    return products;
  }


  Future saveOrCreateProduct(Product product) async{
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      await createProduct(product);
    }else{
       await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();

  }


  Future<String> updateProduct(Product product)async{
    final url = Uri.https(_baseUrl!,'products/${product.id}.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    await http.put(url, body: product.toJson());
    // final decodeData = json.decode(resp.body);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product)async{
    final url = Uri.https(_baseUrl!,'products.json',{
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.post(url, body: product.toJson());
    final decodeData = json.decode(resp.body);

    product.id = decodeData['name'];

    products.add(product);

    return product.id!;

  }


  void updateSelectedProductImage(String path){

    selectedProduct?.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();

  }

  Future<String?> uploadImage() async{
    if(newPictureFile==null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(dotenv.env['CLOUD_NAME']!);
    
    final imageUploadRequest = http.MultipartRequest( 'POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode !=200 && resp.statusCode != 201) return null;

    newPictureFile = null;

    final decodeData = json.decode(resp.body);

    return decodeData['secure_url'];
  }
}