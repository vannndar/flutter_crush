# Dokumentasi Game Flutter Crush

[![Watch the video](https://via.placeholder.com/600x400?text=Click+to+Watch)](https://drive.google.com/file/d/1RHBQRUr-hYWdbVJbeyPIvGaKoGbOWdjN/view)

## 📌 Gambaran Umum

Repositori ini berisi **game puzzle Match-3** yang dibangun dengan Flutter, menampilkan:

- **Mekanik game custom** (menukar tile, combo, ledakan)
- **Manajemen state** menggunakan pola BLoC
- **Animasi kompleks** (pergerakan tile, reaksi berantai)
- **Progres level** dengan tujuan

---

## 🧩 Widget Dasar yang Digunakan

### Komponen UI Inti

| Widget       | File             | Deskripsi                         |
| ------------ | ---------------- | --------------------------------- |
| `Scaffold`   | `home_page.dart` | Layout dasar halaman              |
| `Stack`      | `game_page.dart` | Menumpuk widget secara bertingkat |
| `GridView`   | `home_page.dart` | Menampilkan level dalam grid      |
| `Positioned` | `game_page.dart` | Penempatan widget absolut         |
| `Align`      | `game_page.dart` | Penyelarasan widget               |
| `Container`  | Berbagai file    | Wadah dasar untuk styling         |

### Widget Input/Output

| Widget                 | File             | Kegunaan                    |
| ---------------------- | ---------------- | --------------------------- |
| `GestureDetector`      | `game_page.dart` | Mendeteksi interaksi pemain |
| `FloatingActionButton` | `game_page.dart` | Tombol aksi utama           |

### Widget Teks & Gambar

| Widget  | File          | Fungsi                    |
| ------- | ------------- | ------------------------- |
| `Text`  | Berbagai file | Menampilkan teks          |
| `Image` | Berbagai file | Menampilkan gambar asset  |
| `Icon`  | Berbagai file | Menampilkan ikon Material |

---

## ⚙️ Kelas Custom

### Inti Game

| Kelas            | File                   | Tanggung Jawab       |
| ---------------- | ---------------------- | -------------------- |
| `GameBloc`       | `game_bloc.dart`       | Manajemen state game |
| `GameController` | `game_controller.dart` | Mekanik utama game   |

### Manajemen State

| Kelas           | File                  | Tujuan                 |
| --------------- | --------------------- | ---------------------- |
| `BlocProvider`  | `bloc_provider.dart`  | Penyedia BLoC          |
| `ObjectiveBloc` | `objective_bloc.dart` | Pelacakan tujuan level |

### Sistem Tile

| Kelas   | File               | Deskripsi                  |
| ------- | ------------------ | -------------------------- |
| `Tile`  | `model/tile.dart`  | Representasi tile game     |
| `Combo` | `model/combo.dart` | Hasil kombinasi tile       |
| `Swap`  | `model/swap.dart`  | Pertukaran tile yang valid |

### Animasi

| Kelas                | File                       | Fungsi                   |
| -------------------- | -------------------------- | ------------------------ |
| `AnimationsResolver` | `animations_resolver.dart` | Mengatur animasi         |
| `TileAnimation`      | `animations_resolver.dart` | Definisi animasi tunggal |

---

## 🎨 Kustom Stateless Widget

| Widget Name                | File                             | Description                                        | Key Features                                                                                         |
| -------------------------- | -------------------------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| **ObjectiveItem**          | `objective_item.dart`            | Menampilkan item objective dengan tile dan counter | - Menampilkan gambar tile sesuai jenis objective<br>- Menunjukkan jumlah yang perlu dikumpulkan      |
| **ObjectivePanel**         | `objective_panel.dart`           | Panel kumpulan objectives dalam level              | - Layout horizontal<br>- Desain rounded container dengan border<br>- Menggunakan StreamObjectiveItem |
| **ShadowedText**           | `shadowed_text.dart`             | Teks dengan efek bayangan                          | - Customizable shadow offset/opacity<br>- Stack dua layer teks                                       |
| **StreamMovesLeftCounter** | `stream_moves_left_counter.dart` | Penghitung gerakan tersisa                         | - Update real-time dengan StreamBuilder<br>- Menampilkan icon swap                                   |
| **DoubleCurvedContainer**  | `double_curved_container.dart`   | Container dengan kurva ganda                       | - Efek clipping custom<br>- Lapisan warna nested                                                     |
| **GameLevelButton**        | `game_level_button.dart`         | Tombol seleksi level                               | - Desain gradient dengan shadow<br>- Responsif terhadap tap                                          |
| **StreamObjectiveItem**    | `stream_objective_item.dart`     | ObjectiveItem versi dinamis                        | - Auto-update counter via stream<br>- Integrasi dengan BLoC                                          |
| **Board**                  | `board.dart`                     | Papan permainan utama                              | - Grid layout dinamis<br>- Auto-calculate tile dimensions                                            |

---

## 📖 Operasi CRUD

| File               | Create                                          | Read                                                  | Update                                         | Delete                                   |
| ------------------ | ----------------------------------------------- | ----------------------------------------------------- | ---------------------------------------------- | ---------------------------------------- |
| **tile.dart**      | `Tile()`, `Tile.clone()`, `cloneForAnimation()` | `widget`, `canMove`, `canFall`, `_buildDecoration()`  | `build()`, `setPosition()`, `swapRowColWith()` | Mengubah `type` ke `TileType.empty`      |
| **level.dart**     | `Level.fromJson()`                              | `numberOfRows`, `numberOfCols`, `index`, `toString()` | `resetObjectives()`, `decrementMove()`         | -                                        |
| **objective.dart** | `Objective()`                                   | `type`, `count`, `completed`                          | `decrement()`, `reset()`                       | -                                        |
| **chain.dart**     | `Chain()`                                       | `tiles`, `toString()`                                 | `addTile()`                                    | -                                        |
| **tile.dart**      | `Tile()`, `Tile.clone()`, `cloneForAnimation()` | `widget`, `canMove`, `canFall`, `_buildDecoration()`  | `build()`, `setPosition()`, `swapRowColWith()` | Mengubah `type` ke `TileType.empty`      |
| **level.dart**     | `Level.fromJson()`                              | `numberOfRows`, `numberOfCols`, `index`, `toString()` | `resetObjectives()`, `decrementMove()`         | -                                        |
| **objective.dart** | `Objective()`                                   | `type`, `count`, `completed`, `initialValue`          | `decrement()`, `reset()`                       | - (state management melalui `completed`) |
| **chain.dart**     | `Chain()`                                       | `tiles`, `toString()`                                 | `addTile()`                                    | -                                        |
