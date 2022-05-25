import 'package:equatable/equatable.dart';

class WaterProofingMonitorData extends Equatable {
  WaterProofingMonitorData(
      {this.nhietDoCaiDat,
      this.nhietDoHienTai,
      this.thoiGianKiemTraCaiDat,
      this.thoiGianKiemTraHienTai,
      this.alarm,
      this.running});
  String nhietDoCaiDat;
  String nhietDoHienTai;
  String thoiGianKiemTraCaiDat;
  String thoiGianKiemTraHienTai;
  bool alarm;
  bool running;
  @override
  // TODO: implement props
  List<Object> get props => [
        nhietDoCaiDat,
        nhietDoHienTai,
        thoiGianKiemTraCaiDat,
        thoiGianKiemTraHienTai
      ];
}
