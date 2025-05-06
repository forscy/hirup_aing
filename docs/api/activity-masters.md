# API Dokumentasi: Aktivitas Master

Base URL: `https://api.hirup-aing.com/v1` (contoh)

## Mendapatkan Semua Aktivitas Master

Mendapatkan daftar aktivitas master milik pengguna yang sedang login.

**URL**: `/activities`

**Metode**: `GET`

**Auth**: Bearer Token

**Params**:

| Nama      | Tipe   | Wajib | Deskripsi                                       |
|-----------|--------|-------|------------------------------------------------|
| search    | string | Tidak | Mencari aktivitas berdasarkan nama              |
| category  | string | Tidak | Filter berdasarkan ID kategori                  |
| frequency | string | Tidak | Filter berdasarkan frekuensi (DAILY, WEEKLY, MONTHLY) |
| limit     | number | Tidak | Batas jumlah data yang dikembalikan (default: 20) |
| offset    | number | Tidak | Offset untuk paginasi data (default: 0)         |

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "activities": [
      {
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
        ],
        "createdAt": "2025-05-01T00:00:00Z",
        "updatedAt": "2025-05-01T00:00:00Z"
      },
      {
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
        ],
        "createdAt": "2025-05-01T00:00:00Z",
        "updatedAt": "2025-05-01T00:00:00Z"
      }
    ],
    "total": 2,
    "limit": 20,
    "offset": 0
  }
}
```

## Mendapatkan Detail Aktivitas Master

Mendapatkan detail aktivitas master berdasarkan ID.

**URL**: `/activities/:id`

**Metode**: `GET`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "data": {
    "id": "act-001",
    "name": "Solat Subuh",
    "description": null,
    "startTime": "05:00:00",
    "endTime": "05:10:00",
    "isRecurring": true,
    "frequency": "DAILY",
    "daysOfWeek": null,
    "datesOfMonth": null,
    "daysOfMonth": null,
    "categories": [
      {
        "id": "cat-001",
        "name": "Ibadah"
      },
      {
        "id": "cat-002",
        "name": "Kewajiban"
      }
    ],
    "userId": "user-uuid",
    "createdAt": "2025-05-01T00:00:00Z",
    "updatedAt": "2025-05-01T00:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Aktivitas tidak ditemukan"
}
```

## Membuat Aktivitas Master Baru

Membuat aktivitas master baru untuk pengguna yang sedang login.

**URL**: `/activities`

**Metode**: `POST`

**Auth**: Bearer Token

**Body**:

```json
{
  "name": "Renang",
  "description": "Olahraga renang bulanan",
  "startTime": "06:00:00",
  "endTime": "07:00:00",
  "isRecurring": true,
  "frequency": "MONTHLY",
  "datesOfMonth": [6],
  "categories": ["cat-003"]
}
```

Contoh body untuk aktivitas mingguan:

```json
{
  "name": "Kuliah PPL Teori",
  "description": "Mata kuliah PPL teori",
  "startTime": "07:50:00",
  "endTime": "09:20:00",
  "isRecurring": true,
  "frequency": "WEEKLY",
  "daysOfWeek": ["MONDAY"],
  "categories": ["cat-004", "cat-005"]
}
```

**Response Sukses**:

- **Kode**: `201 Created`
- **Content**:

```json
{
  "success": true,
  "message": "Aktivitas berhasil dibuat",
  "data": {
    "id": "act-003",
    "name": "Renang",
    "description": "Olahraga renang bulanan",
    "startTime": "06:00:00",
    "endTime": "07:00:00",
    "isRecurring": true,
    "frequency": "MONTHLY",
    "datesOfMonth": [6],
    "categories": [
      {
        "id": "cat-003",
        "name": "Kesehatan"
      }
    ],
    "userId": "user-uuid",
    "createdAt": "2025-05-06T08:00:00Z",
    "updatedAt": "2025-05-06T08:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `400 Bad Request`
- **Content**:

```json
{
  "success": false,
  "message": "Validasi gagal",
  "errors": [
    {
      "field": "daysOfWeek",
      "message": "Harus diisi untuk aktivitas mingguan"
    }
  ]
}
```

## Memperbarui Aktivitas Master

Memperbarui aktivitas master berdasarkan ID.

**URL**: `/activities/:id`

**Metode**: `PUT`

**Auth**: Bearer Token

**Body**:

```json
{
  "name": "Renang Pagi",
  "description": "Olahraga renang bulanan di pagi hari",
  "startTime": "06:30:00",
  "endTime": "07:30:00",
  "isRecurring": true,
  "frequency": "MONTHLY",
  "datesOfMonth": [6, 20],
  "categories": ["cat-003"]
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Aktivitas berhasil diperbarui",
  "data": {
    "id": "act-003",
    "name": "Renang Pagi",
    "description": "Olahraga renang bulanan di pagi hari",
    "startTime": "06:30:00",
    "endTime": "07:30:00",
    "isRecurring": true,
    "frequency": "MONTHLY",
    "datesOfMonth": [6, 20],
    "categories": [
      {
        "id": "cat-003",
        "name": "Kesehatan"
      }
    ],
    "userId": "user-uuid",
    "updatedAt": "2025-05-06T09:00:00Z"
  }
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Aktivitas tidak ditemukan"
}
```

## Menghapus Aktivitas Master

Menghapus aktivitas master berdasarkan ID.

**URL**: `/activities/:id`

**Metode**: `DELETE`

**Auth**: Bearer Token

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Aktivitas berhasil dihapus"
}
```

**Response Error**:

- **Kode**: `404 Not Found`
- **Content**:

```json
{
  "success": false,
  "message": "Aktivitas tidak ditemukan"
}
```

## Generate Instance Aktivitas

Membuat instance aktivitas untuk aktivitas master dalam rentang tanggal tertentu.

**URL**: `/activities/:id/generate`

**Metode**: `POST`

**Auth**: Bearer Token

**Body**:

```json
{
  "startDate": "2025-05-01",
  "endDate": "2025-05-31"
}
```

**Response Sukses**:

- **Kode**: `200 OK`
- **Content**:

```json
{
  "success": true,
  "message": "Instance aktivitas berhasil dibuat",
  "data": {
    "totalGenerated": 5,
    "instances": [
      {
        "id": "ins-001",
        "activityDate": "2025-05-01",
        "status": "PENDING",
        "activityMasterId": "act-001"
      },
      {
        "id": "ins-002",
        "activityDate": "2025-05-02",
        "status": "PENDING",
        "activityMasterId": "act-001"
      }
    ]
  }
}
```