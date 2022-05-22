import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WaterProofingReportEvent extends Equatable {}

// ignore: must_be_immutable
class WFReportEventSearchingClicked extends  WaterProofingReportEvent{
  DateTime startTime;
  DateTime stopTime;
  DateTime timestamp;
  WFReportEventSearchingClicked(
      {this.timestamp, this.startTime, this.stopTime});
  @override
  List<Object> get props => [timestamp, startTime, stopTime];
}

class WFReportEventPickDateRange extends WaterProofingReportEvent {
  BuildContext context;
  DateTime timestamp;
  WFReportEventPickDateRange({this.context, this.timestamp});
  @override
  List<Object> get props => [timestamp, context];
}


