import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../shared/color_palette.dart';
import '../../shared/http_handler.dart';

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  const ImageViewerPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: imageUrl,
                child: InteractiveViewer(
                  panEnabled: false,
                  minScale: 0.5,
                  maxScale: 2,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
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
                      onPressed: downloadImage,
                      backgroundColor: kSecondaryColor,
                      splashColor: kPrimaryColor,
                      tooltip: 'Download',
                      child: Icon(
                        Icons.downloading_rounded,
                        size: 50.h,
                        color: kPrimaryColor,
                      ),
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

  void downloadImage() async {
    Fluttertoast.showToast(
        msg: "Saving Image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: kSecondaryColor,
        textColor: kPrimaryColor,
        fontSize: 16.0);
    bool downloadResult = await HttpHandler.downloadRequest(imageUrl);
    if (downloadResult) {
      Fluttertoast.showToast(
        msg: "Image Saved Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: kSecondaryColor,
        textColor: kPrimaryColor,
        fontSize: 16.0,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: "Error Saving Image",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: kSecondaryColor,
      textColor: kPrimaryColor,
      fontSize: 16.0,
    );
  }
}
