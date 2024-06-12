class GetVendorOrderDetailsModel {
  GetVendorOrderDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory GetVendorOrderDetailsModel.fromJson(Map<String, dynamic> json){
    return GetVendorOrderDetailsModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.orderId,
    required this.vendorId,
    required this.qty,
    required this.qtyPrice,
    required this.subTotal,
    required this.revisionCommissionPercentage,
    required this.revisionCommissionAmount,
    required this.nylonProdCommissionPerrollAmount,
    required this.nylonProdCommissionTotalAmount,
    required this.orderTotal,
    required this.total,
    required this.perQtyQrcodePriceBeforePercentage,
    required this.perQtyQrcodePrice,
    required this.vendorPickupPercentage,
    required this.orderTotalAfterNylonProdCommission,
    required this.orderTotalAfterVendorPurchaseCommission,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.invoiceNo,
    required this.referenceNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.vendorInfo,
    required this.orderStatusText,
    required this.paymentStatusText,
    required this.orderSharing,
    required this.invoiceFrom,
    required this.bankInfo,
  });

  final String? id;
  final String? orderId;
  final String? vendorId;
  final num? qty;
  final num? qtyPrice;
  final num? subTotal;
  final num? revisionCommissionPercentage;
  final num? revisionCommissionAmount;
  final num? nylonProdCommissionPerrollAmount;
  final num? nylonProdCommissionTotalAmount;
  final num? orderTotal;
  final num? total;
  final num? perQtyQrcodePriceBeforePercentage;
  final num? perQtyQrcodePrice;
  final num? vendorPickupPercentage;
  final num? orderTotalAfterNylonProdCommission;
  final num? orderTotalAfterVendorPurchaseCommission;
  final String? paymentMethod;
  final num? paymentStatus;
  final num? orderStatus;
  final String? invoiceNo;
  final String? referenceNo;
  final String? createdAt;
  final DateTime? updatedAt;
  final num? v;
  final InvoiceFrom? vendorInfo;
  final String? orderStatusText;
  final String? paymentStatusText;
  final List<OrderSharing> orderSharing;
  final InvoiceFrom? invoiceFrom;
  final BankInfo? bankInfo;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["_id"],
      orderId: json["orderId"],
      vendorId: json["vendorId"],
      qty: json["qty"],
      qtyPrice: json["qty_price"],
      subTotal: json["sub_total"],
      revisionCommissionPercentage: json["revision_commission_percentage"],
      revisionCommissionAmount: json["revision_commission_amount"],
      nylonProdCommissionPerrollAmount: json["nylon_prod_commission_perroll_amount"],
      nylonProdCommissionTotalAmount: json["nylon_prod_commission_total_amount"],
      orderTotal: json["order_total"],
      total: json["total"],
      perQtyQrcodePriceBeforePercentage: json["per_qty_qrcode_price_before_percentage"],
      perQtyQrcodePrice: json["per_qty_qrcode_price"],
      vendorPickupPercentage: json["vendor_pickup_percentage"],
      orderTotalAfterNylonProdCommission: json["order_total_after_nylon_prod_commission"],
      orderTotalAfterVendorPurchaseCommission: json["order_total_after_vendor_purchase_commission"],
      paymentMethod: json["payment_method"],
      paymentStatus: json["payment_status"],
      orderStatus: json["order_status"],
      invoiceNo: json["invoiceNo"],
      referenceNo: json["referenceNo"],
      createdAt: json["createdAt"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      vendorInfo: json["vendorInfo"] == null ? null : InvoiceFrom.fromJson(json["vendorInfo"]),
      orderStatusText: json["orderStatusText"],
      paymentStatusText: json["paymentStatusText"],
      orderSharing: json["orderSharing"] == null ? [] : List<OrderSharing>.from(json["orderSharing"]!.map((x) => OrderSharing.fromJson(x))),
      invoiceFrom: json["invoiceFrom"] == null ? null : InvoiceFrom.fromJson(json["invoiceFrom"]),
      bankInfo: json["bankInfo"] == null ? null : BankInfo.fromJson(json["bankInfo"]),
    );
  }

}

class BankInfo {
  BankInfo({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolderName,
    required this.iban,
    required this.ifsc,
    required this.vendorId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? bankName;
  final String? accountNumber;
  final String? accountHolderName;
  final String? iban;
  final String? ifsc;
  final String? vendorId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory BankInfo.fromJson(Map<String, dynamic> json){
    return BankInfo(
      id: json["_id"],
      bankName: json["bankName"],
      accountNumber: json["accountNumber"],
      accountHolderName: json["accountHolderName"],
      iban: json["iban"],
      ifsc: json["ifsc"],
      vendorId: json["vendorId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}

class InvoiceFrom {
  InvoiceFrom({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.companyName,
    required this.companyAddress,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? companyName;
  final String? companyAddress;

  factory InvoiceFrom.fromJson(Map<String, dynamic> json){
    return InvoiceFrom(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      companyName: json["companyName"],
      companyAddress: json["companyAddress"],
    );
  }

}

class OrderSharing {
  OrderSharing({
    required this.id,
    required this.sharingPercentage,
    required this.sharingAmount,
    required this.revenueModelId,
    required this.companyName,
  });

  final String? id;
  final num? sharingPercentage;
  final num? sharingAmount;
  final RevenueModelId? revenueModelId;
  final String? companyName;

  factory OrderSharing.fromJson(Map<String, dynamic> json){
    return OrderSharing(
      id: json["_id"],
      sharingPercentage: json["sharingPercentage"],
      sharingAmount: json["sharingAmount"],
      revenueModelId: json["revenueModelId"] == null ? null : RevenueModelId.fromJson(json["revenueModelId"]),
      companyName: json["companyName"],
    );
  }

}

class RevenueModelId {
  RevenueModelId({
    required this.id,
    required this.companyName,
    required this.roleId,
  });

  final String? id;
  final String? companyName;
  final String? roleId;

  factory RevenueModelId.fromJson(Map<String, dynamic> json){
    return RevenueModelId(
      id: json["_id"],
      companyName: json["companyName"],
      roleId: json["roleId"],
    );
  }

}
