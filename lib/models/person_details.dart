import 'package:squadio_flutter_task/models/person.dart';

import '../shared/gender_enum.dart';

class PersonDetails extends Person {
  final String birthday;
  final String? deathDay;
  final String biography;

  PersonDetails({
    required this.birthday,
    this.deathDay,
    required this.biography,
    required super.isAdult,
    required super.gender,
    required super.id,
    required super.knownForDepartment,
    required super.name,
    required super.popularity,
    required super.profilePath,
  });
  factory PersonDetails.fromJson(Map<String, dynamic> data) {
    return PersonDetails(
        isAdult: data["adult"].toString() == 'true',
        gender: GenderEnum.values[int.parse(data['gender'].toString()) - 1],
        id: int.parse(data['id'].toString()),
        knownForDepartment: data['known_for_department'].toString(),
        name: data['name'].toString(),
        popularity: double.parse(data['popularity'].toString()),
        profilePath: data['profile_path'].toString(),
        biography: data['biography'].toString(),
        birthday: data['birthday'].toString(),
        deathDay: data['deathday'].toString() == 'null'
            ? null
            : data['deathday'].toString());
  }
}
