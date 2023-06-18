class EggPricesData {
  final num? xlBox;
  final num? xlDozen;
  final num? lBox;
  final num? lDozen;
  final num? mBox;
  final num? mDozen;
  final num? sBox;
  final num? sDozen;

  EggPricesData(this.xlBox, this.xlDozen, this.lBox, this.lDozen, this.mBox,
      this.mDozen, this.sBox, this.sDozen);

  Map<String, dynamic> toMap() => {
        'xl_box': xlBox,
        'xl_dozen': xlDozen,
        'l_box': lBox,
        'l_dozen': lDozen,
        'm_box': mBox,
        'm_dozen': mDozen,
        's_box': sBox,
        's_dozen': sDozen,
      };
}
