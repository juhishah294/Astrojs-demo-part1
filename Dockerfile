# Stage 1: Build the Astro project
FROM node:18-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock if you're using Yarn)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Astro project
RUN npm run build

# Stage 2: Serve the built project with a lightweight server
FROM node:18-alpine AS serve

# Set working directory and copy the built files from the previous stage
WORKDIR /app
COPY --from=build /app/dist /app/dist

# Install a lightweight HTTP server (e.g., serve)
RUN npm install -g serve

# Expose port 4321 (or any other port you prefer)
EXPOSE 4321

# Use serve to serve the built project
CMD ["serve", "-s", "dist", "-l", "4321"]
