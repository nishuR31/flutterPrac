import BoardRepository from "../repositories/boardRepository";
import { CreateBody, UpdateBody } from "../types";
import { NotFoundError } from "../utils/errors/error";
import { getOrSet, del, set } from "../utils/cache/cache";
import { uploadFile } from "../controllers/controller";

const boardRepo = new BoardRepository();

const ALL_BOARDS_KEY = "boards:all";
const BOARD_BY_NAME = (name: string) => `board:name:${name}`;
const BOARD_BY_ID = (id: string) => `board:id:${id}`;

export default class Service {
  async create(data: CreateBody, files?: Record<string, any>, folderId?: string) {
    const { password, ...payload } = data;
    const payloadAny: any = payload;
    // if files provided, upload them first and attach urls to payload
    try {
      if (files && folderId) {
        const uploadKeys: Record<string, string> = {};
        for (const key of Object.keys(files)) {
          const file = files[key];
          if (!file) continue;
          const uploaded = await this.upload(
            {
              filename: file.filename,
              mimetype: file.mimetype,
              file: file.file,
            },
            folderId,
          );
          uploadKeys[key] = uploaded.url;
        }

        // map known keys to payload fields
        if (uploadKeys.photoFront) payloadAny.photoFront = uploadKeys.photoFront;
        if (uploadKeys.pinDiagram) payloadAny.pinDiagram = uploadKeys.pinDiagram;
      }
    } catch (e) {
      // don't fail cache logic; propagate after trying to create record
    }
    // invalidate list cache, set individual cache
    const created = await boardRepo.create(payloadAny);
    try {
      await Promise.all([
        del(ALL_BOARDS_KEY),
        set(BOARD_BY_ID(created.id), created, 60 * 5),
        set(BOARD_BY_NAME(created.name), created, 60 * 5),
      ]);
    } catch (e) {
      // ignore cache errors
    }
    return created;
  }

  async findMany() {
    return getOrSet(ALL_BOARDS_KEY, 60, async () => {
      return boardRepo.findAll({ orderBy: { createdAt: "desc" } });
    });
  }

  async findOne(name: string) {
    const board = await getOrSet(BOARD_BY_NAME(name), 60, async () => {
      const b = await boardRepo.findOne({ name });
      if (!b) throw new NotFoundError(`Board with name ${name} not found`);
      return b;
    });

    if (!board) {
      throw new NotFoundError(`Board with name ${name} not found`);
    }

    return board;
  }

  async update(id: string, data: UpdateBody) {
    const { password: _password, ...payload } = data;
    const board = await boardRepo.findById(id);
    const updated = await boardRepo.update(board.id, payload);

    try {
      await Promise.all([
        del([ALL_BOARDS_KEY, BOARD_BY_ID(id), BOARD_BY_NAME(board.name)]),
        set(BOARD_BY_ID(updated.id), updated, 60 * 5),
        set(BOARD_BY_NAME(updated.name), updated, 60 * 5),
      ]);
    } catch (e) {
      // ignore cache errors
    }

    return updated;
  }

  async deleteOne(id: string) {
    const board = await boardRepo.findById(id);
    const deleted = await boardRepo.deleteOne(board.id);
    try {
      await del([ALL_BOARDS_KEY, BOARD_BY_ID(id), BOARD_BY_NAME(board.name)]);
    } catch (e) {
      // ignore cache errors
    }
    return deleted;
  }

  async upload(data: any, folderId: any) {
    const createdFile = await boardRepo.createFile(data, folderId);
    const fileId = createdFile.data.id;
    await boardRepo.createPermission(fileId);
    return {
      fileId,
      url: `https://drive.google.com/uc?export=view&id=${fileId}`,
    };
  }
}
