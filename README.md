# Hospital Patient Locator

## Overview
The Hospital Patient Locator is a microservice application designed to track and manage patient locations within a hospital environment. This system provides real-time tracking, movement detection, and health data management through a microservices architecture.

## Video Demostrations
QR Scanning with real time location mapping and notificating :

https://github.com/user-attachments/assets/4f0ab823-47eb-42b8-8fce-024198b8b8bf

Login feature : 

https://github.com/user-attachments/assets/903709da-4d60-494f-bc01-2eb81de4ac94

## Key Features
- Real-time patient location tracking
- Hallway movement detection
- Health data management
- User authentication and authorization
- Mobile and web interfaces
- Real-time notifications
- QR code-based location tracking

## Architecture

### Backend Services
- **Eureka Server** (Port: 8761): Service discovery and registration
- **Gateway Server** (Port: 8080): API gateway for routing and load balancing
- **User Service** (Port: 8082): Handles authentication and user management
- **Patient Location Service** (Port: 5002): Manages real-time patient location data
- **Hallway Detection Service** (Port: 5001): Processes movement detection in hospital hallways
- **Notification Service** (Port: 5000): Manages alerts and notifications
- **Health Data Service**: Manages patient health information

### Frontend Applications
- **Web Application** (Port: 3000): React-based admin interface
- **Mobile Application**: Flutter-based mobile app for staff

## Prerequisites
- Docker and Docker Compose
- Java 17 or higher
- Maven
- Node.js and npm
- MongoDB

## Quick Start with Docker Compose

1. Clone the repository:
- git clone 
2. Run the following command in terminal :
- docker compose up -d
  
## API Documentation
- Eureka Dashboard: http://localhost:8761
- API Gateway: http://localhost:8080
- User Service: http://localhost:8082
- Patient Location Service: http://localhost:5002
- Notification Service: http://localhost:5000
- Hallway Detection Service: http://localhost:5001

## Service Endpoints

### User Service
- POST `/api/register`: Register a new user
- POST `/api/login`: User authentication
- GET `/api/user/{username}`: Get user details

### Patient Location Service
- GET `/api/localisations/last`: Get latest patient locations
- POST `/api/localisations`: Update patient location
- GET `/api/localisations/{patientId}`: Get specific patient location

### Notification Service
- POST `/api/notifications/send`: Send new notification
- GET `/api/notifications/{userId}`: Get user notifications

## Security
- JWT-based authentication
- Role-based access control
- Secure API gateway
- CORS configuration

## Troubleshooting
1. If services fail to register with Eureka:
   - Ensure Eureka server is running
   - Check network connectivity
   - Verify service configurations

2. If MongoDB connection fails:
   - Verify MongoDB container is running
   - Check connection string
   - Ensure network connectivity

3. Frontend connection issues:
   - Verify API gateway is running
   - Check CORS configuration
   - Ensure proper endpoint URLs

## Contributions 
- [AAFIF Khawla](https://github.com/KhawlaAAFIF)
- [AIT EL GAZZAR Mohammed](https://github.com/MohammedAitelgazzar)
- [AIT KIKA Marouane](https://github.com/Marouane124)
- [RABQAUI Nabila](https://github.com/nabilarabqaoui)
- [Souadi Chayma](https://github.com/Chayma-05) 
