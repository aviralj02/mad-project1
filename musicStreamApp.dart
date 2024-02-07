import "dart:io";

abstract class MediaItem {
  late String title;
  late int duration;
}

class Song extends MediaItem with Logger implements Playable {
  late String artist;

  Song(String title, int duration, String artist) {
    this.title = title;
    this.duration = duration;
    this.artist = artist;
    if (title.isEmpty || duration <= 0 || artist.isEmpty) {
      logWarning("Invalid input for creating Song: $title, $duration, $artist");
    }
  }

  @override
  void play() {
    print("Playing song: $title by $artist");
  }
}

class Album extends MediaItem with Logger implements Playable {
  late String artist;
  late List<Song> tracks;

  Album(String title, int duration, String artist, List<Song> tracks) {
    this.title = title;
    this.duration = duration;
    this.artist = artist;
    this.tracks = tracks;
    if (title.isEmpty || duration <= 0 || artist.isEmpty || tracks.isEmpty) {
      logWarning(
          "Invalid input for creating Album: $title, $duration, $artist, $tracks");
    }
  }

  @override
  void play() {
    print("\nPlaying album: $title by $artist");
    for (var track in tracks) {
      track.play();
    }
  }
}

class Playlist extends MediaItem with Logger implements Playable {
  late List<Song> items;

  Playlist(String title, int duration, List<Song> items) {
    this.title = title;
    this.duration = duration;
    this.items = items;
    if (title.isEmpty || duration <= 0 || items.isEmpty) {
      logError("Invalid input for creating Album: $title, $duration, $items");
    }
  }

  @override
  void play() {
    print("\nPlaying playlist: $title");
    for (var item in items) {
      item.play();
    }
  }
}

mixin Playable {
  void play();
}

mixin Logger {
  void logWarning(String message) {
    print("WARNING: $message");
  }

  void logError(String message) {
    print("ERROR: $message");
  }
}

void main() {
  // var mySong = Song("Shape of You", 240, "Ed Sheeran");
  // mySong.play();

  // var song1 = Song("Song 1", 180, "Artist 1");
  // var song2 = Song("Song 2", 200, "Artist 2");
  // var album = Album("My Album", 40, "Artist", [song1, song2]);
  // album.play();

  // var playlist = Playlist("My Playlist", 80, [song1, song2]);
  // playlist.play();

  while (true) {
    print("\t\t\t\t \nMUSIC STREAMING APPLICATION");
    print("1. Create Album");
    print("2. Create Playlist");
    print("3. Exit");
    int input = int.parse(stdin.readLineSync()!);

    if (input == 1) {
      print("Artist of this album: ");
      String artist = stdin.readLineSync()!;
      print("Title of the album: ");
      String title = stdin.readLineSync()!;
      print("Duration of the album: ");
      int duration = int.parse(stdin.readLineSync()!);

      print("How many songs you want in your album: ");
      int n = int.parse(stdin.readLineSync()!);
      int i = 1;
      List<Song> tracks = [];
      while (i <= n) {
        print("\nEnter Song $i title: ");
        String stitle = stdin.readLineSync()!;
        print("Enter Song $i duration: ");
        int sDuration = int.parse(stdin.readLineSync()!);
        tracks.add(new Song(stitle, sDuration, artist));
        i++;
      }
      final album = new Album(title, duration, artist, tracks);
      print("\nAlbum Created");
      album.play();
    }
    if (input == 2) {
      print("Title of the playlist: ");
      String title = stdin.readLineSync()!;
      print("Duration of the playlist: ");
      int duration = int.parse(stdin.readLineSync()!);

      print("How many songs you want in your playlist: ");
      int n = int.parse(stdin.readLineSync()!);
      int i = 1;
      List<Song> items = [];
      while (i <= n) {
        print("\nEnter Song $i title: ");
        String stitle = stdin.readLineSync()!;
        print("Enter Song $i Artist: ");
        String sArtist = stdin.readLineSync()!;
        print("Enter Song $i duration: ");
        int sDuration = int.parse(stdin.readLineSync()!);
        items.add(new Song(stitle, sDuration, sArtist));
        i++;
      }
      final playlist = new Playlist(title, duration, items);
      print("\nPlaylist Created");
      playlist.play();
    }
    if (input == 3) {
      break;
    }
  }
}
