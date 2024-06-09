import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import App from './App';
import ConfirmPayment from './ConfirmPayment';
import './index.css';

ReactDOM.render(
  <Router>
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/confirm_payment" element={<ConfirmPayment />} />
    </Routes>
  </Router>,
  document.getElementById('root')
);
