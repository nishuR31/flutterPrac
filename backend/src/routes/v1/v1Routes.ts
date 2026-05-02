import { FastifyPluginAsync } from "fastify";
import routes from "./routes";

const v1Router: FastifyPluginAsync = async (app) => {
  app.register(routes, { prefix: "/v1" });
};

export default v1Router;
