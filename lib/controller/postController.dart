import 'package:get/get.dart';

class PostController extends GetxController {
  var posts = [].obs;

  setPost(List data) {
    posts.value = data.reversed.toList();
  }
}
