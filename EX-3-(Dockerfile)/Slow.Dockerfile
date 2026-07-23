FROM node:18
WORKDIR /app

COPY . .
RUN npm install
RUN npm run build


#After
FROM node:18-alpine
WORKDIR /app

COPY package*.json .
RUN npm install
COPY . .

RUN npm run build