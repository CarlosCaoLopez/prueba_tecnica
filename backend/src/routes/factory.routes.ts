import { Router } from "express";
import {
  getCreationCounts,
  getUserCreations,
} from "../controllers/factory.controller";

const router = Router();
router.get("/counts", getCreationCounts);
router.get("/creations/:userAddress", getUserCreations);
export default router;
