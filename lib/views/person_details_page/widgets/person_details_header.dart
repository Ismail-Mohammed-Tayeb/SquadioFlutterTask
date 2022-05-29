import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/person_controller.dart';
import '../../../models/person.dart';
import '../../../models/person_details.dart';
import '../../../shared/color_palette.dart';
import '../../../shared/gender_enum.dart';

import '../../../shared/endpoints.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    final detailStyle = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
    );
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 10.w,
          ),
          Hero(
            tag: person.id,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                height: 210.h,
                width: 210.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      ApiEndpoints.imageEndpoint + person.profilePath,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder<PersonDetails?>(
            future: PersonController.getPeronDetails(person.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  ),
                );
              }
              if (snapshot.data == null) {
                return const Text('An Error Occured, Try Again');
              }
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.data!.birthday} • ${snapshot.data!.gender == GenderEnum.male ? 'Male' : 'Female'}\n',
                          style: detailStyle.copyWith(color: kSecondaryColor),
                        ),
                        Text(
                          snapshot.data!.biography,
                          style: detailStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
