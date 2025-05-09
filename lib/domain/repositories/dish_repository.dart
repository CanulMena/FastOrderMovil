import 'package:fast_order/domain/index.dart';

abstract class DishRepository {

  Future<List<Dish>> getAvailableDishes();

}