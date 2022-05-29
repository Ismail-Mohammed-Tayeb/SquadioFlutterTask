import '../shared/gender_enum.dart';

class Person {
  final bool isAdult;
  final GenderEnum gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final double popularity;
  final String profilePath;

  Person({
    required this.isAdult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.popularity,
    required this.profilePath,
  });

  factory Person.fromJson(Map<String, dynamic> data) {
    return Person(
      isAdult: data["adult"].toString() == 'true',
      gender: GenderEnum.values[int.parse(data['gender'].toString()) - 1],
      id: int.parse(data['id'].toString()),
      knownForDepartment: data['known_for_department'].toString(),
      name: data['name'].toString(),
      popularity: double.parse(data['popularity'].toString()),
      profilePath: data['profile_path'].toString(),
    );
  }
}
