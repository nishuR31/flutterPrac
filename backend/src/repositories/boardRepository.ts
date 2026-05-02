import { Board } from "../generated/prisma/client";
import BaseRepository from "./baseRepository";
import { drive } from "../utils/drive";
export default class BoardRepository extends BaseRepository<Board> {
  constructor() {
    super("board");
  }

  // your setup

  createFile = async (data: any, folderId: any) => {
    const res = await drive.files.create({
      requestBody: {
        name: data.filename,
        parents: [folderId],
      },
      media: {
        mimeType: data.mimetype,
        body: data.file, // stream directly
      },
    });

    return res;
  };

  createPermission = async (fileId: any) => {
    await drive.permissions.create({
      fileId,
      requestBody: {
        role: "reader",
        type: "anyone",
      },
    });

    return {
      fileId,
      url: `https://drive.google.com/uc?export=view&id=${fileId}`,
    };
  };
}
