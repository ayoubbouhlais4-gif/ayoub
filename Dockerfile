FROM node:alpine
WORKDIR /ayoub
COPY package*.json ./
RUN npm install
COPY . .
CMD  ["node","server.js"]