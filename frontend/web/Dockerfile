FROM node:18-alpine
WORKDIR /app
# First, copy only package files to leverage Docker cache
COPY hospital_patient_locator/package*.json ./
RUN npm install
# Then copy the rest of the frontend application
COPY hospital_patient_locator/ .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"] 