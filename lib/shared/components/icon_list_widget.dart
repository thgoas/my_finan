import 'package:flutter/material.dart';

class IconListWidget extends StatelessWidget {
  final dynamic selectIcon;
  final List<IconData> icons = [
    Icons.local_grocery_store,
    Icons.home,
    Icons.star,
    Icons.settings,
    Icons.favorite,
    Icons.search,
    Icons.camera_alt,
    Icons.alarm,
    Icons.email,
    Icons.phone,
    Icons.handyman,
    Icons.car_repair,
    Icons.home_repair_service,
    Icons.tire_repair,
    Icons.build,
    Icons.build_circle,
    Icons.carpenter,
    Icons.plumbing,
    Icons.hardware,
    Icons.construction,
    Icons.local_gas_station,
    Icons.volunteer_activism,
    Icons.church,
    Icons.electric_bolt,
    Icons.attach_money,
    Icons.request_quote,
    Icons.confirmation_num,
    Icons.calculate,
    Icons.sports_motorsports,
    Icons.wifi,
    Icons.beach_access,
    Icons.medical_services,
    Icons.masks,
    Icons.vaccines,
    Icons.local_hospital,
    Icons.local_pharmacy,
    Icons.medication,
    Icons.medication_liquid,
    Icons.monitor_heart,
    Icons.traffic,
    Icons.shield,
    Icons.lock,
    Icons.live_tv,
    Icons.tv,
    Icons.stream,
    Icons.local_parking,
    Icons.lunch_dining,
    Icons.restaurant,
    Icons.content_cut,
    Icons.pending,
    Icons.pets,
    Icons.smartphone,
    Icons.local_taxi,
    Icons.car_crash,
    Icons.directions_car,
    Icons.directions_bus,
    Icons.directions_train,
    Icons.local_shipping,
    Icons.fire_truck,
    Icons.two_wheeler,
    Icons.directions_bike,
    Icons.directions_boat,
    Icons.school,
    Icons.water_drop,
    Icons.checkroom,
    Icons.sports_soccer,
    Icons.sports_volleyball,
    Icons.sports_basketball,
    Icons.sports,
    Icons.sports_mma,
    Icons.sports_score,
    Icons.cake,
    Icons.celebration,
    Icons.home_work,
    Icons.business,
    Icons.apartment,
    Icons.savings,
    Icons.bakery_dining,
  ];
  // Lista de ícones
  IconListWidget({super.key, required this.selectIcon});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Número de colunas no grid
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            selectIcon(icons[index].codePoint);
            Navigator.of(context).pop();
          },
          child: Icon(
            icons[index],
            size: 50.0,
            color: Colors.grey[800],
          ),
        );
      },
    );
  }
}
