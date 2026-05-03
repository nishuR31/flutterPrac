import { FastifyPluginAsync, FastifyReply, FastifyRequest } from "fastify";
import {
  deleteOne,
  create,
  findMany,
  findOne,
  update,
  uploadFile,
} from "../../controllers/controller";
import requireCrudPassword from "../../middlewares/auth";

const routes: FastifyPluginAsync = async (app) => {
  app.post("/create", { preHandler: requireCrudPassword }, create);
  app.get("/findOne", findMany);
  app.get("/ping", (req: FastifyRequest, res: FastifyReply) => {
    res.code(200).send({ message: "pong", route: req.originalUrl });
  });
  app.get("/find/:name", findOne);
  app.post("/upload", uploadFile);
  app.delete("/delete/:id", { preHandler: requireCrudPassword }, deleteOne);
  app.put("/update/:id", { preHandler: requireCrudPassword }, update);
};

export default routes;
