import express from "express";
import app from "./app";

const PORT = process.env.PORT || 3000;

// Middleware to parse JSON bodies
app.use(express.json());

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
