import 'package:flutter/material.dart';
import 'package:mydota/view_model/list_hero_provider.dart';

class HeroFilter extends StatelessWidget {
  final ListHeroProvider listHeroProvider;
  const HeroFilter({super.key, required this.listHeroProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterChip(
          label: const Text('No Filter'),
          selected: listHeroProvider.isNoFilterSelected,
          onSelected: (selected) {
            if (selected) {
              listHeroProvider.clearFilters();
            }
          },
        ),
        const Text('Primary Attribute'),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text('Strength'),
              selected: listHeroProvider.isFilterSelected('str'),
              onSelected: (selected) {
                if (selected) {
                  listHeroProvider.removeFilter('agi');
                  listHeroProvider.removeFilter('int');
                  listHeroProvider.removeFilter('all');
                  listHeroProvider.addFilter('str');
                } else {
                  listHeroProvider.removeFilter('str');
                }
              },
            ),
            FilterChip(
              label: const Text('Agility'),
              selected: listHeroProvider.isFilterSelected('agi'),
              onSelected: (selected) {
                if (selected) {
                  listHeroProvider.removeFilter('str');
                  listHeroProvider.removeFilter('int');
                  listHeroProvider.removeFilter('all');
                  listHeroProvider.addFilter('agi');
                } else {
                  listHeroProvider.removeFilter('agi');
                }
              },
            ),
            FilterChip(
              label: const Text('Intelligence'),
              selected: listHeroProvider.isFilterSelected('int'),
              onSelected: (selected) {
                if (selected) {
                  listHeroProvider.removeFilter('agi');
                  listHeroProvider.removeFilter('str');
                  listHeroProvider.removeFilter('all');
                  listHeroProvider.addFilter('int');
                } else {
                  listHeroProvider.removeFilter('int');
                }
              },
            ),
            FilterChip(
              label: const Text('Universal'),
              selected: listHeroProvider.isFilterSelected('all'),
              onSelected: (selected) {
                if (selected) {
                  listHeroProvider.removeFilter('agi');
                  listHeroProvider.removeFilter('int');
                  listHeroProvider.removeFilter('str');
                  listHeroProvider.addFilter('all');
                } else {
                  listHeroProvider.removeFilter('all');
                }
              },
            ),
          ],
        ),
        const Text('Attack Type'),
        Wrap(
          spacing: 8,
          children: [
            FilterChip(
              label: const Text('Melee'),
              selected: listHeroProvider.isFilterSelected('Melee'),
              onSelected: (selected) {
                if (selected) {
                  listHeroProvider.addFilter('Melee');
                  listHeroProvider.removeFilter('Ranged');
                } else {
                  listHeroProvider.removeFilter('Melee');
                }
              },
            ),
            FilterChip(
              label: const Text('Ranged'),
              selected: listHeroProvider.isFilterSelected('Ranged'),
              onSelected: (selected) {
                if (selected) {
                  listHeroProvider.addFilter('Ranged');
                  listHeroProvider.removeFilter('Melee');
                } else {
                  listHeroProvider.removeFilter('Ranged');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
