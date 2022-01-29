class Quantity<T> {

  int _amount = 0;
  String unit = "";

  T type;

  Quantity(int amount, this.unit, this.type) {
    _amount = amount;
  }

  int getAmount(int yields)
  {
    return yields * _amount;
  }

  String asString(int yields)
  {
    int total = getAmount(yields);
    String name = type.toString();
    return '$total $unit of $name';
  }
}