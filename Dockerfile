FROM node:latest as build-stage
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . .
RUN npm run build
EXPOSE 80
CMD ["npm","start"]
