import { FastifyPluginAsync } from "fastify";
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
  app.get("/find/:name", findOne);
  app.post("/upload", uploadFile);
  app.delete("/delete/:id", { preHandler: requireCrudPassword }, deleteOne);
  app.put("/update/:id", { preHandler: requireCrudPassword }, update);
};

export default routes;
