# 1. Use official Node.js LTS base image
FROM node:20-alpine AS builder

# 2. Set working directory
WORKDIR /app

# 3. Copy package files first (leverages Docker caching)
COPY package.json package-lock.json ./

# 4. Install dependencies (without unnecessary dev dependencies)
RUN npm install --omit=dev

# 5. Copy the rest of the project files
COPY . .

# 6. Build Next.js (creates .next directory)
RUN npm run build

# 7. Use a lightweight production runtime
FROM node:20-alpine AS runner

WORKDIR /app

# 8. Copy only necessary files from the builder stage
COPY --from=builder /app/.next .next
COPY --from=builder /app/public public
COPY --from=builder /app/package.json .
COPY --from=builder /app/node_modules node_modules

# 9. Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# 10. Expose port
EXPOSE 3000

# 11. Start Next.js app
CMD ["node_modules/.bin/next", "start"]
