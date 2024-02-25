################################################################################
# BUILD STAGE
################################################################################
FROM node:18 AS builder
WORKDIR /app

# Install node_modules as a separate cachable layer
COPY package*.json .
RUN npm ci

# Copy the app
COPY ./.evidence/ ./evidence/
COPY ./pages/ ./pages/
COPY ./sources/ ./sources/
COPY .npmrc ./
COPY evidence.plugins.yaml ./

# Build data sources 
RUN npm run sources

# Build documentation (svelte app that is statically generated)
RUN npm run build
RUN npm prune --production

################################################################################
# RUNTIME STAGE
################################################################################

# Nginx Unit: 
# https://github.com/nginx/unit/blob/master/pkg/docker/Dockerfile.minimal
FROM nginx/unit:1.29.1-minimal

# Add nginx unit config
COPY ./config.json /docker-entrypoint.d/config.json

# Copy app from build stage into default www folder
COPY --from=builder /app/build /var/www/

EXPOSE 80