import React, { useState } from 'react';
import axios from 'axios';

const App = () => {
  const [address, setAddress] = useState('');
  const [amount, setAmount] = useState('');
  const [currency, setCurrency] = useState('XRP');
  const [paymentLink, setPaymentLink] = useState('');

  const handleGenerateLink = async () => {
    try {
      const response = await axios.post('http://localhost:5000/generate_payment_link', {
        address,
        amount,
        currency
      });
      setPaymentLink(response.data.payment_link);
    } catch (error) {
      console.error('Error generating payment link:', error);
    }
  };

  return (
    <div>
      <h1>Generate Payment Link</h1>
      <input
        type="text"
        placeholder="Address"
        value={address}
        onChange={(e) => setAddress(e.target.value)}
      />
      <input
        type="text"
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <select value={currency} onChange={(e) => setCurrency(e.target.value)}>
        <option value="XRP">XRP</option>
        {/* Add more currencies as needed */}
      </select>
      <button onClick={handleGenerateLink}>Generate Link</button>
      {paymentLink && (
        <div>
          <p>Payment Link:</p>
          <a href={paymentLink}>{paymentLink}</a>
        </div>
      )}
    </div>
  );
};

export default App;
