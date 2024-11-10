# Stage 1: Build Angular app with Node.js
FROM node:18-alpine AS builder

WORKDIR /app

# Copia los archivos de package para instalar las dependencias
COPY package*.json ./
RUN npm install

# Copia el resto de los archivos del proyecto
COPY . .

# Compila la aplicación Angular en modo producción
RUN npm run build -- --configuration production

# Stage 2: Serve app with Nginx
FROM nginx:alpine
COPY --from=builder /app/dist/agro-crypto /usr/share/nginx/html

# Expone el puerto 80 para Nginx
EXPOSE 80

# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
