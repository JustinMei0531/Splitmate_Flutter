import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:splitmate_flutter/views/admin_activity_page.dart";
import "package:splitmate_flutter/views/admin_properties_page.dart";
import "package:splitmate_flutter/views/admin_service_page.dart";
import "package:splitmate_flutter/views/all_tenants_page.dart";
import "package:splitmate_flutter/views/profile_page.dart";
import "package:splitmate_flutter/widgets/sidebar.dart";

class AdminHomePage extends StatelessWidget {
  final RxInt currentBarIndex = 0.obs;
  AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu)),
        ),
        title: const Text(
          "SplitMate Management System",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      body: IndexedStack(
        index: 0,
        children: [
          DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: AppBar(
                  backgroundColor: Colors.orange,
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: "Properties"),
                      Tab(text: "Activity"),
                      Tab(text: "Tenants"),
                    ],
                    labelColor: Colors.black,
                    indicatorColor: Colors.orange,
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  AdminPropertiesPage(),
                  AdminActivityPage(),
                  AllTenantsPage()
                ],
              ),
            ),
          ),
          AdminServicePage(),
          ProfilePage()
        ],
      ),
      drawer: Sidebar(
        username: "Unknown", // Fetching username from GetStorage
        email: "Unknown", // Fetching email from GetStorage
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentBarIndex.value,
          onTap: (int index) {
            currentBarIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
