import React, { useState } from 'react';
import axios from 'axios';
import { useLocation } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faUniversity, faCoins } from '@fortawesome/free-solid-svg-icons';
import './ConfirmPayment.css';

const ConfirmPayment = () => {
  const location = useLocation();
  const [paymentStatus, setPaymentStatus] = useState(null);
  const [selectedMethod, setSelectedMethod] = useState('Bank Transfer');

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
    <div className="confirm-payment-container">
      <div className="confirm-payment-box">
        <h1>Confirm Payment</h1>
        <p><strong>Address:</strong> {address}</p>
        <p><strong>Amount:</strong> {amount} {currency}</p>
        <div className="payment-methods">
          <div
            className={`payment-method ${selectedMethod === 'Bank Transfer' ? 'selected' : ''}`}
            onClick={() => setSelectedMethod('Bank Transfer')}
          >
            <FontAwesomeIcon icon={faUniversity} className="icon" />
            <span>Bank Transfer</span>
          </div>
          <div
            className={`payment-method ${selectedMethod === 'XRP Transfer' ? 'selected' : ''}`}
            onClick={() => setSelectedMethod('XRP Transfer')}
          >
            <FontAwesomeIcon icon={faCoins} className="icon" />
            <span>XRP Transfer</span>
          </div>
        </div>
        <button onClick={handleConfirmPayment}>Confirm Payment</button>
        {paymentStatus && (
          <div className="payment-status">
            <p>Payment Status: {paymentStatus}</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default ConfirmPayment;
