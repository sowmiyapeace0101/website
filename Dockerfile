FROM node:12-alpine

RUN mkdir -p /home/node/website/node_modules && chown -R node:node /home/node/website

WORKDIR /home/node/website

# Adding this COPY instruction before running npm install or 
# copying the application code allows us to take advantage of 
# Docker’s caching mechanism. At each stage in the build, Docker 
# will check to see if it has a layer cached for that particular 
# instruction. If we change package.json, this layer will be rebuilt, 
# but if we don’t, this instruction will allow Docker to use the 
# existing image layer and skip reinstalling our node modules. 
COPY package*.json ./

USER node

RUN npm install

COPY --chown=node:node . .

RUN npm run build
RUN npm install serve 

EXPOSE 5000

CMD ["./node_modules/serve/bin/serve.js", "-c", "0", "-s", "build"]
