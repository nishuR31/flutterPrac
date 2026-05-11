import { google } from "googleapis";
import {
  DRIVE_CREDENTIALS_FILE,
  DRIVE_FOLDER_NAME,
  DRIVE_PARENT_FOLDER_ID,
} from "../config/envConfig";

const auth = new google.auth.GoogleAuth({
  keyFile: DRIVE_CREDENTIALS_FILE,
  scopes: ["https://www.googleapis.com/auth/drive"],
});

export const drive = google.drive({ version: "v3", auth });

const folderCache = new Map<string, string>();

const escapeDriveQueryValue = (value: string) => value.replace(/'/g, "\\'");

export async function getOrCreateDriveFolder(
  folderName: string = DRIVE_FOLDER_NAME,
  parentFolderId: string = DRIVE_PARENT_FOLDER_ID,
) {
  const cacheKey = `${parentFolderId || "root"}:${folderName}`;
  const cachedFolderId = folderCache.get(cacheKey);
  if (cachedFolderId) {
    return cachedFolderId;
  }

  const parentClause = parentFolderId
    ? `'${parentFolderId}' in parents`
    : "'root' in parents";
  const query = [
    "mimeType = 'application/vnd.google-apps.folder'",
    `name = '${escapeDriveQueryValue(folderName)}'`,
    "trashed = false",
    parentClause,
  ].join(" and ");

  const found = await drive.files.list({
    q: query,
    fields: "files(id, name)",
    pageSize: 10,
    supportsAllDrives: true,
    includeItemsFromAllDrives: true,
  });

  const existingFolderId = found.data.files?.[0]?.id;
  if (existingFolderId) {
    folderCache.set(cacheKey, existingFolderId);
    return existingFolderId;
  }

  const created = await drive.files.create({
    requestBody: {
      name: folderName,
      mimeType: "application/vnd.google-apps.folder",
      ...(parentFolderId ? { parents: [parentFolderId] } : {}),
    },
    fields: "id",
    supportsAllDrives: true,
  });

  const folderId = created.data.id;
  if (!folderId) {
    throw new Error("Unable to create or resolve Google Drive folder");
  }

  folderCache.set(cacheKey, folderId);
  return folderId;
}

// helper
export const getPublicUrl = (fileId: string) =>
  `https://drive.google.com/uc?export=view&id=${fileId}`;
