import Redis from "ioredis";
import { REDIS_URL } from "../../config/envConfig";

const redis = new Redis(REDIS_URL);

async function getRaw(key: string) {
  const val = await redis.get(key);
  return val;
}

async function get<T = any>(key: string): Promise<T | null> {
  const raw = await getRaw(key);
  if (!raw) return null;
  try {
    return JSON.parse(raw) as T;
  } catch (e) {
    return null;
  }
}

async function set(key: string, value: any, ttlSeconds?: number) {
  const raw = JSON.stringify(value);
  if (ttlSeconds && ttlSeconds > 0) {
    await redis.set(key, raw, "EX", ttlSeconds);
    return;
  }
  await redis.set(key, raw);
}

async function del(key: string | string[]) {
  if (Array.isArray(key)) {
    if (key.length === 0) return;
    await redis.del(...key);
    return;
  }
  await redis.del(key);
}

async function getOrSet<T>(
  key: string,
  ttlSeconds: number,
  fetcher: () => Promise<T>,
): Promise<T> {
  const cached = await get<T>(key);
  if (cached !== null) return cached;

  const fresh = await fetcher();
  try {
    await set(key, fresh, ttlSeconds);
  } catch (e) {
    // ignore cache set failures
  }
  return fresh;
}

export { redis, get, getOrSet, set, del };
