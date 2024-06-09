import React from 'react';
import { Routes, Route } from 'react-router-dom';
import ConfirmPayment from './components/ConfirmPayment';

function App() {
  return (
    <div>
      <Routes>
        <Route path="/confirm_payment" element={<ConfirmPayment />} />
      </Routes>
    </div>
  );
}

export default App;
