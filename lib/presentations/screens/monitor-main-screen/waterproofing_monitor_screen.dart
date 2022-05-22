import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/blocs/blocs/waterproofing_monitor_bloc.dart';
import 'package:mobile_app/blocs/events/waterproofing_monitor_event.dart';
import 'package:mobile_app/blocs/states/waterproofing_monitor_state.dart';
import 'package:mobile_app/presentations/screens/monitor-main-screen/models/reliabilities/operating_params_reliability.dart';
import 'package:mobile_app/presentations/widgets/constant.dart';
import 'package:mobile_app/presentations/widgets/widget.dart';
import 'package:mobile_app/blocs/blocs/reli_monitor_bloc.dart';
import 'package:mobile_app/blocs/events/reli_monitor_event.dart';
import 'package:mobile_app/blocs/states/reli_monitor_state.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/model/reliability_cb_monitor_data.dart';
import 'package:mobile_app/model/reliability_monitor_data.dart';
import 'package:mobile_app/presentations/dialog/dialog.dart';
import 'package:signalr_core/signalr_core.dart';

class WaterProofingMonitorScreen extends StatefulWidget {
  WaterProofingMonitorScreen({Key key}) : super(key: key);
  @override
  _WaterProofingMonitorScreenState createState() =>
      new _WaterProofingMonitorScreenState();
}

class _WaterProofingMonitorScreenState extends State<WaterProofingMonitorScreen> {
  String data1 = "null";
  String data2 = "null";
  String data3 = "null";
  String data4 = "null";
  
  bool warning = false;
  bool running = false;
 
  HubConnection hubConnection;
  @override
  void initState() {
    super.initState();
    try {
      hubConnection = HubConnectionBuilder()
          .withUrl(Constants.baseUrl + '/hub')
          .withAutomaticReconnect()
          .build();
      hubConnection.keepAliveIntervalInMilliseconds = 10000;
      hubConnection.serverTimeoutInMilliseconds = 10000;
      hubConnection.onclose((error) {
        return error != null
            ? BlocProvider.of<ReliMonitorBloc>(context).add(
                ReliMonitorEventConnectFail(
                    errorPackage: ErrorPackage(
                        message: "Ngắt kết nối",
                        detail: "Đã ngắt kết nối đến máy chủ!")))
            : null;
      });
    //  hubConnection.on("MonitorReliability", monitorReliabilityHandlers);
    } on TimeoutException {
      BlocProvider.of<WFMonitorBloc>(context).add(WFMonitorEventConnectFail(
          errorPackage: ErrorPackage(
              message: "Không tìm thấy máy chủ",
              detail: "Vui lòng kiểm tra đường truyền!")));
    } on SocketException {
      BlocProvider.of<WFMonitorBloc>(context).add(WFMonitorEventConnectFail(
          errorPackage: ErrorPackage(
              message: "Không tìm thấy máy chủ",
              detail: "Vui lòng kiểm tra đường truyền!")));
    } catch (e) {
      BlocProvider.of<WFMonitorBloc>(context).add(WFMonitorEventConnectFail(
          errorPackage:
              ErrorPackage(message: "Lỗi xảy ra", detail: e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    LoadingDialog loadingDialog = LoadingDialog(buildContext: context);
    return WillPopScope(
      onWillPop: () async {
        AlertDialogTwoBtnCustomized alertDialogOneBtnCustomized =
            AlertDialogTwoBtnCustomized(
                context: context,
                title: "Bạn có muốn?",
                desc: "Ứng dụng sẽ tự ngắt kết nối với máy chủ",
                textBtn1: "Có",
                textBtn2: "Quay lại",
                onPressedBtn1: () {
                  Navigator.pop(context);
                });
        hubConnection.state == HubConnectionState.connected
            ? alertDialogOneBtnCustomized.show()
            : null;
        return true;
      },
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
                unselectedLabelColor: Colors.blueGrey,
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
                AlertDialogTwoBtnCustomized alertDialogOneBtnCustomized =
                    AlertDialogTwoBtnCustomized(
                        context: context,
                        title: "Bạn có muốn?",
                        desc: "Ứng dụng sẽ tự ngắt kết nối với máy chủ",
                        textBtn1: "Có",
                        textBtn2: "Quay lại",
                        onPressedBtn1: () {
                          Navigator.pop(context);
                        });
                hubConnection.state == HubConnectionState.connected
                    ? alertDialogOneBtnCustomized.show()
                    : Navigator.pop(context);
              },
            ),
            title: Text("Giám sát kiểm tra độ chống thấm"),
          ),
          backgroundColor: Colors.white,
          body:
           BlocConsumer<WFMonitorBloc, WFMonitorState>(
            listener: (context, wfMonitorState) async {
              if (wfMonitorState is WFMonitorStateConnectFail) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: wfMonitorState.errorPackage.message,
                        desc: wfMonitorState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } else if (wfMonitorState is WFMonitorStateConnectSucessful) {
                loadingDialog.dismiss();
                // data1 = wfMonitorState.reliMonitorData.soLanDongNapCaiDat
                //     .toString();
                // data2 = wfMonitorState.reliMonitorData.soLanDongNapHienTai
                //     .toString();
                // data3 = wfMonitorState.reliMonitorData.thoiGianGiuNapDong
                //     .toString();
                // data4 = wfMonitorState.reliMonitorData.thoiGianGiuNapMo
                //     .toString();
                // warning = wfMonitorState.reliMonitorData.alarm;
                // running = wfMonitorState.reliMonitorData.running;

                // print(hubConnection.state.toString());
              } else if (wfMonitorState is WFMonitorStateDataUpdated) {
                loadingDialog.dismiss();
                // print('chụp được state nè');
                 // data1 = wfMonitorState.reliMonitorData.soLanDongNapCaiDat
                //     .toString();
                // data2 = wfMonitorState.reliMonitorData.soLanDongNapHienTai
                //     .toString();
                // data3 = wfMonitorState.reliMonitorData.thoiGianGiuNapDong
                //     .toString();
                // data4 = wfMonitorState.reliMonitorData.thoiGianGiuNapMo
                //     .toString();
                // warning = wfMonitorState.reliMonitorData.alarm;
                // running = wfMonitorState.reliMonitorData.running;

              } else if (wfMonitorState is WFMonitorStateLoadingRequest) {
                loadingDialog.show();
              } 
              if (wfMonitorState is WFMonitorStateConnectFail) {
                loadingDialog.dismiss();
                AlertDialogOneBtnCustomized(
                        context: context,
                        title: wfMonitorState.errorPackage.message,
                        desc: wfMonitorState.errorPackage.detail,
                        textBtn: "OK",
                        closePressed: () {},
                        onPressedBtn: () {})
                    .show();
              } 
            },
            builder: (context, reliMonitorState) => WillPopScope(
              onWillPop: () async {
                return hubConnection.state == HubConnectionState.connected
                    ? false
                    : true;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            Text(
                              'THÔNG SỐ VẬN HÀNH',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.0128),
                            CustomizedButton(
                              fontSize: 25,
                              width: SizeConfig.screenWidth * 0.5121,
                              height: SizeConfig.screenHeight * 0.05121,
                              onPressed: () {
                                // BlocProvider.of<ReliMonitorBloc>(context)
                                //     .add(ReliMonitorEventSearchingClicked());
                                BlocProvider.of<ReliMonitorBloc>(context).add(
                                    ReliMonitorEventHubConnected(
                                        hubConnection: hubConnection));
                              },
                              text: "Truy xuất",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  hubConnection.state ==
                                          HubConnectionState.connected
                                      ? Icons.check_box_rounded
                                      : Icons.check_box_outline_blank_rounded,
                                  color: hubConnection.state ==
                                          HubConnectionState.connected
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  hubConnection.state ==
                                          HubConnectionState.connected
                                      ? "Đã kết nối"
                                      : "Ngắt kết nối",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: hubConnection.state ==
                                              HubConnectionState.connected
                                          ? Colors.green
                                          : Colors.red),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.0128),
                            Container(
                              decoration: BoxDecoration(border: Border.all()),
                              width: SizeConfig.screenWidth * 0.8962,
                              height: SizeConfig.screenHeight * 0.2561,
                              child: MonitorOperatingParamsReli(
                                  text1: "Nhiệt độ cài đặt",
                                  text2: "Thời gian kiểm tra cài đặt",
                                  text3: "Nhiệt độ hiện tại",
                                  text4: "Thời gian kiểm tra hiện tại",
                                  data1: data1,
                                  data2: data2,
                                  data3: data3,
                                  data4: data4),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.0256),
                            Text(
                              'BẢNG GIÁM SÁT',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.0256),
                            Container(
                              decoration: BoxDecoration(border: Border.all()),
                              width: SizeConfig.screenWidth * 0.8962,
                              height: SizeConfig.screenHeight * 0.2176,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: SizeConfig.screenHeight * 0.1280,
                                        height:
                                            SizeConfig.screenHeight * 0.1280,
                                        decoration: new BoxDecoration(
                                          color: running
                                              ? Colors.green
                                              : Colors.black26,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                        "ĐANG CHẠY",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: SizeConfig.screenHeight * 0.1280,
                                        height:
                                            SizeConfig.screenHeight * 0.1280,
                                        decoration: new BoxDecoration(
                                          color: warning
                                              ? Colors.red
                                              : Colors.black26,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Text(
                                        "CẢNH BÁO",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible:
                                    warning && data1 == data2 ? true : false,
                                child: Text(
                                  'Đã hoàn thành chương trình!',
                                  style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible:
                                    warning && data1 != data2 ? true : false,
                                child: Text(
                                  'Hệ thống xảy ra lỗi!',
                                  style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void monitorReliabilityHandlers(List<dynamic> data) {
    print(Map<String, dynamic>.from(data[0])["alarm"]);
    BlocProvider.of<ReliMonitorBloc>(context).add(ReliMonitorEventDataUpdated(
        reliMonitorData: ReliMonitorData(
            alarm: Map<String, dynamic>.from(data[0])["alarm"],
            running: Map<String, dynamic>.from(data[0])["running"],
            thoiGianGiuNapDong:
                Map<String, dynamic>.from(data[0])["timeLidClose"],
            thoiGianGiuNapMo: Map<String, dynamic>.from(data[0])["timeLidOpen"],
            soLanDongNapCaiDat:
                Map<String, dynamic>.from(data[0])["numberClosingSp"],
            soLanDongNapHienTai:
                Map<String, dynamic>.from(data[0])["numberClosingPv"])));
  }

 
}
