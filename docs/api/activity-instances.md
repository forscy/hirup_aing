# API Dokumentasi: Instance Aktivitas

Base URL: `https://api.hirup-aing.com/v1` (contoh)

## Mendapatkan Instance Aktivitas untuk Tanggal

Mendapatkan daftar instance aktivitas milik pengguna untuk tanggal tertentu.

**URL**: `/instances`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| date      | string | Ya    | Tanggal dalam format YYYY-MM-DD                 |
| status    | string | Tidak | Filter berdasarkan status (PENDING, COMPLETED, POSTPONED, CANCELLED) |
| category  | string | Tidak | Filter berdasarkan ID kategori                  |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "date": "2025-05-06",
    "instances": [
      {
        "id": "ins-002",
        "activityDate": "2025-05-06",
        "status": "COMPLETED",
        "notes": null,
        "activityMasterId": "act-001",
        "activityMaster": {
          "id": "act-001",
          "name": "Solat Subuh",
          "description": null,
          "startTime": "05:00:00",
          "endTime": "05:10:00",
          "isRecurring": true,
          "frequency": "DAILY",
          "categories": [
            {
              "id": "cat-001",
              "name": "Ibadah"
            },
            {
              "id": "cat-002",
              "name": "Kewajiban"
            }
          ]
        },
        "createdAt": "2025-05-06T00:00:00Z",
        "updatedAt": "2025-05-06T05:10:00Z"
      },
      {
        "id": "ins-003",
        "activityDate": "2025-05-06",
        "status": "POSTPONED",
        "notes": "Saya bangun kesiangan",
        "activityMasterId": "act-002",
        "activityMaster": {
          "id": "act-002",
          "name": "Push Up Pagi",
          "description": null,
          "startTime": "05:11:00",
          "endTime": "05:15:00",
          "isRecurring": true,
          "frequency": "DAILY",
          "categories": [
            {
              "id": "cat-003",
              "name": "Kesehatan"
            }
          ]
        },
        "createdAt": "2025-05-06T00:00:00Z",
        "updatedAt": "2025-05-06T08:30:00Z"
      }
    ],
    "total": 2
  }
}
```

## Mendapatkan Instance Aktivitas berdasarkan Rentang Tanggal

Mendapatkan daftar instance aktivitas milik pengguna untuk rentang tanggal tertentu.

**URL**: `/instances/range`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| startDate | string | Ya    | Tanggal awal dalam format YYYY-MM-DD            |
| endDate   | string | Ya    | Tanggal akhir dalam format YYYY-MM-DD           |
| status    | string | Tidak | Filter berdasarkan status                       |
| category  | string | Tidak | Filter berdasarkan ID kategori                  |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "startDate": "2025-05-05",
    "endDate": "2025-05-06",
    "instances": [
      {
        "date": "2025-05-05",
        "activities": [
          {
            "id": "ins-001",
            "activityDate": "2025-05-05",
            "status": "POSTPONED",
            "notes": null,
            "activityMasterId": "act-001",
            "activityMaster": {
              "id": "act-001",
              "name": "Solat Subuh",
              "startTime": "05:00:00",
              "endTime": "05:10:00",
              "categories": [
                {
                  "id": "cat-001",
                  "name": "Ibadah"
                },
                {
                  "id": "cat-002",
                  "name": "Kewajiban"
                }
              ]
            }
          }
        ]
      },
      {
        "date": "2025-05-06",
        "activities": [
          {
            "id": "ins-002",
            "activityDate": "2025-05-06",
            "status": "COMPLETED",
            "notes": null,
            "activityMasterId": "act-001",
            "activityMaster": {
              "id": "act-001",
              "name": "Solat Subuh",
              "startTime": "05:00:00",
              "endTime": "05:10:00",
              "categories": [
                {
                  "id": "cat-001",
                  "name": "Ibadah"
                },
                {
                  "id": "cat-002",
                  "name": "Kewajiban"
                }
              ]
            }
          },
          {
            "id": "ins-003",
            "activityDate": "2025-05-06",
            "status": "POSTPONED",
            "notes": "Saya bangun kesiangan",
            "activityMasterId": "act-002",
            "activityMaster": {
              "id": "act-002",
              "name": "Push Up Pagi",
              "startTime": "05:11:00",
              "endTime": "05:15:00",
              "categories": [
                {
                  "id": "cat-003",
                  "name": "Kesehatan"
                }
              ]
            }
          }
        ]
      }
    ],
    "total": 3
  }
}
```

## Mendapatkan Detail Instance Aktivitas

Mendapatkan detail instance aktivitas berdasarkan ID.

**URL**: `/instances/:id`

**Metode**: `GET`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "id": "ins-002",
    "activityDate": "2025-05-06",
    "status": "COMPLETED",
    "notes": null,
    "activityMasterId": "act-001",
    "activityMaster": {
      "id": "act-001",
      "name": "Solat Subuh",
      "description": null,
      "startTime": "05:00:00",
      "endTime": "05:10:00",
      "isRecurring": true,
      "frequency": "DAILY",
      "categories": [
        {
          "id": "cat-001",
          "name": "Ibadah"
        },
        {
          "id": "cat-002",
          "name": "Kewajiban"
        }
      ]
    },
    "createdAt": "2025-05-06T00:00:00Z",
    "updatedAt": "2025-05-06T05:10:00Z"
  }
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Instance aktivitas tidak ditemukan"
}
```

## Memperbarui Status Instance Aktivitas

Memperbarui status instance aktivitas berdasarkan ID.

**URL**: `/instances/:id/status`

**Metode**: `PUT`

**Auth**: Bearer Token

**Body**:

```json
{
  "status": "COMPLETED",
  "notes": "Berhasil selesai tepat waktu"
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Status aktivitas berhasil diperbarui",
  "data": {
    "id": "ins-003",
    "activityDate": "2025-05-06",
    "status": "COMPLETED",
    "notes": "Berhasil selesai tepat waktu",
    "updatedAt": "2025-05-06T10:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Instance aktivitas tidak ditemukan"
}
```

- **Kode**: `400 Bad Request`
- **Content**:

```json
{
  "success": false,
  "message": "Status tidak valid",
  "errors": [
    {
      "field": "status",
      "message": "Status harus salah satu dari: PENDING, COMPLETED, POSTPONED, CANCELLED"
    }
  ]
}
```

## Memperbarui Catatan Instance Aktivitas

Memperbarui catatan instance aktivitas berdasarkan ID.

**URL**: `/instances/:id/notes`

**Metode**: `PUT`

**Auth**: Bearer Token

**Body**:

```json
{
  "notes": "Saya hanya sempat melakukan 10 push up dari target 20"
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Catatan aktivitas berhasil diperbarui",
  "data": {
    "id": "ins-003",
    "notes": "Saya hanya sempat melakukan 10 push up dari target 20",
    "updatedAt": "2025-05-06T10:30:00Z"
  }
}
```

## Menghapus Instance Aktivitas

Menghapus instance aktivitas berdasarkan ID.

**URL**: `/instances/:id`

**Metode**: `DELETE`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Instance aktivitas berhasil dihapus"
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Instance aktivitas tidak ditemukan"
}
```