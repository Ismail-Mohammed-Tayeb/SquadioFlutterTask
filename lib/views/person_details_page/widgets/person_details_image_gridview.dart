import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:squadio_flutter_task/controllers/person_controller.dart';
import 'package:squadio_flutter_task/models/person.dart';
import 'package:squadio_flutter_task/shared/color_palette.dart';
import 'package:squadio_flutter_task/views/image_views_page/image_viewer_page.dart';

class PeronImagesGridView extends StatelessWidget {
  const PeronImagesGridView({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: FutureBuilder<List<String>>(
        future: PersonController.getPersonImages(person.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: kSecondaryColor,
              ),
            );
          }
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                      () => ImageViewerPage(imageUrl: snapshot.data![index]));
                },
                child: Hero(
                  tag: snapshot.data![index],
                  child: Image.network(
                    snapshot.data![index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
