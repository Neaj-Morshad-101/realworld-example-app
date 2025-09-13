# File: backend/Dockerfile

# ---- Stage 1: Build Stage ----
# Use a specific Node.js version for reproducibility. Alpine is a lightweight Linux distribution.
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker layer caching.
# This step only re-runs if these files change.
COPY package.json package-lock.json* ./

# Install all dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# ---- Stage 2: Production Stage ----
# Use the same lightweight Node.js Alpine base image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Create a non-root user and group for security
# The '-D' flag means it's a system user, without a home directory or password
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy dependencies from the builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy application code from the builder stage
COPY --from=builder /app .

# Change the ownership of the application files to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port the application will run on (as documented in the project)
EXPOSE 3001

# The command to run the application
# Using ["node", "index.js"] is the preferred 'exec' form for better signal handling
CMD ["node", "index.js"]