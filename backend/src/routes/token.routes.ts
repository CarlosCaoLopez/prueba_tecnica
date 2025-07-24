import { Router } from "express";
import { getTokenBalance } from "../controllers/token.controller";

const router = Router();
router.get("/balance/:tokenAddress/:userAddress", getTokenBalance);
export default router;
