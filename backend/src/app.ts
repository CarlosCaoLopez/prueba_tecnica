import express from "express";
import factoryRoutes from "./routes/factory.routes";
import tokenRoutes from "./routes/token.routes";

const app = express();

// Routes
app.use("/api/factory", factoryRoutes);
app.use("/api/token", tokenRoutes);

export default app;
