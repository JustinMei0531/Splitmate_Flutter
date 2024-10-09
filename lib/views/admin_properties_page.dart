import "package:flutter/material.dart";
import "package:splitmate_flutter/widgets/admin_property_card.dart";

List<Map<String, dynamic>> fakePropertyData = [
  {
    "rent": 1500.0,
    "propertyName": "Oceanview Apartments",
    "tenantCount": 5,
    "servicesList": ["Power", "Water", "Internet"],
    "propertyAddress": "123 Ocean Ave, Miami, FL",
    "imagePath": "assets/images/oceanview.jpg"
  },
  {
    "rent": 1200.0,
    "propertyName": "Sunset Villas",
    "tenantCount": 3,
    "servicesList": ["Water", "Gas", "Internet"],
    "propertyAddress": "456 Sunset Blvd, Los Angeles, CA",
    "imagePath": "assets/images/sunsetvillas.jpg"
  },
  {
    "rent": 1800.0,
    "propertyName": "Greenfield Heights",
    "tenantCount": 4,
    "servicesList": ["Power", "Security", "Water"],
    "propertyAddress": "789 Greenfield Ln, Austin, TX",
    "imagePath": "assets/images/greenfieldheights.jpg"
  },
  {
    "rent": 1600.0,
    "propertyName": "Skyline Towers",
    "tenantCount": 6,
    "servicesList": ["Power", "Internet", "Parking"],
    "propertyAddress": "101 Skyline Dr, New York, NY",
    "imagePath": "assets/images/skylinetowers.jpg"
  },
  {
    "rent": 2000.0,
    "propertyName": "The Horizon",
    "tenantCount": 8,
    "servicesList": ["Water", "Gas", "Internet", "Security"],
    "propertyAddress": "321 Horizon Way, San Francisco, CA",
    "imagePath": "assets/images/horizon.jpg"
  }
];

class AdminPropertiesPage extends StatelessWidget {
  AdminPropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: fakePropertyData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => AdminPropertyCard(
              rent: fakePropertyData[index]["rent"],
              propertyName: fakePropertyData[index]["propertyName"],
              tenantCount: fakePropertyData[index]["tenantCount"],
              servicesList: fakePropertyData[index]["servicesList"],
              propertyAddress: fakePropertyData[index]["propertyAddress"],
              imagePath: fakePropertyData[index]["imagePath"],
            ));
  }
}
