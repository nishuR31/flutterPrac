import { Readable } from "stream";

async function streamToBuffer(stream: NodeJS.ReadableStream | any): Promise<Buffer> {
  return new Promise<Buffer>((resolve, reject) => {
    const chunks: Buffer[] = [];
    stream.on("data", (chunk: Buffer) => chunks.push(Buffer.from(chunk)));
    stream.on("end", () => resolve(Buffer.concat(chunks)));
    stream.on("error", (err: any) => reject(err));
  });
}

export async function compressImage(
  input: Buffer | NodeJS.ReadableStream | any,
  mimeType: string,
): Promise<Buffer> {
  const inputBuffer: Buffer = Buffer.isBuffer(input)
    ? input
    : await streamToBuffer(input);

  try {
    // dynamically require sharp to allow environments without it
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    const sharp = require("sharp");
    const pipeline = sharp(inputBuffer).rotate();
    if (mimeType && mimeType.includes("png")) {
      return pipeline.png({ quality: 80, compressionLevel: 8 }).toBuffer();
    }
    return pipeline.jpeg({ quality: 75, mozjpeg: true }).toBuffer();
  } catch (e) {
    // sharp not available — return original buffer
    return inputBuffer;
  }
}

export function bufferToStream(buffer: Buffer): NodeJS.ReadableStream {
  return Readable.from(buffer as any);
}

export default { compressImage, bufferToStream };
