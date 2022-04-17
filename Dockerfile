FROM node:alpine as builder
WORKDIR /usr/src/app
COPY package.json ./
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html