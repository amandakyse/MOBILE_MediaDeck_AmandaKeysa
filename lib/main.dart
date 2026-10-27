import 'package:flutter/material.dart';

void main() {
  runApp(const MediaDeckApp());
}

const Color bgColor = Color(0xFF101820);
const Color sidebarColor = Color(0xFF0B1118);
const Color cardColor = Color(0xFF202D3A);
const Color greenColor = Color(0xFF1ED760);
const Color textColor = Colors.white;
const Color mutedColor = Color(0xFFB3B3B3);

class Song {
  final String title;
  final String artist;
  final String imagePath;

  const Song({
    required this.title,
    required this.artist,
    required this.imagePath,
  });
}

const List<Song> songList = [
  Song(
    title: 'Candy',
    artist: 'NCT DREAM',
    imagePath: 'assets/candyndream.jpeg',
  ),
  Song(title: 'GO!', artist: 'CORTIS', imagePath: 'assets/cortisgo.jpeg'),
  Song(
    title: 'Cruel Summer',
    artist: 'Taylor Swift',
    imagePath: 'assets/cruelsummer.jpeg',
  ),
  Song(
    title: 'Die For You',
    artist: 'The Weeknd',
    imagePath: 'assets/dieforyou.jpeg',
  ),
  Song(
    title: 'Love You Like a Love Song',
    artist: 'Selena Gomez',
    imagePath: 'assets/loveyoulikealovesong.jpeg',
  ),
  Song(
    title: 'Mantra',
    artist: 'JENNIE',
    imagePath: 'assets/mantrajennie.jpeg',
  ),
  Song(
    title: 'Roar',
    artist: 'Katy Perry',
    imagePath: 'assets/roarkatyperry.jpeg',
  ),
  Song(
    title: 'Talking to the Moon',
    artist: 'Bruno Mars',
    imagePath: 'assets/talkingtothemoon.jpeg',
  ),
];

class MediaDeckApp extends StatelessWidget {
  const MediaDeckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediaDeck',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: greenColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<String> pageTitles = ['Home', 'Library', 'Pembuat'];

  void openPlayer(Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusicPlayerScreen(song: song)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(onSongTap: openPlayer),
      LibraryPage(onSongTap: openPlayer),
      const CreatorProfile(),
    ];

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 90,
            color: sidebarColor,
            child: NavigationRail(
              backgroundColor: sidebarColor,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              selectedIconTheme: const IconThemeData(
                color: greenColor,
                size: 27,
              ),
              unselectedIconTheme: const IconThemeData(
                color: mutedColor,
                size: 24,
              ),
              selectedLabelTextStyle: const TextStyle(
                color: greenColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: const TextStyle(
                color: mutedColor,
                fontSize: 12,
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.library_music_outlined),
                  selectedIcon: Icon(Icons.library_music),
                  label: Text('Library'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: Text('Pembuat'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: sidebarColor,
                    border: Border(
                      bottom: BorderSide(color: Color(0xFF26313B)),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.graphic_eq, color: greenColor, size: 28),
                      const SizedBox(width: 10),
                      const Text(
                        'MediaDeck',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text('•', style: TextStyle(color: mutedColor)),
                      const SizedBox(width: 12),
                      Text(
                        pageTitles[selectedIndex],
                        style: const TextStyle(color: mutedColor, fontSize: 15),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Cari lagu',
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: SongSearchDelegate(onSongTap: openPlayer),
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(index: selectedIndex, children: pages),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SongArtwork extends StatelessWidget {
  final Song song;
  final double size;
  final BorderRadius? borderRadius;

  const SongArtwork({
    super.key,
    required this.song,
    this.size = 150,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          song.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: cardColor,
              alignment: Alignment.center,
              child: const Icon(Icons.music_note, size: 45, color: greenColor),
            );
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(Song) onSongTap;

  const HomePage({super.key, required this.onSongTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat datang di MediaDeck',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Temukan lagu favoritmu dan nikmati musik pilihan.',
            style: TextStyle(color: mutedColor, fontSize: 15),
          ),
          const SizedBox(height: 30),
          const Text(
            'Pilihan Musik',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns = 2;

              if (constraints.maxWidth >= 1000) {
                columns = 4;
              } else if (constraints.maxWidth >= 650) {
                columns = 3;
              }

              final double itemWidth =
                  (constraints.maxWidth - ((columns - 1) * 18)) / columns;

              return Wrap(
                spacing: 18,
                runSpacing: 18,
                children: songList.map((song) {
                  return SizedBox(
                    width: itemWidth,
                    child: SongCard(song: song, onTap: () => onSongTap(song)),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;

  const SongCard({super.key, required this.song, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: SongArtwork(song: song, size: double.infinity),
              ),
              const SizedBox(height: 13),
              Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                song.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: mutedColor, fontSize: 13),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.play_circle_fill, color: greenColor, size: 25),
                  SizedBox(width: 6),
                  Text(
                    'Putar lagu',
                    style: TextStyle(color: greenColor, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  final Function(Song) onSongTap;

  const LibraryPage({super.key, required this.onSongTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Library Musik',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Kumpulan lagu yang tersedia di MediaDeck.',
            style: TextStyle(color: mutedColor),
          ),
          const SizedBox(height: 24),
          ...songList.map(
            (song) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: cardColor,
                borderRadius: BorderRadius.circular(10),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  leading: SongArtwork(
                    song: song,
                    size: 55,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  title: Text(
                    song.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(color: mutedColor),
                  ),
                  trailing: const Icon(
                    Icons.play_circle_outline,
                    color: greenColor,
                    size: 28,
                  ),
                  onTap: () => onSongTap(song),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreatorProfile extends StatelessWidget {
  const CreatorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 68,
                  backgroundColor: greenColor,
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: AssetImage('assets/profile.jpeg'),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Amanda Keysa',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Mahasiswa Teknik Informatika',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: mutedColor, fontSize: 15),
                ),
                const SizedBox(height: 25),
                const Divider(color: Color(0xFF3A4650)),
                const SizedBox(height: 12),
                const ProfileInfo(
                  icon: Icons.badge_outlined,
                  label: 'NPM',
                  value: '5520124003',
                ),
                const ProfileInfo(
                  icon: Icons.school_outlined,
                  label: 'Program Studi',
                  value: 'Teknik Informatika',
                ),
                const ProfileInfo(
                  icon: Icons.groups_outlined,
                  label: 'Kelas',
                  value: 'IF A 24',
                ),
                const SizedBox(height: 18),
                const Text(
                  'MediaDeck adalah aplikasi pemutar dan katalog musik '
                  'sederhana yang dibuat sebagai proyek pembelajaran.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: mutedColor, height: 1.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Icon(icon, color: greenColor, size: 23),
          const SizedBox(width: 13),
          SizedBox(
            width: 115,
            child: Text(label, style: const TextStyle(color: mutedColor)),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class MusicPlayerScreen extends StatefulWidget {
  final Song song;

  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool isPlaying = false;
  double progress = 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sidebarColor,
        title: const Text('Sedang Diputar'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SongArtwork(
                  song: widget.song,
                  size: 300,
                  borderRadius: BorderRadius.circular(16),
                ),
                const SizedBox(height: 28),
                Text(
                  widget.song.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.song.artist,
                  style: const TextStyle(color: mutedColor, fontSize: 17),
                ),
                const SizedBox(height: 25),
                Slider(
                  value: progress,
                  activeColor: greenColor,
                  inactiveColor: mutedColor,
                  onChanged: (value) {
                    setState(() {
                      progress = value;
                    });
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0:45', style: TextStyle(color: mutedColor)),
                    Text('3:20', style: TextStyle(color: mutedColor)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          progress = 0;
                        });
                      },
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 38,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                      ),
                      color: greenColor,
                      iconSize: 68,
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          progress = 1;
                        });
                      },
                      icon: const Icon(Icons.skip_next),
                      iconSize: 38,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Demo tampilan pemutar musik',
                  style: TextStyle(color: mutedColor, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SongSearchDelegate extends SearchDelegate<Song?> {
  final Function(Song) onSongTap;

  SongSearchDelegate({required this.onSongTap});

  @override
  String get searchFieldLabel => 'Cari judul atau penyanyi...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: sidebarColor,
        foregroundColor: textColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: mutedColor),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Hapus pencarian',
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Kembali',
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSongResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSongResults(context);
  }

  Widget _buildSongResults(BuildContext context) {
    final String keyword = query.toLowerCase();

    final List<Song> results = songList.where((song) {
      return song.title.toLowerCase().contains(keyword) ||
          song.artist.toLowerCase().contains(keyword);
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          'Lagu tidak ditemukan.',
          style: TextStyle(color: mutedColor),
        ),
      );
    }

    return Container(
      color: bgColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final song = results[index];

          return Card(
            color: cardColor,
            child: ListTile(
              leading: SongArtwork(
                song: song,
                size: 50,
                borderRadius: BorderRadius.circular(6),
              ),
              title: Text(song.title),
              subtitle: Text(
                song.artist,
                style: const TextStyle(color: mutedColor),
              ),
              trailing: const Icon(
                Icons.play_circle_outline,
                color: greenColor,
              ),
              onTap: () {
                close(context, song);
                onSongTap(song);
              },
            ),
          );
        },
      ),
    );
  }
}
