
class BillingData {
  double paymentByCash = 0;
  double paymentByReceipt = 0;
  double paymentByTransfer = 0;
  double paid = 0;
  double toBePaid = 0;
  double totalPrice = 0;

  BillingData(
    this.paymentByCash,
    this.paymentByReceipt,
    this.paymentByTransfer,
    this.paid,
    this.toBePaid,
    this.totalPrice
  );

}
