# BoardVault Backend API (v1)

Base path: `/api/v1`

Endpoints

- `POST /api/v1/create` (protected)
  - Description: Create a board entry. Accepts multipart form-data for files.
  - Required body fields (JSON or form fields):
    - `name` (string)
    - `description` (string)
    - `manufacturer` (string) optional
    - `tags` (string[]) optional (send as repeated `tags` fields or JSON string)
    - `password` (string) — required for authorization (compare with `.env` CRUD_PASSWORD)
    - `folderId` (string) optional — Google Drive folder id where images will be stored. If omitted, the backend looks for or creates a default folder using `DRIVE_FOLDER_NAME`.
  - Files (multipart): `photoFront`, `pinDiagram` (each optional)
  - Response: created board object (JSON)

- `GET /api/v1/findOne`
  - Description: Returns list of boards (this route maps to the "find many" operation).
  - Params: none
  - Response: array of board objects

- `GET /api/v1/find/:name`
  - Description: Find a single board by `name` (path param)
  - Params:
    - `name` (string) — board name
  - Response: single board object

- `POST /api/v1/upload`
  - Description: Upload a single file to Google Drive and return a public URL.
  - Body: multipart form with `file` and optional `folderId` field (use `file` as file field)
  - If `folderId` is not provided, the backend uses or creates the default folder from `DRIVE_FOLDER_NAME`.
  - Response: `{ fileId, url }`

- `PUT /api/v1/update/:id` (protected)
  - Description: Update board metadata (no file upload here).
  - Params:
    - `id` (path) — board id
  - Body (JSON): fields to update plus `password` field for authorization
  - Response: updated board object

- `DELETE /api/v1/delete/:id` (protected)
  - Description: Delete a board by id
  - Params: `id` (path)
  - Body: `{ password: "..." }` required
  - Response: deleted record info

Auth/Password

- The simple protection used by this project expects `password` in the JSON body for protected endpoints. The middleware compares this value to `CRUD_PASSWORD` in the backend `.env`.

Drive connection

- The backend connects to Google Drive with a service account key file loaded from `DRIVE_CREDENTIALS_FILE` in `.env`.
- The Drive API must be enabled in the Google Cloud project that issued the service account.
- If you want uploads to land in an existing shared folder, set `DRIVE_PARENT_FOLDER_ID` to that folder id and make sure the folder is shared with the service account email.
- If you do not provide a folder id in the request, the backend uses `DRIVE_FOLDER_NAME` as the default folder name and creates or reuses that folder automatically.

Compression

- Image files uploaded via `POST /api/v1/create` or `POST /api/v1/upload` are compressed server-side before being sent to Google Drive. The server uses `sharp` to optimize images.

Testing examples (curl)

Create (multipart with files):

```
curl -X POST http://localhost:3001/api/v1/create \
  -F "name=My Board" \
  -F "description=Detailed board description" \
  -F "password=YOUR_PASSWORD" \
  -F "folderId=GOOGLE_DRIVE_FOLDER_ID" \
  -F "photoFront=@./board.jpg" \
  -F "pinDiagram=@./diagram.png"
```

Upload single file:

```
curl -X POST http://localhost:3001/api/v1/upload \
  -F "folderId=GOOGLE_DRIVE_FOLDER_ID" \
  -F "file=@./board.jpg"
```

Get all boards:

```
curl http://localhost:3001/api/v1/findOne
```

Find by name:

```
curl http://localhost:3001/api/v1/find/"My%20Board"
```
