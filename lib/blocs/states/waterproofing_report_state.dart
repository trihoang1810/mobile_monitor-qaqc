import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/model/error_package.dart';
import 'package:mobile_app/model/reliability_data.dart';

abstract class WaterProofingReportState extends Equatable {}

//đóng êm
class WFReportStateLoadingRequest extends WaterProofingReportState {
  DateTime timestamp;
  WFReportStateLoadingRequest({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class WFReportStatePickDateRange extends WaterProofingReportState {
  //mở screen lịch và mình phải chọn
  DateTime timestamp;
  String getFrom = "Từ ngày";
  String getUntil = "Đến ngày";
  DateTimeRange dateRange;
  WFReportStatePickDateRange(
      {this.dateRange, this.timestamp, this.getFrom, this.getUntil});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp, getFrom, getUntil, dateRange];
}

class WFReportStateInit extends WaterProofingReportState {
  DateTime timestamp;
  WFReportStateInit({this.timestamp});
  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}


class WFReportStateLoadingSuccessful extends WaterProofingReportState {
  DateTime timestamp;
  ReliReport reliReport;
  WFReportStateLoadingSuccessful({this.reliReport, this.timestamp});

  @override
  // TODO: implement props
  List<Object> get props => [timestamp];
}

class WFReportStateLoadingFailure extends WaterProofingReportState {
  DateTime timestamp;
  ErrorPackage errorPackage;
WFReportStateLoadingFailure({this.timestamp, this.errorPackage});
  @override
  List<Object> get props => [timestamp];
}

