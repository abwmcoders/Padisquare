import 'package:shared_preferences/shared_preferences.dart';

class SavedProductsService {
  static const String _savedProductsKey = 'saved_products';
  static SavedProductsService? _instance;
  SharedPreferences? _prefs;

  SavedProductsService._();

  static Future<SavedProductsService> getInstance() async {
    if (_instance == null) {
      _instance = SavedProductsService._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<List<int>> getSavedProductIds() async {
    final List<String>? savedIds = _prefs?.getStringList(_savedProductsKey);
    if (savedIds == null) return [];
    return savedIds.map((id) => int.parse(id)).toList();
  }

  Future<bool> isProductSaved(int productId) async {
    final savedIds = await getSavedProductIds();
    return savedIds.contains(productId);
  }

  Future<void> toggleSaveProduct(int productId) async {
    final savedIds = await getSavedProductIds();
    if (savedIds.contains(productId)) {
      savedIds.remove(productId);
    } else {
      savedIds.add(productId);
    }
    await _prefs?.setStringList(
      _savedProductsKey,
      savedIds.map((id) => id.toString()).toList(),
    );
  }

  Future<void> saveProduct(int productId) async {
    final savedIds = await getSavedProductIds();
    if (!savedIds.contains(productId)) {
      savedIds.add(productId);
      await _prefs?.setStringList(
        _savedProductsKey,
        savedIds.map((id) => id.toString()).toList(),
      );
    }
  }

  Future<void> unsaveProduct(int productId) async {
    final savedIds = await getSavedProductIds();
    if (savedIds.contains(productId)) {
      savedIds.remove(productId);
      await _prefs?.setStringList(
        _savedProductsKey,
        savedIds.map((id) => id.toString()).toList(),
      );
    }
  }

  Future<void> clearAllSavedProducts() async {
    await _prefs?.remove(_savedProductsKey);
  }
}

