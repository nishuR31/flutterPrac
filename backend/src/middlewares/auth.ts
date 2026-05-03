import { FastifyReply, FastifyRequest } from "fastify";

import { CRUD_PASSWORD } from "../config/envConfig";
import { UnauthorizedError } from "../utils/errors/error";

type PasswordBody = {
  password: string;
};

export default function requireCrudPassword(
  req: FastifyRequest<{ Body: PasswordBody }>,
  reply: FastifyReply,
) {
  const password = req.body?.password;

  if (password !== CRUD_PASSWORD) {
    throw new UnauthorizedError("Invalid password");
  }
}
