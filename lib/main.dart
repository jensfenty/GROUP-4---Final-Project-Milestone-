import 'package:flutter/material.dart';

void main() {
  runApp(const PottyPalApp());
}

// =====================
//  Root App Widget
// =====================
class PottyPalApp extends StatelessWidget {
  const PottyPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PottyPal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1976D2)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// =====================
//  Data Model
// =====================
class Restroom {
  final Color imageColor;
  final String name;
  final String address;
  final String distance;
  final double rating;
  final int reviewCount;
  final List<String> amenities;
  final Color cardColor;
  final bool isOpen;

  Restroom({
    required this.imageColor,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
    required this.cardColor,
    required this.isOpen,
  });
}

// =====================
//  Home Screen
// =====================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedFilter = 0; // 0 = All, 1 = Open Now, 2 = Top Rated

  static final List<Restroom> _restrooms = [
    Restroom(
      imageColor: const Color(0xFF0D47A1),
      name: 'Angeles City Library',
      address: 'Sto. Rosario St, Angeles City',
      distance: '55 m away',
      rating: 4.1,
      reviewCount: 28,
      amenities: ['Soap', 'Tissue', 'Lock', 'PWD'],
      cardColor: const Color(0xFFE3F2FD),
      isOpen: true,
    ),
    Restroom(
      imageColor: const Color(0xFF1976D2),
      name: 'Singku Cafe',
      address: 'MacArthur Hwy, Angeles City',
      distance: '120 m away',
      rating: 3.8,
      reviewCount: 14,
      amenities: ['Bidet', 'Soap', 'Lock'],
      cardColor: const Color(0xFFF3E5F5),
      isOpen: true,
    ),
    Restroom(
      imageColor: const Color(0xFF42A5F5),
      name: 'SM City Clark',
      address: 'Jose Abad Santos Ave, Clark',
      distance: '340 m away',
      rating: 4.6,
      reviewCount: 87,
      amenities: ['Bidet', 'Soap', 'Tissue', 'Lock', 'PWD'],
      cardColor: const Color(0xFFE8F5E9),
      isOpen: false,
    ),
  ];

  List<Restroom> get _filtered {
    switch (_selectedFilter) {
      case 1:
        return _restrooms.where((r) => r.isOpen).toList();
      case 2:
        return [..._restrooms]..sort((a, b) => b.rating.compareTo(a.rating));
      default:
        return _restrooms;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    final openCount = _restrooms.where((r) => r.isOpen).length;
    final avgRating = (_restrooms.fold(0.0, (s, r) => s + r.rating) /
            _restrooms.length)
        .toStringAsFixed(1);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: CustomScrollView(
        slivers: [
          // ── Gradient header with search bar ──
          SliverAppBar(
            expandedHeight: 190,
            pinned: true,
            backgroundColor: const Color(0xFF1565C0),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: const Text(
                'PottyPal',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF0288D1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.white70, size: 16),
                            const SizedBox(width: 4),
                            const Text(
                              'Angeles City, Pampanga',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                            const Spacer(),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white24,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.person_outline,
                                    color: Colors.white, size: 18),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Search bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search restrooms...',
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.blueGrey),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Stats row ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  _StatCard(
                    icon: Icons.wc,
                    value: '${_restrooms.length}',
                    label: 'Nearby',
                    color: const Color(0xFF1565C0),
                  ),
                  const SizedBox(width: 10),
                  _StatCard(
                    icon: Icons.access_time,
                    value: '$openCount',
                    label: 'Open Now',
                    color: Colors.green[700]!,
                  ),
                  const SizedBox(width: 10),
                  _StatCard(
                    icon: Icons.star,
                    value: avgRating,
                    label: 'Avg Rating',
                    color: Colors.amber[700]!,
                  ),
                ],
              ),
            ),
          ),

          // ── Section header + filter chips ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restrooms Near You',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[850],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _FilterChipWidget(
                          label: 'All',
                          index: 0,
                          selected: _selectedFilter,
                          onTap: (i) =>
                              setState(() => _selectedFilter = i),
                        ),
                        const SizedBox(width: 8),
                        _FilterChipWidget(
                          label: 'Open Now',
                          index: 1,
                          selected: _selectedFilter,
                          onTap: (i) =>
                              setState(() => _selectedFilter = i),
                        ),
                        const SizedBox(width: 8),
                        _FilterChipWidget(
                          label: 'Top Rated',
                          index: 2,
                          selected: _selectedFilter,
                          onTap: (i) =>
                              setState(() => _selectedFilter = i),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Restroom cards list ──
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  RestroomCard(restroom: filtered[index]),
              childCount: filtered.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add New Restroom — coming soon!'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        backgroundColor: const Color(0xFF1565C0),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Restroom',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

// =====================
//  Restroom Card
// =====================
class RestroomCard extends StatelessWidget {
  final Restroom restroom;

  const RestroomCard({super.key, required this.restroom});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: restroom.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- image with overlay badges ---
          Stack(
            children: [
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      restroom.imageColor,
                      restroom.imageColor.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Icon(Icons.wc, size: 60,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ),
              // dark gradient at bottom of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.55),
                      ],
                    ),
                  ),
                ),
              ),
              // distance badge (top-left)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.near_me,
                          color: Colors.white, size: 12),
                      const SizedBox(width: 4),
                      Text(
                        restroom.distance,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              // open/closed badge (top-right)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: restroom.isOpen ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        restroom.isOpen
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restroom.isOpen ? 'Open' : 'Closed',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              // rating badge (bottom-left on image)
              Positioned(
                bottom: 8,
                left: 10,
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      '${restroom.rating}  (${restroom.reviewCount})',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // --- card body ---
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name + bookmark
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        restroom.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border,
                          color: Colors.blueGrey),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // address
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: Color(0xFF1565C0)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        restroom.address,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // amenity chips
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: restroom.amenities
                      .map((a) => _AmenityChip(label: a))
                      .toList(),
                ),
                const SizedBox(height: 14),

                // action buttons
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Getting directions to ${restroom.name}...'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.directions, size: 16),
                        label: const Text('Directions'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1565C0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Rate ${restroom.name}...'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.star_outline, size: 16),
                        label: const Text('Rate'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF1565C0),
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          side: const BorderSide(color: Color(0xFF1565C0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================
//  Helper: Stat Card
// =====================
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =====================
//  Helper: Filter Chip
// =====================
class _FilterChipWidget extends StatelessWidget {
  final String label;
  final int index;
  final int selected;
  final void Function(int) onTap;

  const _FilterChipWidget({
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selected;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1565C0)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1565C0)
                : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1565C0).withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// =====================
//  Helper: Star Rating
// =====================
class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (i < rating) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }
}

// =====================
//  Helper: Amenity Chip
// =====================
class _AmenityChip extends StatelessWidget {
  final String label;

  const _AmenityChip({required this.label});

  static const Map<String, IconData> _icons = {
    'Bidet': Icons.water_drop,
    'Soap': Icons.soap,
    'Tissue': Icons.receipt_long,
    'Lock': Icons.lock,
    'PWD': Icons.accessible,
  };

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        _icons[label] ?? Icons.check_circle_outline,
        size: 14,
        color: const Color(0xFF1976D2),
      ),
      label: Text(label, style: const TextStyle(fontSize: 11)),
      padding: const EdgeInsets.symmetric(horizontal: 2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFF1976D2), width: 0.8),
    );
  }
}
