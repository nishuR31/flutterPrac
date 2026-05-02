// import { NextFunction, Request, Response } from "express";

import { FastifyReply, FastifyRequest } from "fastify";

import { AppError } from "../utils/errors/error";
import { NODE_ENV } from "../config/envConfig";
import { sendError } from "../utils/common/response";

export default function errorHandler(err: any, req: FastifyRequest, res: FastifyReply) {
  if (!(err instanceof AppError)) {
    err = new AppError(err.message || "Something went wrong.", err.statusCode || 500);
  }

  const { message, statusCode, name, stack, details } = err;

  console.info(`${name || "Error"}: ${message}`, {
    details,
    statusCode,
    stack,
    url: req.originalUrl,
    method: req.method,
  });

  const errDetails =
    NODE_ENV.toLowerCase() === "development" || NODE_ENV.toLowerCase() === "dev"
      ? { name, stack, details }
      : undefined;

  sendError(res, message, statusCode, errDetails);
}
