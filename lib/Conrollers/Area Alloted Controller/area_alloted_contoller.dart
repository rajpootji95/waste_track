import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../API Integration/API URL endpoints/api_endpoints.dart';
import '../../Models/Vendor Management Model/Area Search Model/area_search_model.dart';
import '../../Models/Vendor/Area Alloted Model/get_area_alloted_model.dart';
import '../../Models/Vendor/Area Alloted Model/get_order_list_model.dart';
import '../../Models/Vendor/Area Alloted Model/get_vendor_batch_model.dart';
import '../../Utils/Components/custom_sanckbar.dart';
import '../../Utils/Components/dataStroage_database.dart';
import '../../Utils/colors/app_colors.dart';

class AreaAllotedController extends GetxController{

 bool isLoading = false;
  /// get Area Alloted Api
  GetAreaAllotedModel? getAreaAllotedModel;
  Future<GetAreaAllotedModel?> getAreaAllotedApi(BuildContext context,page,limit,searchText,vendorId) async {

    String  userToken = await SharedPref().getToken();
    String token = userToken;
    isLoading = true;
    update();
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.areaAlloted}?page=$page&limit=$limit&searchText=$searchText&requestedVendorId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print(response.requestOptions.uri);
      if (response.statusCode == 200) {
        var result = response.data;

        getAreaAllotedModel = GetAreaAllotedModel.fromJson(result);
        isLoading = false;
        update();
        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        isLoading = false;
        update();
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      isLoading = false;
      update();
      print('Error: $error');
    }
    return getAreaAllotedModel;
  }

  /// get Area Alloted Api
  GetOrderModel? getOrderModel;
  Future<GetOrderModel?> getOrderListApi(BuildContext context,page,limit,searchText,vendorId) async {

    String  userToken = await SharedPref().getToken();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getOrderList}?page=$page&limit=$limit&searchText=$searchText&requestedVendorId=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print("oredeId${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;

        getOrderModel = GetOrderModel.fromJson(result);
        update();
        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getOrderModel;
  }

  /// get Area Alloted Api
  GetVendorBatchListModel? getVendorBatchListModel;
  Future<GetVendorBatchListModel?> getVendorBatchListingApi(BuildContext context,orderId) async {

    String  userToken = await SharedPref().getToken();
    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getVendorBatchListing}?requestedVendorId=$orderId',
        options: Options(
          headers: headers,
        ),
      );
      print("aaaaaaaaaaaaa${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;

        getVendorBatchListModel = GetVendorBatchListModel.fromJson(result);
        update();
        if(result['isTokenExpired']??false){
          CustomSnackBar.mySnackBar(
              context, "${result['message']}");
        }
        update();
        //   CustomSnackBar.mySnackBar(context, "${finalResult.message}");
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return getVendorBatchListModel;
  }


  /// get area UnAssign Api
 Future<void>areaUnAssignApi(BuildContext context,vendorId) async {
   showLoader(context);

    String  userToken = await SharedPref().getToken();

    String token = userToken;
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.areaAssign}?id=${vendorId}',
        options: Options(
          headers: headers,
        ),
      );
      print("this sis${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;
        Navigator.pop(context);
        if(result['status'] == false){

          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(milliseconds: 500), () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
              return CupertinoAlertDialog(
                title: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.green,
                      ),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "${result['message'].toString()}",
                        style: TextStyle(fontSize: 15, color: AppColor.green),
                      ),
                    ),
                  ],
                ), // show pop-up
              );
            },
          );
        }

      } else {
         Navigator.pop(context);
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      Navigator.pop(context);
      print('Error: $error');
    }
    return null;
  }

 /// get area Assign Api
 Future<void> areaAssignApi(String vendorId,areaId,context) async {
   showLoader(context);
   var userToken = await SharedPref().getToken();
   var token = "${userToken}";
   var headers = {
     'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
   };
   var requestData = {
     "vendorId":vendorId,
     "areaId":areaId,
   };
   debugPrint("this Is StatusCode ${requestData}");
   var url = '${Endpoints.baseUrl}${Endpoints.areaAssignList}';
   var dio = Dio();
   (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
   HttpClient()
     ..badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;
   try {
     final response = await dio.post(
       url,
       options: Options(headers: headers),
       data: jsonEncode(requestData), // Encode the request data as JSON
     );
     debugPrint("this Is StatusCode ${response.statusCode}");
     if (response.statusCode == 200) {
       Navigator.pop(context);
       var result = response.data;
       print(result);
       if (result['status'] == true) {
         isLoading = false;
         update();
         showDialog(
           context: context,
           builder: (BuildContext context) {
             Future.delayed(Duration(seconds: 1), () {
               Navigator.pop(context);
             });
             return CupertinoAlertDialog(
               title: Row(
                 children: [
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                       color: AppColor.green,
                     ),
                     child: Icon(
                       Icons.done,
                       color: Colors.white,
                     ),
                   ),
                   SizedBox(
                     width: 5,
                   ),
                   Flexible(
                     child: Text(
                       "Area assigned successfully.",
                       style: TextStyle(
                           fontSize: 14, color: AppColor.green),
                     ),
                   ),
                 ],
               ), // show pop-up
             );
           },
         );
         update();
       } else {
         Navigator.pop(context);
         CustomSnackBar.mySnackBar(context, result['message'].toString());
       }
     } else {
       Navigator.pop(context);

       print("Failed with status code: ${response.statusCode}");
       print("Response data: ${response.data}");
       throw Exception("Something went Wrong!!");
     }
   } catch (e) {
     Navigator.pop(context);
     print("Error: $e");
     throw Exception("Something went Wrong!!");
   }
 }

  ///getAreaSearchApi
  GetAreaSearchModel? searchAreaModel;
  Future<GetAreaSearchModel?> getAreaSearchApi(BuildContext context,searchText) async {
    var userToken = await SharedPref().getToken();
    var token = "${userToken}";
    var headers = {
      'Authorization': 'Bearer $token', // Assuming your token type is 'Bearer'
    };
    var dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
    HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    try {
      Response response = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.searchArea}?&searchText=${searchText}',
        options: Options(
          headers: headers,
        ),
      );
      print("thuis is is s${response.requestOptions.uri}");
      if (response.statusCode == 200) {
        var result = response.data;
        if(result['status']== true){
          var finalResult = GetAreaSearchModel.fromJson(result);
          searchAreaModel = finalResult;

          update();
        }else{
          CustomSnackBar.mySnackBar(context, "${result['message']}");
        }

      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return searchAreaModel;
  }

 showLoader(context){
   return showDialog(context: context,
       builder: (_){
         return CupertinoActivityIndicator(
           color: AppColor.trackCircle,
         );
       });
 }
}