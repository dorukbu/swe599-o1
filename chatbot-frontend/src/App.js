// Importing necessary libraries
import React, { useState } from 'react';
import './App.css'; // Add your custom styling here

function App() {
  const [prompt, setPrompt] = useState('');
  const [output, setOutput] = useState('');
  const [acceleration, setAcceleration] = useState('CPU');
  const [tokensPerSecond, setTokensPerSecond] = useState(null);

  const handlePromptChange = (event) => {
    setPrompt(event.target.value);
  };

  const handleAccelerationChange = (option) => {
    setAcceleration(option);
  };

  const handleSubmit = async () => {
    if (!prompt) return;

    const requestData = {
      prompt: prompt,
      acceleration: acceleration,
    };

    try {
      const start = performance.now();

      const response = await fetch('http://localhost:8000/generate', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(requestData),
      });

      const data = await response.json();
      const end = performance.now();

      setOutput(data.output);

      // Calculate tokens per second assuming the backend sends total tokens generated
      const tokensGenerated = data.tokens || 0;
      const durationInSeconds = (end - start) / 1000;
      setTokensPerSecond(tokensGenerated / durationInSeconds);
    } catch (error) {
      console.error('Error during prompt submission:', error);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Chatbot Frontend</h1>
        <textarea
          value={prompt}
          onChange={handlePromptChange}
          placeholder="Enter your prompt here..."
          rows="5"
          cols="50"
        ></textarea>
        <div className="button-group">
          <button onClick={() => handleAccelerationChange('CPU (no accelerator)')}>CPU</button>
          <button onClick={() => handleAccelerationChange('GPU')}>GPU</button>
          <button onClick={() => handleAccelerationChange('TPU')}>TPU</button>
        </div>
        <p>Selected Accelerator: {acceleration}</p>
        <button onClick={handleSubmit}>Submit</button>
        {output && (
          <div className="output-section">
            <h2>Response</h2>
            <p>{output}</p>
          </div>
        )}
        {tokensPerSecond && (
          <p>Tokens per second: {tokensPerSecond.toFixed(2)}</p>
        )}
      </header>
    </div>
  );
}

export default App;
