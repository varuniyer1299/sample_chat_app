import 'package:flutter/material.dart';
import 'package:flutter_course_learning/models/image_model.dart';
import 'package:flutter_course_learning/repo/image_repository.dart';

class NetworkImagePickerBody extends StatelessWidget {
  final ImageRepository imageRepo = ImageRepository();
  final Function(String) onImageSelected;

  NetworkImagePickerBody({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          color: Colors.white),
      child: FutureBuilder<List<ImageModel>>(
          future: imageRepo.getNetworkImages(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ImageModel>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        onImageSelected
                            .call(snapshot.data![index].urlSmallSize);
                      },
                      child:
                          Image.network(snapshot.data![index].urlSmallSize)));
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text('This is the error: ${snapshot.error}'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
