import 'package:flutter/material.dart';

class helperDrawer extends StatelessWidget {
  final void Function(String value) screenIdentifier;
  const helperDrawer({required this.screenIdentifier,super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: [
          DrawerHeader(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: 
            [Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight)
          ),
          child: Row(
            children: [
              Icon(Icons.fastfood, color: Theme.of(context).colorScheme.primary,size: 30,),
              const SizedBox(width: 10,),
              Text("Cooking Up!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30
              ),)

            ],
          ),),
          ListTile(
            leading: Icon(Icons.restaurant, color: Theme.of(context).colorScheme.onBackground,
            size: 20,),
            title: Text("Meals", style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,fontSize: 20
            ),),
            onTap:(){
              screenIdentifier("meals");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.onBackground,
            size: 20,),
            title: Text("Filters", style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,fontSize: 20
            ),),
            onTap: (){
              screenIdentifier("filter");
            },
          )
        ],
      ),
      
    );
  }
}