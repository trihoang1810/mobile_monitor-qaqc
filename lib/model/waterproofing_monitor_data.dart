import 'package:equatable/equatable.dart';

class WaterProofingMonitorData extends Equatable {
  int nhietDoCaiDat;
  int nhietDoHienTai;
  int thoiGianKiemTraCaiDat;
  int thoiGianKiemTraHienTai;
  bool alarm;
  bool running;
  WaterProofingMonitorData(
      this.nhietDoCaiDat,
      this.nhietDoHienTai,
      this.thoiGianKiemTraCaiDat,
      this.thoiGianKiemTraHienTai,
      this.alarm,
      this.running);
  @override
  // TODO: implement props
  List<Object> get props => [nhietDoCaiDat, nhietDoHienTai, thoiGianKiemTraCaiDat, thoiGianKiemTraHienTai];
}
