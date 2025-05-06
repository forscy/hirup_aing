# API Dokumentasi: Statistik Aktivitas

Base URL: `https://api.hirup-aing.com/v1` (contoh)

## Mendapatkan Statistik Harian

Mendapatkan statistik aktivitas untuk hari tertentu.

**URL**: `/statistics/daily`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| date      | string | Ya    | Tanggal dalam format YYYY-MM-DD                 |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "date": "2025-05-06",
    "summary": {
      "total": 4,
      "completed": 1,
      "pending": 1,
      "postponed": 1,
      "cancelled": 1
    },
    "byCategory": [
      {
        "category": {
          "id": "cat-001",
          "name": "Ibadah"
        },
        "count": 1,
        "completedCount": 1
      },
      {
        "category": {
          "id": "cat-002",
          "name": "Kewajiban"
        },
        "count": 1,
        "completedCount": 1
      },
      {
        "category": {
          "id": "cat-003",
          "name": "Kesehatan"
        },
        "count": 2,
        "completedCount": 0
      }
    ]
  }
}
```

## Mendapatkan Statistik Bulanan

Mendapatkan statistik aktivitas untuk bulan tertentu.

**URL**: `/statistics/monthly`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| year      | number | Ya    | Tahun (YYYY)                                    |
| month     | number | Ya    | Bulan (1-12)                                    |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "year": 2025,
    "month": 5,
    "summary": {
      "total": 52,
      "completed": 30,
      "pending": 10,
      "postponed": 8,
      "cancelled": 4
    },
    "byCategory": [
      {
        "category": {
          "id": "cat-001",
          "name": "Ibadah"
        },
        "count": 31,
        "completedCount": 25
      },
      {
        "category": {
          "id": "cat-002",
          "name": "Kewajiban"
        },
        "count": 31,
        "completedCount": 25
      },
      {
        "category": {
          "id": "cat-003",
          "name": "Kesehatan"
        },
        "count": 15,
        "completedCount": 5
      }
    ],
    "byDate": [
      {
        "date": "2025-05-01",
        "total": 2,
        "completed": 1,
        "pending": 0,
        "postponed": 1,
        "cancelled": 0
      },
      {
        "date": "2025-05-02",
        "total": 2,
        "completed": 2,
        "pending": 0,
        "postponed": 0,
        "cancelled": 0
      },
      {
        "date": "2025-05-03",
        "total": 0,
        "completed": 0,
        "pending": 0,
        "postponed": 0,
        "cancelled": 0
      }
      // ... data untuk tanggal lain dalam bulan tersebut
    ]
  }
}
```

## Mendapatkan Statistik Kategori

Mendapatkan statistik berdasarkan kategori untuk rentang waktu tertentu.

**URL**: `/statistics/categories`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| startDate | string | Ya    | Tanggal awal dalam format YYYY-MM-DD            |
| endDate   | string | Ya    | Tanggal akhir dalam format YYYY-MM-DD           |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "startDate": "2025-05-01",
    "endDate": "2025-05-31",
    "categories": [
      {
        "category": {
          "id": "cat-001",
          "name": "Ibadah"
        },
        "total": 31,
        "completed": 25,
        "pending": 2,
        "postponed": 3,
        "cancelled": 1
      },
      {
        "category": {
          "id": "cat-002",
          "name": "Kewajiban"
        },
        "total": 31,
        "completed": 25,
        "pending": 2,
        "postponed": 3,
        "cancelled": 1
      },
      {
        "category": {
          "id": "cat-003",
          "name": "Kesehatan"
        },
        "total": 15,
        "completed": 5,
        "pending": 4,
        "postponed": 4,
        "cancelled": 2
      }
    ]
  }
}
```

## Mendapatkan Ringkasan dan Tren

Mendapatkan ringkasan statistik dan tren aktivitas dari waktu ke waktu.

**URL**: `/statistics/trends`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| period    | string | Ya    | Periode: 'week', 'month', 'year'                |
| limit     | number | Tidak | Jumlah periode yang akan ditampilkan (default: 12 untuk month, 52 untuk week, 5 untuk year) |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "period": "month",
    "trends": [
      {
        "period": "2024-12",
        "total": 120,
        "completed": 95,
        "completionRate": 79.17
      },
      {
        "period": "2025-01",
        "total": 124,
        "completed": 100,
        "completionRate": 80.65
      },
      {
        "period": "2025-02",
        "total": 112,
        "completed": 95,
        "completionRate": 84.82
      },
      {
        "period": "2025-03",
        "total": 130,
        "completed": 110,
        "completionRate": 84.62
      },
      {
        "period": "2025-04",
        "total": 125,
        "completed": 108,
        "completionRate": 86.4
      },
      {
        "period": "2025-05",
        "total": 52,
        "completed": 30,
        "completionRate": 57.69
      }
    ]
  }
}
```