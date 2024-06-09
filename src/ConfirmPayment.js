import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useLocation } from 'react-router-dom';

const ConfirmPayment = () => {
  const location = useLocation();
  const [paymentStatus, setPaymentStatus] = useState(null);

  const query = new URLSearchParams(location.search);
  const address = query.get('address');
  const amount = query.get('amount');
  const currency = query.get('currency');

  const handleConfirmPayment = async () => {
    try {
      const response = await axios.post('http://localhost:5000/make_payment', {
        address,
        amount,
        currency
      });
      setPaymentStatus(response.data.result);
    } catch (error) {
      console.error('Error making payment:', error);
      setPaymentStatus('Error');
    }
  };

  return (
    <div>
      <h1>Confirm Payment</h1>
      <p>Address: {address}</p>
      <p>Amount: {amount}</p>
      <p>Currency: {currency}</p>
      <button onClick={handleConfirmPayment}>Confirm Payment</button>
      {paymentStatus && (
        <div>
          <p>Payment Status: {paymentStatus}</p>
        </div>
      )}
    </div>
  );
};

export default ConfirmPayment;
