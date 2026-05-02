import { FastifyPluginAsync } from "fastify";
import v1Router from "./v1/v1Routes";

const apiRouter: FastifyPluginAsync = async (app) => {
  app.register(v1Router, { prefix: "/api" });
};

export default apiRouter;
