FROM node:alpine as builder
RUN rm -rf dist
ADD . /app/cart-api
COPY . /app/cart-api
WORKDIR /app/cart-api
ENV GENERATE_SOURCEMAP=false
RUN export NODE_OPTIONS=--max_old_space_size=8192
RUN npm install
RUN npm run build && npm cache clean --force

FROM node:alpine as runner
COPY --from=builder /app/cart-api/dist /app/cart-api

WORKDIR /app/cart-api
USER node

ENV PORT 4000
EXPOSE 4000
ENTRYPOINT ["node", "lambda.js"]
