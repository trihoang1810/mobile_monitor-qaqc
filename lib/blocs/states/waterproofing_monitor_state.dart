import 'package:equatable/equatable.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/model/waterproofing_monitor_data.dart';

abstract class WFMonitorState extends Equatable{

}

class WFMonitorStateInit extends WFMonitorState {
  DateTime timestamp;
  String data1;
  String data2;
  String data3;
  String data4;
  bool warning;
  bool running;
  WFMonitorStateInit(
      {this.timestamp,
      this.data1,
      this.data2,
      this.data3,
      this.data4,
      this.running,
      this.warning});

  @override
  // TODO: implement props
  List<Object> get props =>
      [timestamp, data1, data2, data3, data4, running, warning];
}

class WFMonitorStateLoadingRequest extends WFMonitorState {
  DateTime timestamp;
  WFMonitorStateLoadingRequest({this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class WFMonitorStateConnectSucessful extends WFMonitorState {
  DateTime timestamp;
  WaterProofingMonitorData reliMonitorData;
  WFMonitorStateConnectSucessful({this.reliMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, reliMonitorData];
}

class WFMonitorStateConnectFail extends WFMonitorState {
  DateTime timestamp;
  ErrorPackage errorPackage;
  WFMonitorStateConnectFail({this.timestamp, this.errorPackage});
  @override
  List<Object> get props => [timestamp, errorPackage];
}

class WFMonitorStateDataUpdated extends WFMonitorState {
  DateTime timestamp;
  WaterProofingMonitorData reliMonitorData;
  WFMonitorStateDataUpdated({this.reliMonitorData, this.timestamp});
  @override
  List<Object> get props => [timestamp, reliMonitorData];
}
