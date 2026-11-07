class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String currency;
  final String image;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  // JSON -> Product
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = (json['specs'] as Map<String, dynamic>?) ?? {};
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '',
      currency: json['currency'] as String? ?? 'USD',
      image: json['image'] as String? ?? '',
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  // Product -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }

  // "https://wantapi.com/assets/images/iphone.png" -> "assets/images/iphone.png"
  String get imageAsset => 'assets/images/${image.split('/').last}';

  // "$1,299" -> 1299.0 (sepet toplamı için)
  double get priceValue =>
      double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

  // Filtreleme için ürünün kategorisi
  String get category {
    final n = name.toLowerCase();
    if (n.contains('iphone')) return 'iPhone';
    if (n.contains('mac')) return 'Mac';
    if (n.contains('ipad')) return 'iPad';
    if (n.contains('watch')) return 'Watch';
    if (n.contains('airpods') || n.contains('homepod')) return 'Audio';
    return 'Other';
  }
}
