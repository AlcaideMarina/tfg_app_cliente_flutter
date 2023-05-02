import 'dart:convert';

class DBOrderFieldData{
  final double? xlBoxPrice;
  final int? xlBoxQuantity;
  final double? xlDozenPrice;
  final int? xlDozenQuantity;
  final double? lBoxPrice;
  final int? lBoxQuantity;
  final double? lDozenPrice;
  final int? lDozenQuantity;
  final double? mBoxPrice;
  final int? mBoxQuantity;
  final double? mDozenPrice;
  final int? mDozenQuantity;
  final double? sBoxPrice;
  final int? sBoxQuantity;
  final double? sDozenPrice;
  final int? sDozenQuantity;

  DBOrderFieldData(
    this.xlBoxPrice, 
    this.xlBoxQuantity, 
    this.xlDozenPrice, 
    this.xlDozenQuantity, 
    this.lBoxPrice, 
    this.lBoxQuantity, 
    this.lDozenPrice, 
    this.lDozenQuantity, 
    this.mBoxPrice, 
    this.mBoxQuantity, 
    this.mDozenPrice, 
    this.mDozenQuantity, 
    this.sBoxPrice, 
    this.sBoxQuantity, 
    this.sDozenPrice, 
    this.sDozenQuantity
  );
  
}