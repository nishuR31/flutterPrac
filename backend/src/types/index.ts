export type BoardType = "SBC" | "MC";

export type BoardBody = {
  name: string;
  type: BoardType;
  photo?: string;
  description?: string;
  pinDiagram?: string;
};

export type CreateBody = BoardBody & {
  password: string;
};

export type UpdateBody = Partial<BoardBody> & {
  password: string;
  id: string;
};

export type DeleteBody = {
  id: string;
  password: string;
};

export type FindOneBody = {
  name: string;
};

export type { TestUser } from "./testUser";
export { testUser } from "./testUser";
