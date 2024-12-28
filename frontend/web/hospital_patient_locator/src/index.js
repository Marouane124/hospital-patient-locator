import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import SignUp from './component/Signup';
import FloorMapComponent from './component/FloorMapComponent';
import CameraDetection from './component/CameraDetection';
import reportWebVitals from './reportWebVitals';
import 'leaflet/dist/leaflet.css';
import 'leaflet-defaulticon-compatibility/dist/leaflet-defaulticon-compatibility.css';
import 'leaflet-defaulticon-compatibility';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';  // Added Routes and Route

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <Router>
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/signup" element={<SignUp />} />
        <Route path="/plan" element={<FloorMapComponent />} />
        <Route path="/camera" element={<CameraDetection />} />
      </Routes>
    </Router>
  </React.StrictMode>
);

reportWebVitals();

