import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:squadio_flutter_task/shared/color_palette.dart';
import 'package:squadio_flutter_task/shared/endpoints.dart';
import 'package:squadio_flutter_task/shared/gender_enum.dart';
import 'package:squadio_flutter_task/views/person_details_page/person_details_page.dart';

import '../../../models/person.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
      child: InkWell(
        splashColor: kSecondaryColor,
        focusColor: kSecondaryColor,
        hoverColor: kSecondaryColor,
        overlayColor: MaterialStateProperty.all(kSecondaryColor),
        highlightColor: kSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Get.to(() => PersonDetailsPage(person: person));
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Stack(
            children: [
              Hero(
                tag: person.id,
                child: Container(
                  width: double.infinity,
                  height: 400.h,
                  foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1, 0.2, 0.7, 1],
                    ),
                  ),
                  child: Image.network(
                    ApiEndpoints.imageEndpoint + person.profilePath,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      double progressValue =
                          loadingProgress.expectedTotalBytes != null
                              ? (loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!)
                              : 0;
                      return Center(
                        child: CircularProgressIndicator(
                          color: kSecondaryColor,
                          value: progressValue,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 15.h,
                left: 10.w,
                child: Text(
                  person.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 10.w,
                top: 10.h,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    person.gender == GenderEnum.male
                        ? Icons.male
                        : Icons.female,
                    size: 50.h,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 15.h,
                right: 10.w,
                child: Text(
                  person.knownForDepartment,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 10.w,
                top: 15.h,
                child: Container(
                  color: kSecondaryColor,
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: kPrimaryColor,
                        size: 30.h,
                      ),
                      Text(
                        person.popularity.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
