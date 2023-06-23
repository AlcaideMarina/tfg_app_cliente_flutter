import 'package:cloud_firestore/cloud_firestore.dart';

import 'billing_data.dart';

class BillingContainerData {
  final Timestamp initDate;
  final Timestamp endDate;
  final BillingData? billingData;

  BillingContainerData(this.initDate, this.endDate, this.billingData);
}
