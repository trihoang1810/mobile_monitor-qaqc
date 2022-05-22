import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/blocs/events/reli_monitor_event.dart';
import 'package:mobile_app/blocs/events/waterproofing_monitor_event.dart';
import 'package:mobile_app/blocs/states/waterproofing_monitor_state.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/model/waterproofing_monitor_data.dart';
import 'package:signalr_core/signalr_core.dart';

class WFMonitorBloc extends Bloc<WFMonitorEvent, WFMonitorState> {
  WFMonitorBloc()
      : super(WFMonitorStateInit(
            timestamp: DateTime.now(),
            data1: "null1",
            data2: "null1",
            data3: "null1",
            data4: "null1",
            running: false,
            warning: false));
  @override
  Stream<WFMonitorState> mapEventToState(WFMonitorEvent event) async* {
    // if (event is ReliMonitorEventHubConnected) {
    //   yield WFMonitorStateLoadingRequest(timestamp: );
    //   event.hubConnection.state == HubConnectionState.disconnected
    //       ? await event.hubConnection.start().onError((error, stackTrace) {
    //           return WFMonitorBloc().add(WFMonitorEventConnectFail(
    //               errorPackage: ErrorPackage(
    //                   message: "Không thể kết nối tới máy chủ",
    //                   detail: "vui lòng kiểm tra đường truyền")));
    //         })
    //       : await event.hubConnection.stop();
    //   if (event.hubConnection.state == HubConnectionState.disconnected) {
    //     // print('Trạng thái hub:' + event.hubConnection.state.toString());
    //     yield WFMonitorStateConnectFail(
    //         errorPackage: ErrorPackage(
    //             message: "Ngắt kết nối",
    //             detail: "Đã ngắt kết nối tới máy chủ"));
    //   } else if (event.hubConnection.state == HubConnectionState.connected) {
    //     WaterProofingMonitorData reliMonitorData = WaterProofingMonitorData(
    //       //
    //       );
    //     yield WFMonitorStateConnectSucessful(
    //       reliMonitorData: reliMonitorData,
    //     );
    //   }
    // } else if (event is ReliMonitorEventDataUpdated) {
     
    //   yield WFMonitorStateDataUpdated(
    //       timestamp: DateTime.now(), reliMonitorData: event.reliMonitorData);
    // }
    }
    }