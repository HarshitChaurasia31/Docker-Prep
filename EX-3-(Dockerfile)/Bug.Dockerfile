# Before
FROM node:18-alpine
WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000

CMD ["npm", "start"]
ENV DB_PASSWORD="admin123"
EXPOSE 3001


# After
FROM node:18-alpine
WORKDIR /app
COPY package*.json .
RUN npm install
LABEL read_only="true"

COPY . .

USER appuser
EXPOSE 3001

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

CMD ["npm", "start"]    
