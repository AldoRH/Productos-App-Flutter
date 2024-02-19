import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsService.isLoading) return const LoadingScreen();

    final products = productsService.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [IconButton(
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: const Icon(Icons.login_outlined)
          ) ,]
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = products[index].copy();
            Navigator.pushNamed(context, 'product');
            },
          child: ProductCard(product: products[index],))
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          productsService.selectedProduct = Product(aveilable: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add) ,
        ),

    );
  }
}