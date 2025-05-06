# Alur Kerja (Workflow) Aplikasi Hirup Aing

## 1. Autentikasi & Manajemen Akun

### 1.1. Registrasi
1. User mengakses halaman registrasi
2. User memasukkan email, password, dan nama
3. Sistem melakukan validasi data input
4. Jika valid, sistem membuat akun baru
5. User diarahkan ke halaman login atau langsung ke dashboard

### 1.2. Login
1. User mengakses halaman login
2. User memasukkan email dan password
3. Sistem memverifikasi kredensial
4. Jika valid, user diarahkan ke dashboard dengan data sesuai akun mereka
5. Jika tidak valid, tampilkan pesan error

### 1.3. Logout
1. User menekan tombol logout
2. Sistem menghapus sesi user
3. User diarahkan ke halaman login

## 2. Manajemen Kategori

### 2.1. Melihat Kategori
1. User mengakses halaman kategori
2. Sistem menampilkan daftar kategori milik user tersebut

### 2.2. Membuat Kategori Baru
1. User memilih opsi "Tambah Kategori"
2. User memasukkan nama kategori
3. Sistem memeriksa apakah nama kategori sudah ada untuk user tersebut
4. Jika belum ada, sistem menyimpan kategori baru
5. Kategori baru ditampilkan di daftar kategori

### 2.3. Mengedit Kategori
1. User memilih kategori yang ingin diedit
2. User mengubah nama kategori
3. Sistem memeriksa keunikan nama kategori
4. Jika valid, sistem memperbarui data kategori

### 2.4. Menghapus Kategori
1. User memilih kategori yang ingin dihapus
2. Sistem menampilkan konfirmasi penghapusan
3. Jika dikonfirmasi, sistem menghapus kategori (dan menghapus relasi dengan aktivitas terkait)

## 3. Manajemen Aktivitas Master

### 3.1. Membuat Aktivitas Baru
1. User mengakses halaman "Tambah Aktivitas"
2. User mengisi detail aktivitas:
   - Nama
   - Deskripsi (opsional)
   - Waktu mulai
   - Waktu selesai
   - Pengaturan pengulangan:
     - Frekuensi (harian/mingguan/bulanan)
     - Untuk mingguan: pilih hari dalam seminggu
     - Untuk bulanan: pilih tanggal dalam sebulan
   - Kategori (bisa lebih dari satu)
3. Sistem memvalidasi data
4. Sistem menyimpan definisi aktivitas (Activity Master)
5. Sistem membuat instance aktivitas sesuai pengaturan pengulangan

### 3.2. Melihat Daftar Aktivitas Master
1. User mengakses halaman "Daftar Aktivitas"
2. Sistem menampilkan semua aktivitas master milik user
3. User dapat mengurutkan atau memfilter berdasarkan nama, kategori, atau frekuensi

### 3.3. Mengedit Aktivitas Master
1. User memilih aktivitas yang ingin diedit
2. User mengubah detail yang diinginkan
3. Sistem memvalidasi perubahan
4. Jika valid, sistem menyimpan perubahan
5. Sistem memperbarui instance aktivitas yang belum terjadi jika diperlukan

### 3.4. Menghapus Aktivitas Master
1. User memilih aktivitas yang ingin dihapus
2. Sistem menampilkan konfirmasi penghapusan
3. Jika dikonfirmasi, sistem menghapus aktivitas master dan semua instance terkait

## 4. Manajemen Instance Aktivitas

### 4.1. Melihat Aktivitas Hari Ini
1. User membuka aplikasi dan masuk ke dashboard
2. Sistem menampilkan semua instance aktivitas untuk tanggal hari ini
3. Aktivitas dikelompokkan berdasarkan waktu atau kategori

### 4.2. Melihat Aktivitas untuk Tanggal Tertentu
1. User memilih tanggal dari kalender atau input tanggal
2. Sistem menampilkan semua instance aktivitas untuk tanggal tersebut

### 4.3. Memperbarui Status Aktivitas
1. User memilih instance aktivitas
2. User mengubah status menjadi "Selesai", "Ditunda", atau "Batalkan"
3. User dapat menambahkan catatan jika diperlukan
4. Sistem menyimpan perubahan status dan catatan

### 4.4. Mengedit Instance Aktivitas Spesifik
1. User memilih instance aktivitas
2. User mengedit detail khusus untuk instance tersebut (catatan atau status)
3. Sistem menyimpan perubahan hanya untuk instance tersebut

## 5. Visualisasi dan Statistik

### 5.1. Melihat Kalender Bulanan
1. User mengakses tampilan kalender
2. Sistem menampilkan kalender dengan indikator aktivitas pada setiap tanggal
3. User dapat memilih tanggal untuk melihat detail aktivitas

### 5.2. Melihat Statistik Aktivitas
1. User mengakses halaman statistik
2. Sistem menampilkan visualisasi statistik:
   - Jumlah aktivitas berdasarkan status (selesai, ditunda, dibatalkan)
   - Distribusi aktivitas berdasarkan kategori
   - Tren penyelesaian aktivitas dari waktu ke waktu

### 5.3. Melihat Aktivitas Berdasarkan Filter
1. User memilih filter (kategori, status, rentang tanggal)
2. Sistem menampilkan aktivitas yang sesuai dengan filter

## 6. Pengaturan dan Preferensi

### 6.1. Mengatur Preferensi Tampilan
1. User mengakses halaman pengaturan
2. User dapat mengubah tampilan default (kalender/daftar)
3. User dapat mengatur filter favorit

### 6.2. Mengatur Notifikasi
1. User mengakses pengaturan notifikasi
2. User dapat mengaktifkan/menonaktifkan notifikasi
3. User dapat mengatur waktu pengingat sebelum aktivitas

## 7. Sinkronisasi Mode Offline

### 7.1. Bekerja dalam Mode Offline
1. Saat tidak ada koneksi internet, aplikasi tetap berfungsi
2. User dapat melihat dan memperbarui aktivitas
3. Perubahan disimpan secara lokal

### 7.2. Sinkronisasi saat Online
1. Saat koneksi internet tersedia kembali
2. Sistem secara otomatis mensinkronisasi perubahan lokal ke server
3. Sistem mengunduh pembaruan dari server