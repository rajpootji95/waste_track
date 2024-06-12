import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:waste_track/Utils/Components/app_font.dart';
import 'package:waste_track/Utils/behavior.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';
import 'package:waste_track/Utils/images/images.dart';

import '../../../../Conrollers/Nylon Management Controller/nylon_management_controller.dart';
import '../../../../Utils/Components/Search Text Field/custom_search_text_field.dart';
import '../../../../Utils/Components/myShimmer.dart';

class SubNylonManagementDetails extends StatefulWidget {
  final batchNumber,vendorId;
  const SubNylonManagementDetails({super.key,this.batchNumber,this.vendorId});

  @override
  State<SubNylonManagementDetails> createState() =>
      _SubNylonManagementDetailsState();
}

class _SubNylonManagementDetailsState extends State<SubNylonManagementDetails> {
  final TabController tabController =
      TabController(length: 3, vsync: TickerProviderImpl());
  bool isButtonSelected = false;
  NylonManagementController nylonManagementController=NylonManagementController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    callSingleVendorApi();
    _scrollController.addListener(
            (){
          _onScroll();
        }
    );

  }
  callSingleVendorApi()async{
    await nylonManagementController.getVendorListApi(context, widget.vendorId);
    setState(() {

    });
  }

  ScrollController _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }
  bool isLoadingMoreData = false;
  Future<void> _fetchData() async {
    int currentDataLength = nylonManagementController.getVendorStaffCollectionListModel?.data.length??0;

    if (!isLoadingMoreData && nylonManagementController.getVendorStaffCollectionListModel?.data.length != nylonManagementController.getVendorStaffCollectionListModel?.pagination?.totalItems ) {
      int limit = currentDataLength + 10;
      setState(() {
        isLoadingMoreData = true;
      });
      await Future.delayed(Duration(seconds: 1));
      debugPrint(limit.toString());
      nylonManagementController.getVendorCollectionApi(context, "1", '$limit','',nylonManagementController.getSingleVendorModel?.data?.id).then(
              (value){
            debugPrint(nylonManagementController.getVendorStaffCollectionListModel?.data.length.toString());
            setState(() {
              isLoadingMoreData =false;
            });
          });
      // dataList.addAll(List.generate(10, (index) => index + dataList.length));
      // currentPage++;
      // isLoading1 = false;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 7),
                Text(
                  'Kepa Waste Track',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppFont.poppinsBold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body:nylonManagementController.getSingleVendorModel == null ? myShimmer()
          :nylonManagementController.getSingleVendorModel?.status == false?  Center(child: Text("vendor not found !!")) : Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                "Batch Number",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 12,
                    fontFamily: AppFont.poppinsSemiBold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${widget.batchNumber}",
                style: TextStyle(
                    color: AppColor.green,
                    fontSize: 12,
                    fontFamily: AppFont.poppinsBold),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 1,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vendor Details",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsSemiBold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Vendor Code :",
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 11,
                                fontFamily: AppFont.poppinsLight),
                          ),
                          Text(
                            "${nylonManagementController.getSingleVendorModel?.data?.vendorCode}",
                            style: TextStyle(
                                color: AppColor.green,
                                fontSize: 13,
                                fontFamily: AppFont.poppinsBold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${nylonManagementController.getSingleVendorModel?.data?.companyName}",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColor.black,
                        fontSize: 13,
                        fontFamily: AppFont.poppinsSemiBold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        color: AppColor.green,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${nylonManagementController.getSingleVendorModel?.data?.firstName}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${nylonManagementController.getSingleVendorModel?.data?.email}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.call_end_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "+234 ${nylonManagementController.getSingleVendorModel?.data?.phoneNumber}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColor.green),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${nylonManagementController.getSingleVendorModel?.data?.companyAddress}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(AppImages.browser),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${nylonManagementController.getSingleVendorModel?.data?.website}",
                        style: TextStyle(
                            color: AppColor.black,
                            fontSize: 13,
                            fontFamily: AppFont.poppinsMedium),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Flexible(
                child: CustomSearchTextField(
                  onChanged: (value){
                    nylonManagementController.getVendorCollectionApi(context, "1", '',value,nylonManagementController.getSingleVendorModel?.data?.id).then((value) {
                      setState(() {

                      });
                    });
                  },
                  hintText: 'Search here...',
                  hintStyle: TextStyle(
                      fontSize: 12, color: AppColor.grey1.withOpacity(0.5)),
                  suffixIcon: Icon(
                    Icons.search,
                    color: AppColor.green,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              /*GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppImages.union,
                                              height: 15,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              "Filter By",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppFont.poppinsSemiBold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Batch Number'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.59),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Vendor Code'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.59),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Company name'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        color: Colors.black.withOpacity(0.59),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Assigned Date'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CustomRadioButton(
                                              isSelected: isButtonSelected,
                                              onChanged: (value) {
                                                setState(() {
                                                  isButtonSelected = value;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ])
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColor.green.withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: AppColor.green,
                      )),
                )*/
            ],
          ),
          Flexible(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 310,
                      child: TabBar(
                        labelColor: AppColor.green,
                        labelStyle: TextStyle(fontSize: 12),
                        unselectedLabelColor: AppColor.grey1,
                        indicator: UnderlineTabIndicator(
                          borderSide:
                          BorderSide(color: AppColor.green, width: 2),
                          insets: EdgeInsets.symmetric(horizontal: 2),
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(text: 'Serial Details'),
                          // Tab(text: 'Track Order'),
                          // Tab(text: 'Buyer Details'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .01,
                ),

                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child:
                              nylonManagementController.getVendorStaffCollectionListModel?.data == null ? myShimmer() :nylonManagementController.getVendorStaffCollectionListModel?.data.length == 0 ?Center(child: Text("No Collected List Found !!")) :
                              ListView(
                                controller: _scrollController,
                                children: List.generate(
                                  nylonManagementController.getVendorStaffCollectionListModel?.data.length ?? 0,
                                      (index) =>
                                      Column(
                                        children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15),
                                                margin:
                                                const EdgeInsets.only(bottom: 5),
                                                child: Card(
                                                  elevation: 1,
                                                  margin: EdgeInsets.zero,
                                                  shape: ContinuousRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(20)),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(15.0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Expanded(
                                                              child: const Text(
                                                                "Serial Number",
                                                                style: TextStyle(
                                                                    color:
                                                                    AppColor.black,
                                                                    fontSize: 13,
                                                                    fontFamily: AppFont
                                                                        .poppinsLight),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:  Text(
                                                                "${nylonManagementController.getVendorStaffCollectionListModel?.data[index].serialNumber}",
                                                                style: TextStyle(
                                                                    color:
                                                                    AppColor.black,
                                                                    fontSize: 13,
                                                                    fontFamily: AppFont
                                                                        .poppinsLight),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          color: AppColor.black,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Expanded(
                                                              child: const Text(
                                                                "Date of Collection",
                                                                style: TextStyle(
                                                                    color:
                                                                    AppColor.black,
                                                                    fontSize: 13,
                                                                    fontFamily: AppFont
                                                                        .poppinsLight),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:  Text(
                                                                "${nylonManagementController.getVendorStaffCollectionListModel?.data[index].collectedDate}",
                                                                style: TextStyle(
                                                                    color:
                                                                    AppColor.black,
                                                                    fontSize: 12,
                                                                    fontFamily: AppFont
                                                                        .poppinsLight),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Divider(
                                                          color: AppColor.black,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                          children: [
                                                            Expanded(
                                                              child: const Text(
                                                                "Collected by",
                                                                style: TextStyle(
                                                                    color:
                                                                    AppColor.black,
                                                                    fontSize: 13,
                                                                    fontFamily: AppFont
                                                                        .poppinsLight),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:  Text(
                                                                "${nylonManagementController.getVendorStaffCollectionListModel?.data[index].name}",
                                                                style: TextStyle(
                                                                    color:
                                                                    AppColor.black,
                                                                    fontSize: 12,
                                                                    fontFamily: AppFont
                                                                        .poppinsLight),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 25,
                                                top: 2,
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 4,
                                                        left: 11,
                                                        right: 11,
                                                        bottom: 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
                                                        color: nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText == "Pending" ? AppColor.orange.withOpacity(0.4) : nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText == "Rejected" ?AppColor.redLight.withOpacity(0.4) :nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText == "Verified" ?AppColor.green.withOpacity(0.4) : AppColor.purpleDark.withOpacity(0.4)),
                                                    child: Text(
                                                      '${nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText}',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText == "Pending" ? AppColor.orange : nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText == "Rejected" ?AppColor.redLight :nylonManagementController.getVendorStaffCollectionListModel?.data[index].statusText == "Verified" ?AppColor.green : AppColor.purpleDark),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          if(index == (nylonManagementController.getVendorStaffCollectionListModel?.data.length??0)-1  && isLoadingMoreData && (nylonManagementController.getVendorStaffCollectionListModel?.data.length != nylonManagementController.getVendorStaffCollectionListModel?.pagination?.totalItems))
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(color:AppColor.green),
                                            ),

                                        ],
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      /* Column(
                        children: [
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_order,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Placed',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:43 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_generated,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Generated',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_assigned,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Assigned',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_picked,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Picked Up',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .track_sold,
                                                            height: 45,
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Nylon Sold by Vendor',
                                                                style: TextStyle(
                                                                    color: AppColor
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        AppFont
                                                                            .poppinsSemiBold),
                                                              ),
                                                              Text(
                                                                '8 sep 2023 at 10:45 AM',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 47,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                8,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 47,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                7,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                7,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration: DottedDecoration(
                                                              shape: Shape.line,
                                                              linePosition:
                                                                  LinePosition
                                                                      .right,
                                                              color: AppColor
                                                                  .green,
                                                              strokeWidth: 2,
                                                              dash: const <int>[
                                                                7,
                                                                5
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          child: const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: Get.height * .01,
                          ),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView(
                                children: List.generate(
                                  10,
                                  (index) => Card(
                                    elevation: 1,
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Buyer Details",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontFamily:
                                                    AppFont.poppinsBold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person_outline_rounded,
                                                color: AppColor.green,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                " Lorem Ipsum",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.call_end_outlined,
                                                  color: AppColor.green),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                "+234 90-461-4000",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.location_on_outlined,
                                                  color: AppColor.green),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                "abc colony, xyz area, pqr city",
                                                style: TextStyle(
                                                    color: AppColor.black,
                                                    fontSize: 13,
                                                    fontFamily:
                                                        AppFont.poppinsMedium),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class TickerProviderImpl implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
