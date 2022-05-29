import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:squadio_flutter_task/shared/color_palette.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  const ImageViewerPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kSecondaryColor),
    );
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: imageUrl,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: 90.h,
              width: double.infinity,
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 70.h,
                    child: FloatingActionButton(
                      heroTag: 'GoBackFAB',
                      onPressed: () {
                        Get.back();
                      },
                      backgroundColor: kSecondaryColor,
                      splashColor: kPrimaryColor,
                      tooltip: 'Go Back',
                      child: Icon(
                        Icons.chevron_left,
                        size: 50.h,
                        color: kPrimaryColor,
                      ),
                      // style: buttonStyle,
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: FloatingActionButton(
                      heroTag: 'DownloadFAB',
                      onPressed: () {},
                      backgroundColor: kSecondaryColor,
                      splashColor: kPrimaryColor,
                      tooltip: 'Download',
                      child: Icon(
                        Icons.downloading_rounded,
                        size: 50.h,
                        color: kPrimaryColor,
                      ),
                      // style: buttonStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
