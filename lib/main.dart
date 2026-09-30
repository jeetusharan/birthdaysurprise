import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  const BirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Birthday Surprise',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Arial',
      ),
      home: const OpeningScreen(),
    );
  }
}

// ============================================================
// PAGE 1 — OPENING
// ============================================================

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen>
    with TickerProviderStateMixin {
  late AnimationController heartController;
  late AnimationController fadeController;

  late Animation<double> heartAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    heartAnimation = Tween<double>(
      begin: 0.85,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: heartController,
        curve: Curves.easeInOut,
      ),
    );

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );

    fadeController.forward();
  }

  @override
  void dispose() {
    heartController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  void openSurprise() {
    Navigator.push(
      context,
      _pageTransition(const MessageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050208),
      body: Stack(
        children: [
          const ParticleBackground(),

          Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'A LITTLE SURPRISE',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Made especially for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const FloatingPhotoSticker(),

                    const SizedBox(height: 35),

                    ScaleTransition(
                      scale: heartAnimation,
                      child: const Text(
                        '❤️',
                        style: TextStyle(
                          fontSize: 105,
                          shadows: [
                            Shadow(
                              color: Colors.pink,
                              blurRadius: 35,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    GestureDetector(
                      onTap: openSurprise,
                      child: const GradientButton(
                        text: 'OPEN YOUR SURPRISE',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PAGE 2 — MESSAGE + LETTER
// ============================================================

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    scaleAnimation = Tween<double>(
      begin: 0.75,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void continueToMemory() {
    Navigator.push(
      context,
      _pageTransition(const MemoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100512),
      body: Stack(
        children: [
          const ParticleBackground(),

          SafeArea(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '✨',
                          style: TextStyle(fontSize: 60),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'WAIT...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            letterSpacing: 4,
                          ),
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          'There is something\nI made just for you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 28),

                        Container(
                          width: 110,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.pinkAccent,
                                Colors.purpleAccent,
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                            ),
                          ),
                          child: const Text(
                            'Some moments are too special\nto simply be forgotten...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 45),

                        const AnimatedLetter(),

                        const SizedBox(height: 45),

                        GestureDetector(
                          onTap: continueToMemory,
                          child: const GradientButton(
                            text: 'CONTINUE TO THE MEMORIES ✨',
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '← Back',
                            style: TextStyle(
                              color: Colors.white54,
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
        ],
      ),
    );
  }
}

// ============================================================
// ANIMATED LETTER
// ============================================================

class AnimatedLetter extends StatefulWidget {
  const AnimatedLetter({super.key});

  @override
  State<AnimatedLetter> createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter>
    with SingleTickerProviderStateMixin {
  late AnimationController letterController;

  bool opened = false;

  final List<String> letterLines = [
    'Dear My Closest Person,',

    'I know it must be difficult for you to tolerate a person like me. 😅',

    'You have been suffering because of me for almost three years now,',
    'and honestly, you deserve a medal for that! 😂',

    'But there’s still a lot more for us to celebrate together',
    'throughout our lives, so you better become a little stronger. 😤❤️',

    'Anyways, my dear, a very, very happy birthday to you! 🎉🥳',

    'I really wish we could celebrate your birthday together, offline.',

    'I don’t have much to give you, but these are a few little things',
    'that I can do for you.',

    'I put them together with all my heart,',
    'and I genuinely hope you love them. ❤️',

    'And now, a little something for the birthday girl:',

    'Ye bekhudi, ye labon ki hansi mubarak ho,',
    'Tumhe tumhara janamdin mubarak ho. 🎉',

    'Na aaye koi gham kareeb tumhare, 🛡️',
    'Khushiyon se bhari ho zindagi tumhari. 💃',

    'Ho poore sapne tumhare, 👩🏻‍⚕️',
    'Itna buland ho iraada tumhara. 💪',

    'Khuloos se bhari ho zindagi tumhari,',
    'Tumhe janamdin mubarak ho. 🎉',

    '🥳❤️',

    'Happy Birthday once again.',

    'I hope this little surprise brings a smile to your face—',
    'because that’s the least I can do for someone',
    'who has tolerated me for almost three years. 😅❤️',
  ];

  @override
  void initState() {
    super.initState();

    letterController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: letterLines.length * 550,
      ),
    );
  }

  @override
  void dispose() {
    letterController.dispose();
    super.dispose();
  }

  void openLetter() {
    setState(() {
      opened = true;
    });

    letterController.forward(from: 0);
  }

  Animation<double> lineAnimation(int index) {
    final total = letterLines.length;

    final start = index / total;

    final end = min(
      1.0,
      start + (0.75 / total),
    );

    return CurvedAnimation(
      parent: letterController,
      curve: Interval(
        start,
        end,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      width: double.infinity,
      padding: EdgeInsets.all(opened ? 22 : 28),
      decoration: BoxDecoration(
        color: opened
            ? const Color(0xFFFFF8E7)
            : Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: opened
              ? Colors.amber.withOpacity(0.35)
              : Colors.white.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: opened
                ? Colors.amber.withOpacity(0.15)
                : Colors.pinkAccent.withOpacity(0.12),
            blurRadius: 35,
            spreadRadius: 2,
          ),
        ],
      ),
      child: opened
          ? _buildOpenLetter()
          : _buildClosedLetter(),
    );
  }

  Widget _buildClosedLetter() {
    return GestureDetector(
      onTap: openLetter,
      child: Column(
        children: [
          const Text(
            '💌',
            style: TextStyle(fontSize: 65),
          ),

          const SizedBox(height: 15),

          const Text(
            'A LETTER FOR YOU',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Tap to open',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.purpleAccent,
                ],
              ),
            ),
            child: const Text(
              'OPEN LETTER 💌',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenLetter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'A LETTER FOR YOU',
            style: TextStyle(
              color: Color(0xFF5C3545),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Container(
          height: 2,
          width: double.infinity,
          color: const Color(0xFFDFC9A7),
        ),

        const SizedBox(height: 25),

        ...List.generate(
          letterLines.length,
          (index) {
            final animation = lineAnimation(index);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.15),
                  end: Offset.zero,
                ).animate(animation),
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: Text(
                    letterLines[index],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color(0xFF39242B),
                      fontSize: index == 0
                          ? 18
                          : 15.5,
                      fontWeight: index == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                      height: 1.55,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        Center(
          child: AnimatedBuilder(
            animation: letterController,
            builder: (context, child) {
              final visible =
                  letterController.value > 0.97;

              return AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                opacity: visible ? 1 : 0,
                child: child,
              );
            },
            child: const Text(
              '❤️',
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PAGE 3 — THREE VIDEOS
// ============================================================

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void continueToFinal() {
    Navigator.push(
      context,
      _pageTransition(const JourneyMemoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08030D),
      body: Stack(
        children: [
          const ParticleBackground(),

          SafeArea(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                child: Column(
                  children: [
                    const Text(
                      'A LITTLE MEMORY 🎬',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        letterSpacing: 4,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Three little pieces of a story',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Press play when you are ready.',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 35),

                    const MemoryVideoCard(
                      number: '01',
                      title: 'THE FIRST MEMORY',
                      subtitle: 'A little beginning...',
                      assetPath: 'assets/videos/video1.mp4',
                    ),

                    const SizedBox(height: 30),

                    const MemoryVideoCard(
                      number: '02',
                      title: 'THE LITTLE MOMENTS',
                      subtitle: 'The moments worth remembering...',
                      assetPath: 'assets/videos/video2.mp4',
                    ),

                    const SizedBox(height: 30),

                    const MemoryVideoCard(
                      number: '03',
                      title: 'ONE MORE MEMORY',
                      subtitle: 'And here is another little surprise...',
                      assetPath: 'assets/videos/video3.mp4',
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      'Every memory has a story...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                    const SizedBox(height: 40),

                    GestureDetector(
                      onTap: continueToFinal,
                      child: const GradientButton(
                        text: 'ENTER THE MEMORY JOURNEY ✨',
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '← Back',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VIDEO CARD
// ============================================================

class MemoryVideoCard extends StatefulWidget {
  final String number;
  final String title;
  final String subtitle;
  final String assetPath;

  const MemoryVideoCard({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.assetPath,
  });

  @override
  State<MemoryVideoCard> createState() => _MemoryVideoCardState();
}

class _MemoryVideoCardState extends State<MemoryVideoCard> {
  late VideoPlayerController videoController;

  bool initialized = false;
  bool loading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      videoController = VideoPlayerController.asset(widget.assetPath);

      await videoController.initialize();

      // Make sure the video is not muted.
      await videoController.setVolume(1.0);

      if (!mounted) return;

      setState(() {
        initialized = true;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        errorMessage = 'Unable to load this video';
      });
    }
  }

  @override
  void dispose() {
    if (initialized) {
      videoController.dispose();
    }
    super.dispose();
  }

  Future<void> toggleVideo() async {
    if (!initialized) return;

    if (videoController.value.isPlaying) {
      await videoController.pause();
    } else {
      await videoController.setVolume(1.0);
      await videoController.play();
    }

    if (mounted) {
      setState(() {});
    }
  }

  String formatDuration(Duration duration) {
    final minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');

    final seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.045),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.15),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // VIDEO HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.pinkAccent.withOpacity(0.15),
                    ),
                    child: Text(
                      widget.number,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // VIDEO
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: SizedBox(
                height: 230,
                child: loading
                    ? Container(
                        color: const Color(0xFF160A1D),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.pinkAccent,
                          ),
                        ),
                      )
                    : errorMessage != null
                        ? Container(
                            color: const Color(0xFF160A1D),
                            child: Center(
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(videoController),

                              // PLAY / PAUSE BUTTON
                              GestureDetector(
                                onTap: toggleVideo,
                                child: AnimatedOpacity(
                                  duration:
                                      const Duration(milliseconds: 200),
                                  opacity: videoController.value.isPlaying
                                      ? 0.0
                                      : 1.0,
                                  child: Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.65),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 38,
                                    ),
                                  ),
                                ),
                              ),

                              // PROGRESS BAR
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 8,
                                child: VideoProgressIndicator(
                                  videoController,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(
                                    playedColor: Colors.pinkAccent,
                                    bufferedColor:
                                        Colors.white.withOpacity(0.3),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.15),
                                  ),
                                ),
                              ),

                              // TIME
                              Positioned(
                                right: 14,
                                bottom: 18,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.55),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${formatDuration(videoController.value.position)} / ${formatDuration(videoController.value.duration)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
              ),
            ),

            const SizedBox(height: 10),

            // AUDIO / PLAY INFORMATION
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.volume_up_rounded,
                  color: Colors.white.withOpacity(0.55),
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Sound on',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
/// ============================================================
// PAGE 4 — INTERACTIVE MEMORY JOURNEY
// ============================================================


// ============================================================
// PAGE 4 MEMORY DATA
// ============================================================

class JourneyMemory {
  final String caption;
  final String image;
  final String question;
  final String revealText;
  final bool hasQuestion;

  const JourneyMemory({
    required this.caption,
    required this.image,
    required this.question,
    required this.revealText,
    this.hasQuestion = true,
  });
}


// ============================================================
// PAGE 4 — MEMORY JOURNEY SCREEN
// ============================================================

class JourneyMemoryScreen extends StatefulWidget {
  const JourneyMemoryScreen({super.key});

  @override
  State<JourneyMemoryScreen> createState() =>
      _JourneyMemoryScreenState();
}

class _JourneyMemoryScreenState extends State<JourneyMemoryScreen> {
  final List<JourneyMemory> memories = const [
    JourneyMemory(
      caption: "The Beginning",
      image: "assets/memories/photo1.jpg",
      question: "What is this? Do you have any idea?",
      revealText:
          "A little moment that became the beginning of something special. ❤️",
    ),

    JourneyMemory(
      caption: "The Little Moments",
      image: "assets/memories/photo2.jpg",
      question: "Which one among these was taken first?",
      revealText: "Correct! ❤️",
    ),

    JourneyMemory(
      caption: "The Favourite One",
      image: "assets/memories/photo3.jpg",
      question:
          "Why is this photo my favourite one? Can you tell me?",
      revealText:
          "Because some pictures are not just pictures... "
          "they carry a feeling that is difficult to explain. ❤️",
    ),

    JourneyMemory(
      caption: "Himanshini in Traditional 💎",
      image: "assets/memories/photo4.jpg",
      question: "Which dress did you wear for which festival?",
      revealText:
          "A beautiful traditional look that deserves its own little memory. 💎",
    ),

    JourneyMemory(
      caption: "Thankyou",
      image: "assets/memories/photo5.jpg",
      question: "",
      revealText:
          "A big thank you and lots of love for you ❤️",
      hasQuestion: false,
    ),
  ];

  int currentIndex = 0;

  void nextMemory() {
    if (currentIndex < memories.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FinalScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final memory = memories[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.15, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: JourneyMemoryCard(
            key: ValueKey(currentIndex),
            memory: memory,
            index: currentIndex,
            total: memories.length,
            onNext: nextMemory,
          ),
        ),
      ),
    );
  }
}


// ============================================================
// PAGE 4 — MEMORY CARD
// IMPORTANT:
// This is JourneyMemoryCard, NOT MemoryVideoCard.
// ============================================================

class JourneyMemoryCard extends StatefulWidget {
  final JourneyMemory memory;
  final int index;
  final int total;
  final VoidCallback onNext;

  const JourneyMemoryCard({
    super.key,
    required this.memory,
    required this.index,
    required this.total,
    required this.onNext,
  });

  @override
  State<JourneyMemoryCard> createState() =>
      _JourneyMemoryCardState();
}

class _JourneyMemoryCardState
    extends State<JourneyMemoryCard> {

  bool revealed = false;
  String? selectedAnswer;

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  bool get isCorrect {
    return selectedAnswer == "B";
  }

  @override
  Widget build(BuildContext context) {
    final bool isQuestionTwo = widget.index == 1;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      child: Column(
        children: [

          // --------------------------------------------------
          // PROGRESS
          // --------------------------------------------------

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "MEMORY ${widget.index + 1}",
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),

              Text(
                "${widget.index + 1} / ${widget.total}",
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          LinearProgressIndicator(
            value:
                (widget.index + 1) / widget.total,
            minHeight: 2,
            backgroundColor: Colors.white12,
            valueColor:
                const AlwaysStoppedAnimation<Color>(
              Colors.white70,
            ),
          ),

          const SizedBox(height: 30),

          // --------------------------------------------------
          // TITLE
          // --------------------------------------------------

          Text(
            widget.memory.caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 22),

          // --------------------------------------------------
          // PHOTO
          // --------------------------------------------------

          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              widget.memory.image,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  height: 280,
                  alignment: Alignment.center,
                  color: Colors.white10,
                  child: const Text(
                    "Photo not found",
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // --------------------------------------------------
          // QUESTIONS
          // --------------------------------------------------

          if (widget.memory.hasQuestion) ...[

            Text(
              widget.memory.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------
            // QUESTION 2 — A / B / C
            // ------------------------------------------------

            if (isQuestionTwo) ...[

              answerButton("A"),

              const SizedBox(height: 12),

              answerButton("B"),

              const SizedBox(height: 12),

              answerButton("C"),

              const SizedBox(height: 20),

              if (selectedAnswer != null)
                Text(
                  isCorrect
                      ? "Correct! ❤️"
                      : "Not this one 😄 Try again!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isCorrect
                        ? Colors.white
                        : Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              if (isCorrect) ...[
                const SizedBox(height: 25),
                nextButton(),
              ],
            ]

            // ------------------------------------------------
            // OTHER QUESTIONS
            // ------------------------------------------------

            else ...[

              if (!revealed)

                revealButton()

              else ...[

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:
                        Colors.white.withOpacity(0.06),
                    borderRadius:
                        BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  child: Text(
                    widget.memory.revealText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                nextButton(),
              ],
            ],
          ]

          // --------------------------------------------------
          // THANK YOU MEMORY
          // --------------------------------------------------

          else ...[

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(0.06),
                borderRadius:
                    BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white12,
                ),
              ),
              child: const Text(
                "A big thank you and lots of love for you ❤️",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 30),

            nextButton(),
          ],

          const SizedBox(height: 35),
        ],
      ),
    );
  }


  // ==========================================================
  // ANSWER BUTTON
  // ==========================================================

  Widget answerButton(String answer) {
    final bool selected =
        selectedAnswer == answer;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          selectAnswer(answer);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selected
              ? Colors.white.withOpacity(0.16)
              : Colors.white.withOpacity(0.06),
          foregroundColor: Colors.white,
          padding:
              const EdgeInsets.symmetric(
            vertical: 17,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15),
            side: BorderSide(
              color: selected
                  ? Colors.white54
                  : Colors.white12,
            ),
          ),
          elevation: 0,
        ),
        child: Text(
          answer,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  // ==========================================================
  // REVEAL BUTTON
  // ==========================================================

  Widget revealButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            revealed = true;
          });
        },
        icon: const Icon(
          Icons.auto_awesome,
        ),
        label: const Text(
          "Reveal the memory ✨",
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.white.withOpacity(0.10),
          foregroundColor: Colors.white,
          padding:
              const EdgeInsets.symmetric(
            vertical: 17,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
            side: const BorderSide(
              color: Colors.white24,
            ),
          ),
          elevation: 0,
        ),
      ),
    );
  }


  // ==========================================================
  // NEXT BUTTON
  // ==========================================================

  Widget nextButton() {
    final bool last =
        widget.index == widget.total - 1;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding:
              const EdgeInsets.symmetric(
            vertical: 17,
          ),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          last
              ? "Continue ❤️"
              : "Next Memory →",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


// ============================================================
// FINAL BIRTHDAY SCREEN
// ============================================================

class FinalScreen extends StatelessWidget {
  const FinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [

                const Text(
                  "Happy Birthday",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Here is to all the little moments "
                  "we have shared, and all the beautiful "
                  "ones still waiting for us.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "🎉 ❤️ 🎂",
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white24,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "Made especially for you ❤️",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ============================================================
// FLOATING PHOTO
// ============================================================

class FloatingPhotoSticker extends StatefulWidget {
  const FloatingPhotoSticker({super.key});

  @override
  State<FloatingPhotoSticker> createState() =>
      _FloatingPhotoStickerState();
}

class _FloatingPhotoStickerState
    extends State<FloatingPhotoSticker>
    with TickerProviderStateMixin {
  late AnimationController floatController;
  late AnimationController entranceController;

  late Animation<double> floatAnimation;
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    final curvedFloat = CurvedAnimation(
      parent: floatController,
      curve: Curves.easeInOut,
    );

    floatAnimation = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(curvedFloat);

    rotationAnimation = Tween<double>(
      begin: -0.045,
      end: 0.045,
    ).animate(curvedFloat);

    entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    scaleAnimation = CurvedAnimation(
      parent: entranceController,
      curve: Curves.easeOutBack,
    );

    fadeAnimation = CurvedAnimation(
      parent: entranceController,
      curve: Curves.easeIn,
    );

    entranceController.forward();
  }

  @override
  void dispose() {
    floatController.dispose();
    entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        floatController,
        entranceController,
      ]),
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(
              0,
              floatAnimation.value,
            ),
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: Transform.rotate(
                angle: rotationAnimation.value,
                child: Container(
                  width: 125,
                  padding: const EdgeInsets.fromLTRB(
                    7,
                    7,
                    7,
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent
                            .withOpacity(0.40),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                      BoxShadow(
                        color: Colors.purpleAccent
                            .withOpacity(0.20),
                        blurRadius: 35,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/her_photo.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================
// GRADIENT BUTTON
// ============================================================

class GradientButton extends StatelessWidget {
  final String text;

  const GradientButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          colors: [
            Colors.pinkAccent,
            Colors.purpleAccent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.45),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ============================================================
// PARTICLE BACKGROUND
// ============================================================

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() =>
      _ParticleBackgroundState();
}

class _ParticleBackgroundState
    extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final List<Offset> particles = List.generate(
    45,
    (index) => Offset(
      Random().nextDouble(),
      Random().nextDouble(),
    ),
  );

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: ParticlePainter(
            particles: particles,
            animationValue: controller.value,
          ),
        );
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Offset> particles;
  final double animationValue;

  ParticlePainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint();

    for (int i = 0;
        i < particles.length;
        i++) {
      final particle = particles[i];

      final double y =
          (particle.dy +
                  animationValue * 0.15) %
              1.0;

      paint.color = Colors.pinkAccent.withOpacity(
        0.15 + (i % 4) * 0.1,
      );

      canvas.drawCircle(
        Offset(
          particle.dx * size.width,
          y * size.height,
        ),
        1.5 + (i % 3),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant ParticlePainter oldDelegate,
  ) {
    return true;
  }
}

// ============================================================
// PAGE TRANSITION
// ============================================================

PageRouteBuilder _pageTransition(
  Widget page,
) {
  return PageRouteBuilder(
    transitionDuration:
        const Duration(milliseconds: 1100),
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) {
      return page;
    },
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final scale = Tween<double>(
        begin: 1.08,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      );

      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: scale,
          child: child,
        ),
      );
    },
  );
}