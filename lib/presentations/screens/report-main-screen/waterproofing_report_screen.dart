import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/blocs/blocs/defor_bending_report_bloc.dart';
import 'package:mobile_app/blocs/events/defor_report_event.dart';
import 'package:mobile_app/blocs/states/defor_report_state.dart';
import 'package:mobile_app/presentations/dialog/dialog.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';
import 'package:mobile_app/presentations/widgets/error_state_widget.dart';
import 'package:mobile_app/presentations/widgets/header_widget.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';

class WaterProofingReportScreen extends StatefulWidget {
  @override
  State<WaterProofingReportScreen> createState() =>
      _WaterProofingReportScreenState();
}

class _WaterProofingReportScreenState extends State<WaterProofingReportScreen> {
 
   Completer<void> _completerDeforBending;
  Completer<void> _completerDeforStatic;
  Completer<void> _completerDeforRock;

  String _getUntil = "Đến ngày";
  String _getFrom = "Từ ngày";
  DateTime _startDate = DateTime.now().subtract(Duration(hours: 24 * 2));
  DateTime _endDate = DateTime.now();
 
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
   // LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            //  unselectedLabelColor: Colors.blueGrey,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Constants.secondaryColor,
              ),
            tabs: [
              Tab(text: "Chống thấm"),
             
            ],
          ),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Báo cáo kiểm tra độ chống thấm"),
        ),
        body: BlocConsumer<DeforReportBloc, DeforReportState>(
          listener: (context, deforReportState) {},
          builder: (context, deforReportState) => 
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<DeforReportBloc>(context).add(
                        DeforBendingReportEventSearchingClicked(
                            startTime: _startDate, stopTime: _endDate));
                    return _completerDeforBending.future;
                  },
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        //length = 3 => children của tabbarview phải bằng 3
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0, SizeConfig.screenHeight * 0.0256, 0, 0),
                                child: HeaderWidget(
                                  title: 'Chọn khoảng thời gian',
                                  child: Row(
                                    children: [
                                      Expanded(
                                        //đừng để ý expanded
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              SizeConfig.screenWidth * 0.0509,
                                              0,
                                              0,
                                              0),
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                  color: Constants.mainColor),
                                            ),
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getFrom),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforBendingReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Constants.mainColor,
                                        size: 40,
                                      ),
                                      SizedBox(
                                          width:
                                              SizeConfig.screenWidth * 0.0203),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0,
                                              0,
                                              SizeConfig.screenWidth * 0.0509,
                                              0),
                                          child: RaisedButton(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color: Constants.mainColor,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(_getUntil),
                                                Icon(Icons.calendar_today),
                                              ],
                                            ),
                                            onPressed: () => BlocProvider.of<
                                                    DeforReportBloc>(context)
                                                .add(
                                                    DeforBendingReportEventPickDateRange(
                                                        context: context)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomizedButton(
                                //height/width ko khai báo sẽ để mặc định,
                                text: "Truy xuất",
                                onPressed: () {
                                  BlocProvider.of<DeforReportBloc>(context).add(
                                      DeforBendingReportEventSearchingClicked(
                                          startTime: _startDate,
                                          stopTime: _endDate));
                                },
                              ),
                              SizedBox(
                                  height: SizeConfig.screenHeight * 0.0128),
                              BlocBuilder<DeforReportBloc, DeforReportState>(
                                builder: (context, state) {
                                  if (state
                                      is DeforBendingReportStateLoadingRequest) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is DeforBendingReportStateLoadingSuccessful) {
                                    return deforBendingReportList.length > 0
                                        ? Container(
                                            //tùy từng widget mà sẽ có child hay children
                                            width:
                                                SizeConfig.screenWidth * 0.8912,
                                            height: SizeConfig.screenHeight *
                                                0.5761,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: DataTable(
                                                  headingTextStyle: TextStyle(
                                                      color: Colors.white),
                                                  headingRowColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) => Color(
                                                                  0xff5973c9)),
                                                  // headingRowColor: Color(0xff5973c9),
                                                  columns: <DataColumn>[
                                                    DataColumn(
                                                      label: Text('Tên SP'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày bắt đầu'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Ngày kết thúc'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Mẫu số'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tải trọng'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Thời gian'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('Độ cong vênh'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Tổng lỗi'),
                                                    ),
                                                    DataColumn(
                                                      label: Text('Ghi chú'),
                                                    ),
                                                    DataColumn(
                                                      label:
                                                          Text('NV kiểm tra'),
                                                    ),
                                                  ],
                                                  rows: deforBendingReportList
                                                      .map(
                                                        (deforbending) =>
                                                            DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(Text(
                                                                deforbending
                                                                    .tenSanPham)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .ngayBatDau)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .ngayKetThuc)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .mauSo
                                                                    .toString())),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .taiTrong)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .thoiGian)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .doCongVenh)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .tongLoi)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .ghiChu)),
                                                            DataCell(Text(
                                                                deforbending
                                                                    .nhanVienKiemTra)),
                                                          ],
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 100),
                                                  Center(
                                                    child: ExceptionErrorState(
                                                      title: 'Thông báo',
                                                      message:
                                                          'Không tìm thấy báo cáo trong ngày, vui lòng thử lại',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                  } else if (state
                                      is DeforBendingReportStateLoadingFailure) {
                                    return Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Center(
                                          child: ExceptionErrorState(
                                            title: state.errorPackage.message,
                                            message: state.errorPackage.detail,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return deforBendingReportList.length > 0
                                      ? Container(
                                          //tùy từng widget mà sẽ có child hay children
                                          width:
                                              SizeConfig.screenWidth * 0.8912,
                                          height:
                                              SizeConfig.screenHeight * 0.5761,
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingTextStyle: TextStyle(
                                                    color: Colors.white),
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Color(0xff5973c9)),
                                                // headingRowColor: Color(0xff5973c9),
                                                columns: <DataColumn>[
                                                  DataColumn(
                                                    label: Text('Tên SP'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ngày bắt đầu'),
                                                  ),
                                                  DataColumn(
                                                    label:
                                                        Text('Ngày kết thúc'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Mẫu số'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tải trọng'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Thời gian'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Độ cong vênh'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Tổng lỗi'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('Ghi chú'),
                                                  ),
                                                  DataColumn(
                                                    label: Text('NV kiểm tra'),
                                                  ),
                                                ],
                                                rows: deforBendingReportList
                                                    .map(
                                                      (deforbending) => DataRow(
                                                        cells: <DataCell>[
                                                          DataCell(Text(
                                                              deforbending
                                                                  .tenSanPham)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .ngayBatDau)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .ngayKetThuc)),
                                                          DataCell(Text(
                                                              deforbending.mauSo
                                                                  .toString())),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .taiTrong)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .thoiGian)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .doCongVenh)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .tongLoi)),
                                                          DataCell(Text(
                                                              deforbending
                                                                  .ghiChu)),
                                                          DataCell(Text(deforbending
                                                              .nhanVienKiemTra)),
                                                        ],
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(height: 100),
                                                Center(
                                                  child: ExceptionErrorState(
                                                    imageDirectory:
                                                        'lib/assets/touch.png',
                                                    title: 'Thông báo',
                                                    message:
                                                        'Nhấn nút truy xuất để xem báo cáo',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
              ]
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  LoadingDialog({BuildContext buildContext}) {}
}
