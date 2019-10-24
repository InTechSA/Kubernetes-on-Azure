FROM node:lts-slim

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install --production

COPY . .
ENTRYPOINT ["npm"]
CMD ["start"]