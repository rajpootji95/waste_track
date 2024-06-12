import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_track/Conrollers/Area%20Alloted%20Controller/area_alloted_contoller.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/Components/myShimmer.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

import '../../../../../Models/Vendor Management Model/Area Search Model/area_search_model.dart';
import '../../../../../Utils/Components/custom_sanckbar.dart';
import '../../../../../Utils/Components/custom_textfield.dart';

class AllVendorAreasAlloted extends StatefulWidget {
  final vendorId;
   final isBool;
  const AllVendorAreasAlloted({super.key,this.vendorId,this.isBool});

  @override
  State<AllVendorAreasAlloted> createState() => _AllVendorAreasAllotedState();
}

class _AllVendorAreasAllotedState extends State<AllVendorAreasAlloted> {
  String? dropdownValue;
  var areaSearchController = TextEditingController();
  String? areaId;
// Declare a variable to store the selected value
  void initState() {
    // TODO: implement initState

    super.initState();
    callNylonListApi();

  }
  AreaAllotedController allotedController=AreaAllotedController();
  callNylonListApi()async{
    await allotedController.getAreaAllotedApi(context, "", "", "",widget.vendorId);

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.vendorId);
    return Container(
      child: Column(
        children: [
         widget.isBool == true ? SizedBox.shrink():Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   padding: EdgeInsets.only(left: 10, right: 10),
              //   width: MediaQuery.of(context).size.width * 0.7,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: DropdownButton<String>(
              //     value: dropdownValue,
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         dropdownValue = newValue;
              //       });
              //     },
              //     isExpanded: true,
              //     icon: Icon(
              //       Icons.arrow_drop_down,
              //       color: AppColor.green,
              //     ),
              //     underline: Container(),
              //     hint: Text(
              //       'Select Area',
              //       style: TextStyle(
              //           color: AppColor.black.withOpacity(0.4), fontSize: 12),
              //     ),
              //     items: [
              //       DropdownMenuItem(
              //         value: "Enumeral1",
              //         child: Text("Enumeral  Solutions Limited",
              //             style:
              //                 TextStyle(color: AppColor.black, fontSize: 12)),
              //       ),
              //       DropdownMenuItem(
              //         value: "Enumeral2",
              //         child: Text(
              //           "Enumeral  Solutions Limited",
              //           style: TextStyle(color: AppColor.black, fontSize: 12),
              //         ),
              //       ),
              //       DropdownMenuItem(
              //         value: "Enumeral3",
              //         child: Text("Enumeral  Solutions Limited",
              //             style:
              //                 TextStyle(color: AppColor.black, fontSize: 12)),
              //       ),
              //       DropdownMenuItem(
              //         value: "Enumeral4",
              //         child: Text("Enumeral  Solutions Limited",
              //             style:
              //                 TextStyle(color: AppColor.black, fontSize: 12)),
              //       ),
              //       DropdownMenuItem(
              //         value: "Enumeral5",
              //         child: Text("Enumeral  Solutions Limited",
              //             style:
              //                 TextStyle(color: AppColor.black, fontSize: 12)),
              //       ),
              //       // Add more DropdownMenuItem widgets as needed
              //     ],
              //   ),
              // ),

              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width * 0.7,
                child: CustomTextField(
                  controller: areaSearchController,
                  hintText: "Search Area",
                  readOnly: true,
                  onTap: (){
                    allotedController.getAreaSearchApi(context, "").then(
                            (value) {
                          if(value != null) {
                            showAreasList(allotedController)
                                ?.then((value) {
                              areaSearchController.text =
                                  value;
                            });
                          }else{
                            CustomSnackBar.mySnackBar(context, "Something Went Wrong!!");
                          }
                        });
                  },
                  hintStyle: TextStyle(
                      color: AppColor.lightGrey,
                      fontSize: 13,
                      fontFamily: AppFont.poppinsRegular),
                ),
              ),
              InkWell(
                onTap: (){
                allotedController.areaAssignApi(widget.vendorId,areaId, context).then((value)async{
                  await allotedController.getAreaAllotedApi(context, "1", "10", "",widget.vendorId);
                  setState(() {

                  });
                });
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.greenLight.withOpacity(0.5)),
                  child: Text(
                    'Assign',
                    style: TextStyle(color: AppColor.green),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: allotedController.getAreaAllotedModel?.data == null ?myShimmer():allotedController.getAreaAllotedModel?.data.length == 0 ? Center(child: Text("No allotted area list !!")): ListView.builder(
                itemCount:allotedController.getAreaAllotedModel?.data.length ,
                itemBuilder: (context, index) {
                  var areaList = allotedController.getAreaAllotedModel?.data[index];
                  return Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 15),
                    margin: const EdgeInsets.only(bottom: 6),
                    child: Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Area:",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 12,
                                  fontFamily: AppFont.poppinsSemiBold),
                            ),
                            Text(
                              "${areaList?.areaName}",
                              style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 11,
                                  fontFamily: AppFont.poppinsLight),
                            ),
                            GestureDetector(
                              onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Column(
                                    children: [
                                      Text(
                                        "Are you sure you want to Unassign this area?",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColor.black),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(9),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        7),
                                                color: AppColor.green,
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontFamily: AppFont
                                                        .poppinsLight,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              allotedController.areaUnAssignApi(context,areaList?.id).then((v) async{
                                                await allotedController.getAreaAllotedApi(context, "1", "10", "",widget.vendorId);
                                                setState(() {
                                                });
                                                Navigator.pop(context);
                                              });

                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 10,
                                                  top: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        7),
                                                color: AppColor.green,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'yes',
                                                  style: TextStyle(
                                                      fontFamily: AppFont
                                                          .poppinsLight,
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ), // show pop-up
                                );
                              },
                            );
                              },
                              child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.redLight.withOpacity(0.5)),
                            child: Text(
                              '${areaList?.statusText}',
                              style: TextStyle(
                                  color: Colors.red, fontSize: 11),
                            ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<String>? showAreasList(AreaAllotedController allotedController) async {
    ValueNotifier<GetAreaSearchModel> searchAreaModel = ValueNotifier(allotedController.searchAreaModel!);

    (String?,String?)area = await showDialog(
        context: context,
        builder: (_){
          return Dialog(
            child:
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    hintText: "Search Area",
                    onChanged: (val){
                      allotedController.getAreaSearchApi(context, val).then(
                              (value){
                            searchAreaModel.value = value!;
                          });
                    },
                    hintStyle: TextStyle(
                        color: AppColor.lightGrey,
                        fontSize: 13,
                        fontFamily: AppFont.poppinsRegular),
                  ),
                  SizedBox(height: 10,),
                  Flexible(
                    child: ValueListenableBuilder(
                        valueListenable: searchAreaModel,
                        builder: (_,searchAreaModel,child) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              searchAreaModel.data.length == 0?
                              Center(child: Text("No Area Found"),):
                              Flexible(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchAreaModel.data.length,
                                    itemBuilder: (_,index){
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          GestureDetector(
                                            onTap: (){

                                              if(searchAreaModel.data[index].isAlreadyAssigned??false){
                                                showAreaAlreadyAssignedDialog().then(
                                                        (value){
                                                      if(value??false){
                                                        Navigator.pop(context,(searchAreaModel.data[index].areaName,searchAreaModel.data[index].id));
                                                      }
                                                      else{
                                                        Navigator.pop(context);
                                                      }
                                                    });
                                              }
                                              else {
                                                Navigator.pop(context,
                                                    (searchAreaModel.data[index]
                                                        .areaName, searchAreaModel
                                                        .data[index].id));
                                              }
                                            },
                                            child: Text(
                                              searchAreaModel.data[index].areaName??"",
                                              style: TextStyle(
                                                  fontSize: 16
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black,
                                          ),
                                          SizedBox(height: 2,)
                                        ],
                                      );
                                    }
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
    areaId = area.$2;
    debugPrint("areaId = ${areaId}");
    return area.$1??"";
  }
  Future<bool?> showAreaAlreadyAssignedDialog() async {
    bool? confirm = await showDialog(
        context: context,
        builder: (_){
          return AlertDialog(
            title: Text("This area is already assigned to another vendor. Are you sure you want to proceed with the assignment?"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,true);
                  },
                  child: Text("Yes",style: TextStyle(color: AppColor.green),)),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context,false);
                  },
                  child: Text("No",style: TextStyle(color: AppColor.redLight),)),
            ],
          );
        }
    );
    return confirm;
  }
}
