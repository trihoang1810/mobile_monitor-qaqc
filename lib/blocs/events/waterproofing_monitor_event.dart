import 'package:equatable/equatable.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/model/waterproofing_monitor_data.dart';
import 'package:signalr_core/signalr_core.dart';

abstract class WFMonitorEvent extends Equatable {}
class WFMonitorEventHubConnected extends WFMonitorEvent {
  DateTime timestamp;
  HubConnection hubConnection;
  WFMonitorEventHubConnected({this.hubConnection, this.timestamp});
  @override
  List<Object> get props => [timestamp, hubConnection];
}

class WFMonitorEventDataUpdated extends WFMonitorEvent {
  DateTime timestamp;
  WaterProofingMonitorData waterProofingMonitorData;
  WFMonitorEventDataUpdated({this.timestamp, this.waterProofingMonitorData});
  @override
  List<Object> get props => [timestamp, waterProofingMonitorData];
}
class WFMonitorEventConnectFail extends WFMonitorEvent {
  ErrorPackage errorPackage;
  WFMonitorEventConnectFail({this.errorPackage});
  @override
  List<Object> get props => [errorPackage];
}