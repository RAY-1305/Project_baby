//child
class Child {
  final String name;
  final String dob;
  final bool gender;
  final String? avatar;
  //final List<GrowthInforRecord>? records;

  Child(
      {required this.name,
      required this.dob,
      required this.gender,
      this.avatar,
      //this.records
      });
}