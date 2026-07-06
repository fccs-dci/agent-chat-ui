# agent-chat-ui container for the agentic-search deployment.
FROM node:20-slim

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# NEXT_PUBLIC_* are inlined at build time, so they must be set before `next build`.
# LANGGRAPH_API_URL is read at runtime (server-side passthrough) — set via compose instead.
ENV NEXT_PUBLIC_API_URL=/api
ENV NEXT_PUBLIC_ASSISTANT_ID=agentic_search
RUN npm run build

EXPOSE 3000
CMD ["npm", "run", "start"]
