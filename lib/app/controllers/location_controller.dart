import 'package:get/get.dart';
import 'package:neecoder/app/data/repositories/location_repository.dart';

class LocationController extends GetxController {
  LocationRepository locationRepository = LocationRepository();
  RxBool loadingLocation = false.obs;
  RxList location = [].obs as RxList<dynamic>;

  LocationController() {
    loadLocationFromRepo();
  }

  loadLocationFromRepo() async {
    loadingLocation(true);
    location.value = await locationRepository.loadLocationFromRepo();
    loadingLocation(false);
  }
}
