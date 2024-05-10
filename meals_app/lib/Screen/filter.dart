import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Provider/filtersProvider.dart';

class Filters extends ConsumerWidget {
  
  const Filters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar( title: const Text("Filters"),),
      body: Column(
          children: [
            SwitchListTile(value: activeFilter[Filter.glutenFree]!, onChanged: (isChecked){
              ref.read(filterProvider.notifier).updateFilter(Filter.glutenFree, isChecked);
        
            }, title: Text("Gluten-Free", style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground )),
              subtitle: Text('Only iclude gluten-free meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground ),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),),
        
              SwitchListTile(value: activeFilter[Filter.lactoseFree]!, onChanged: (isChecked){
              ref.watch(filterProvider.notifier).updateFilter(Filter.lactoseFree, isChecked);
        
            }, title: Text("Lactose-Free", style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground )),
              subtitle: Text('Only iclude Lactose-Free meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground ),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),),
        
              SwitchListTile(value: activeFilter[Filter.vegetarian]!, onChanged: (isChecked){
              ref.watch(filterProvider.notifier).updateFilter(Filter.vegetarian, isChecked);
        
            }, title: Text("Vegetarian", style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground )),
              subtitle: Text('Only iclude Vegetarain meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground ),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),),
        
              SwitchListTile(value: activeFilter[Filter.vegan]!, onChanged: (isChecked){
              ref.read(filterProvider.notifier).updateFilter(Filter.vegan, isChecked);
        
            }, title: Text("Vegan", style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground )),
              subtitle: Text('Only iclude vegan meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground ),),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(right: 22, left: 34),),
          ],
        ),
    );
  }
}