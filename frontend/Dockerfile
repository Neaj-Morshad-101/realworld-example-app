# File: frontend/Dockerfile

# ---- Stage 1: Build Stage ----
# Use a specific Node.js version for reproducibility
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package.json and lock file to leverage caching
COPY package.json package-lock.json* ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Build the production-ready static files
# The REACT_APP_API_URL is set to /api so NGINX can proxy it
ENV REACT_APP_API_URL=/api
RUN npm run build

# ---- Stage 2: Production Stage ----
# Use a lightweight Nginx image
FROM nginx:stable-alpine

# Copy the built static files from the builder stage to Nginx's web root
COPY --from=builder /app/build /usr/share/nginx/html

# Remove the default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf


# Expose port 80 for Nginx
EXPOSE 80

# NGINX's base image already has a CMD to start the server, so we don't need one here