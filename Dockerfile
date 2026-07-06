# agent-chat-ui container for the agentic-search deployment.
FROM node:20-slim

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# NEXT_PUBLIC_* are inlined at build time, so they must be set before `next build`.
# NEXT_PUBLIC_API_URL must be ABSOLUTE — the SDK calls new URL() on it, which rejects a relative
# "/api". Use the public site URL + /api; Next proxies that to LANGGRAPH_API_URL server-side.
# LANGGRAPH_API_URL itself is read at runtime — set via compose.
ENV NEXT_PUBLIC_API_URL=https://agentic-search.project.hudci.org/api
ENV NEXT_PUBLIC_ASSISTANT_ID=agentic_search
RUN npm run build

EXPOSE 3000
CMD ["npm", "run", "start"]
