import { FastifyReply, FastifyRequest } from "fastify";

import Service from "../services/service";
import asyncHandler from "../utils/common/asyncHandler";
import { sendSuccess } from "../utils/common/response";
import { STATUS_CODES } from "../utils/common/constants";
import { CreateBody, DeleteBody, FindOneBody, UpdateBody } from "../types";

const service = new Service();

type CreateRequest = FastifyRequest<{
  Body: CreateBody;
}>;
type DeleteRequest = FastifyRequest<{
  Params: { id: string };
  Body: DeleteBody;
}>;
type FindOneRequest = FastifyRequest<{
  Params: FindOneBody;
}>;
type UpdateRequest = FastifyRequest<{
  Params: { id: string };
  Body: UpdateBody;
}>;

export const create = asyncHandler(
  async (req: CreateRequest, res: FastifyReply): Promise<any> => {
    const result = await service.create(req.body);
    sendSuccess(res, result, "Data successfully added", STATUS_CODES.CREATED);
  },
);

export const deleteOne = asyncHandler(async (req: DeleteRequest, res: FastifyReply) => {
  const { id } = req.params;
  const result = await service.deleteOne(id);

  sendSuccess(res, result, "Deletion successful", STATUS_CODES.OK);
});

export const findOne = asyncHandler(async (req: FindOneRequest, res: FastifyReply) => {
  const { name } = req.params;
  const result = await service.findOne(name);
  sendSuccess(res, result, "Data found successful", STATUS_CODES.OK);
});
export const findMany = asyncHandler(async (req: FastifyRequest, res: FastifyReply) => {
  const result = await service.findMany();
  sendSuccess(res, result, "Data found successful", STATUS_CODES.OK);
});

export const update = asyncHandler(async (req: UpdateRequest, res: FastifyReply) => {
  const { id } = req.params;
  const result = await service.update(id, req.body);
  sendSuccess(res, result, "Data updated successfully", STATUS_CODES.OK);
});

export const uploadFile = asyncHandler(
  async (
    req: FastifyRequest<{
      Body: {
        file: { type: any; required: true };
        folderId: { type: any; required: true };
      };
    }>,
    res: FastifyReply,
  ) => {
    const folderId = req.body.folderId;
    const file = await req.file();
    const response = await service.upload(file, folderId);
    sendSuccess(res, response, "File uploaded successfully", STATUS_CODES.OK);
  },
);
