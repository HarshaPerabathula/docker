# # Stage 1: Build the React app
# FROM node:20 as builder

# WORKDIR /app

# COPY package.json package-lock.json ./
# RUN npm install

# COPY . .
# RUN npm run build

# # Stage 2: Serve the app with Nginx (or another web server)
# FROM nginx:alpine

# COPY --from=builder /app/dist /usr/share/nginx/html
# RUN rm /etc/nginx/conf.d/default.conf
# COPY nginx.conf /etc/nginx/nginx.conf
# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]

# FROM node:alpine
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# EXPOSE 5173
# CMD [ "npm", "run", "dev" ]

# FROM node:20 as builder
# WORKDIR /app
# COPY package.json package-lock.json ./
# RUN npm install --frozen-lockfile
# COPY . .
# RUN npm run build
# FROM nginx:alpine AS runner
# WORKDIR /usr/share/nginx/html
# COPY --from=builder /app/dist .
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# FROM node:20-alpine
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . .
# EXPOSE 80
# CMD ["npm", "run", "dev"]

FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
RUN npm install -g serve
EXPOSE 3000
CMD [ "serve", "-s", "dist", "-l", "3000" ]