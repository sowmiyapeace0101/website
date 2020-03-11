FROM node:12-alpine

RUN mkdir ~/website

WORKDIR ~/website

COPY . ~/website

EXPOSE 5000

RUN npm install
RUN npm run build
RUN npm install serve 

CMD ["./node_modules/serve/bin/serve.js", "-c", "0", "-s", "build"]
