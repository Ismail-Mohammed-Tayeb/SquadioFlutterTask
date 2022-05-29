import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../models/person.dart';
import '../../shared/color_palette.dart';
import 'widgets/person_details_header.dart';
import 'widgets/person_details_image_gridview.dart';

class PersonDetailsPage extends StatelessWidget {
  final Person person;
  const PersonDetailsPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: .0,
        title: Text(person.name),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.chevron_left,
            color: kSecondaryColor,
            size: 40.h,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            DetailsHeader(person: person),
            SizedBox(height: 25.h),
            Container(
              color: Colors.white,
              height: 2.h,
              width: 300.w,
            ),
            SizedBox(height: 25.h),
            PeronImagesGridView(person: person),
          ],
        ),
      ),
    );
  }
}
