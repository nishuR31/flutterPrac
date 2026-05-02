import fastify from "fastify";
import { FastifyReply, FastifyRequest } from "fastify";
import cors from "@fastify/cors";
import cookie from "@fastify/cookie";
import multipart from "@fastify/multipart";

import auth from "../middlewares/auth";
import errorHandler from "../middlewares/errorHandlerMiddleware";
import { TooManyRequestsError } from "../utils/errors/error";
import { RATE_LIMIT_MAX_REQUESTS, RATE_LIMIT_WINDOW_SECONDS } from "./envConfig";

let fastifyApp = fastify({ logger: true, exposeHeadRoutes: true });
fastifyApp.register(cors, { origin: true });
fastifyApp.register(cookie);
fastifyApp.register(multipart);
const rateLimitWindow = RATE_LIMIT_WINDOW_SECONDS;
const rateLimitReq = RATE_LIMIT_MAX_REQUESTS;

type RateLimitEntry = {
  count: number;
  resetAt: number;
};

const rateLimitStore = new Map<string, RateLimitEntry>();

fastifyApp.addHook("onRequest", async (req: FastifyRequest, reply: FastifyReply) => {
  if (
    req.url === "/" ||
    req.url === "/ping" ||
    req.url === "/health" ||
    req.url === "/date"
  ) {
    return;
  }

  const ip = req.ip || req.headers["x-forwarded-for"] || "unknown";
  const key = `ratelimit:${ip}:${req.method}:${req.url}`;

  const now = Date.now();
  const currentEntry = rateLimitStore.get(key);

  if (!currentEntry || currentEntry.resetAt <= now) {
    rateLimitStore.set(key, {
      count: 1,
      resetAt: now + rateLimitWindow * 1000,
    });
    return;
  }

  currentEntry.count += 1;

  if (currentEntry.count > rateLimitReq) {
    const retryAfterSeconds = Math.max(1, Math.ceil((currentEntry.resetAt - now) / 1000));
    reply.header("Retry-After", String(retryAfterSeconds));
    throw new TooManyRequestsError("Too many requests. Please try again later.", {
      limit: rateLimitReq,
      windowSeconds: rateLimitWindow,
      retryAfterSeconds,
    });
  }
});

fastifyApp.get("/", (req: FastifyRequest, res: FastifyReply) => {
  res.code(200).send({ message: "Server fired up" });
});
fastifyApp.addHook("preHandler", auth);
fastifyApp.setErrorHandler(errorHandler);

export default fastifyApp;
