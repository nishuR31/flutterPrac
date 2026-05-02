import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "../generated/prisma/client";
import { DATABASE_URL, NODE_ENV } from "./envConfig";

const adapter = new PrismaPg({ connectionString: DATABASE_URL });
const basePrisma = new PrismaClient({
  adapter,
  log: NODE_ENV === "development" ? ["error", "query", "warn"] : ["info"],
});

function shutDownHandler(signal: string) {
  return async () => {
    await basePrisma.$disconnect();
    process.exit(0);
  };
}

process.on("SIGINT", shutDownHandler("SIGINT"));
process.on("SIGTERM", shutDownHandler("SIGTERM"));

export default basePrisma;
