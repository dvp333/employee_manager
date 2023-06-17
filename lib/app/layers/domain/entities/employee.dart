import 'package:employee_manager/app/layers/domain/entities/role.dart';
import 'package:equatable/equatable.dart';

class Employee with EquatableMixin {
  String? name;
  Role? role;
  DateTime? from;
  DateTime? to;

  Employee({
    required this.name,
    required this.role,
    required this.from,
    this.to,
  });

  int get group => to == null ? 0 : 1;

  Employee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = Role.values[json['role']];
    from = DateTime.fromMicrosecondsSinceEpoch(json['from']);
    if (json['to'] != null) {
      to = DateTime.fromMicrosecondsSinceEpoch(json['to']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['role'] = role?.index;
    data['from'] = from?.microsecondsSinceEpoch;
    data['to'] = to?.microsecondsSinceEpoch;
    return data;
  }

  @override
  List<Object?> get props => [
        name,
        role?.index,
        from?.microsecondsSinceEpoch,
        to?.microsecondsSinceEpoch
      ];
}
