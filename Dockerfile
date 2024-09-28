# Build stage
FROM node:20.16.0-alpine3.20 AS build

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

# RUN npx drizzle-kit generate
RUN npm run build
RUN npm install --production


# Final stage
FROM node:20.16.0-alpine3.20

# Instalar PM2 globalmente
RUN npm install -g pm2


WORKDIR /usr/src/app

# Install pnpm in the final stage
COPY --from=build /usr/src/app/package.json ./package.json
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/.env ./.env
COPY --from=build /usr/src/app/ecosystem.config.js ./ecosystem.config.js

EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]