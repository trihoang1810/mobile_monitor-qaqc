import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/blocs/events/waterproofing_report_event.dart';
import 'package:mobile_app/blocs/states/waterproofing_report_state.dart';

class WaterProofingReportBloc extends Bloc<WaterProofingReportEvent, WaterProofingReportState> {
  WaterProofingReportBloc() : super(WFReportStateInit(timestamp: DateTime.now()));

  @override
  Stream<WaterProofingReportState> mapEventToState(WaterProofingReportEvent event) async* {
    
  }
}
