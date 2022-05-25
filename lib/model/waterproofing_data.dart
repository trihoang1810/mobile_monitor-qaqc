class WaterProofingData {
  List<Items> items;
  int totalItems;
  WaterProofingData({
    this.items,
    this.totalItems,
  });

  WaterProofingData.fromJson(Map<String, dynamic> json) {
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
    totalItems = json['totalItems'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e) => e.toJson()).toList();
    _data['totalItems'] = totalItems;
    return _data;
  }
}

class Items {
  Items({
    this.samples,
    this.startDate,
    this.endDate,
    this.product,
    this.testPurpose,
    this.note,
  });
  List<Samples> samples;
  String startDate;
  String endDate;
  Product product;
  int testPurpose;
  String note;

  Items.fromJson(Map<String, dynamic> json) {
    samples =
        List.from(json['samples']).map((e) => Samples.fromJson(e)).toList();
    startDate = json['startDate'];
    endDate = json['endDate'];
    product = Product.fromJson(json['product']);
    testPurpose = json['testPurpose'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['samples'] = samples.map((e) => e.toJson()).toList();
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['product'] = product.toJson();
    _data['testPurpose'] = testPurpose;
    _data['note'] = note;
    return _data;
  }
}

class Samples {
  Samples({
    this.temperature,
    this.duration,
    this.passed,
    this.tester,
    this.numberOfError,
    this.note,
  });
  int temperature;
  int duration;
  bool passed;
  Tester tester;
  int numberOfError;
  String note;

  Samples.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    duration = json['duration'];
    passed = json['passed'];
    tester = Tester.fromJson(json['tester']);
    numberOfError = json['numberOfError'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temperature'] = temperature;
    _data['duration'] = duration;
    _data['passed'] = passed;
    _data['tester'] = tester.toJson();
    _data['numberOfError'] = numberOfError;
    _data['note'] = note;
    return _data;
  }
}

class Tester {
  Tester({
    this.employeeId,
    this.firstName,
    this.lastName,
  });
  String employeeId;
  String firstName;
  String lastName;

  Tester.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employeeId'] = employeeId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    return _data;
  }
}

class Product {
  Product({
    this.id,
    this.name,
  });
  String id;
  String name;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
