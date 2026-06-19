# Stage 1 - build dependencies
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY . .

# Stage 2 - lightweight runtime
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 3000

CMD ["node", "src/server.js"]
