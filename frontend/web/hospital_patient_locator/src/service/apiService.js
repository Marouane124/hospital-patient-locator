import axios from 'axios';

// Base URL of your backend API
const apiUrl = 'http://localhost:8080/api';

// Fetch user details by username
export const getUserDetails = async (username) => {
  if (!username) {
    throw new Error('Username is not available');
  }
  const response = await axios.get(`${apiUrl}/user/${username}`);
  return response.data;
};

// Fetch all localisations
export const getLocalisations = async () => {
    const response = await axios.get(`${apiUrl}/localisations/last`);
    console.log("Last localisation:", response.data);
    return response.data; // Expecting a single object
  };

// Add this function to your existing apiService.js
export const register = async (userData) => {
  try {
    const response = await axios.post(`${apiUrl}/register`, {
      username: userData.username,
      password: userData.password,
      roles: [{ name: userData.role }]
    });
    return response.data;
  } catch (error) {
    throw error.response?.data || 'Registration failed';
  }
};

// Add this login function to apiService.js
export const login = async (credentials) => {
  try {
    const response = await axios.post(`${apiUrl}/login`, credentials, {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      timeout: 5000  // 5 second timeout
    });
    console.log('Login response:', response);
    return response.data;
  } catch (error) {
    console.error('Login error details:', {
      message: error.message,
      response: error.response,
      request: error.request
    });
    //throw error.response?.data || error.message || 'Login failed';
  }
};
