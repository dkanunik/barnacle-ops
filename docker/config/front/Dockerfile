FROM node:8
WORKDIR /barnacle
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 4201
CMD [ "npm", "run", "front:start" ]
