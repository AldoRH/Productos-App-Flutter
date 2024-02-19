import 'dart:convert';

class Product {
    bool aveilable;
    String name;
    String? picture;
    double price;
    String? id;

    Product({
        required this.aveilable,
        required this.name,
        this.picture,
        required this.price,
        this.id
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        aveilable: json["aveilable"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "aveilable": aveilable,
        "name": name,
        "picture": picture,
        "price": price,
    };


    Product copy() => Product(
      aveilable: aveilable,
      name: name,
      price: price,
      picture: picture,
      id: id
      );
}
