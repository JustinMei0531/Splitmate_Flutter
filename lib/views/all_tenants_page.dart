import "package:flutter/material.dart";

class AllTenantsPage extends StatelessWidget {
  AllTenantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InkWell(
          onTap: () {},
          child: ListTile(
            // isThreeLine: true,
            contentPadding: const EdgeInsets.all(10.0),
            leading: CircleAvatar(
              child: Text("CA"),
              radius: 30.0,
            ),
            title: Text(
              "Mike",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Email: qq@qq.com"),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            // isThreeLine: true,
            contentPadding: const EdgeInsets.all(10.0),
            leading: CircleAvatar(
              child: Text("CA"),
              radius: 30.0,
            ),
            title: Text(
              "AJ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Email: abc@abc.com"),
          ),
        ),
      ],
    );
  }
}
