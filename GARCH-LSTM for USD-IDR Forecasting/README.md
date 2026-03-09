## 💵 USD/IDR Forecasting & Trading Strategy using Hybrid GARCH-LSTM Model

This project applies a hybrid econometric–deep learning framework to forecast USD/IDR exchange rate movements. The model integrates GARCH(1,1) volatility estimation with an LSTM neural network to capture both volatility clustering and non-linear time-series patterns.

In addition to forecasting, the predictions are translated into rule-based trading signals and evaluated through backtesting simulations to assess whether the model can improve risk-adjusted returns compared to a Buy & Hold strategy.

### 🧠 Workflow / Pipeline

The project follows a structured pipeline from data preparation to trading strategy evaluation.
1. **Data Collection**  
   Gather historical exchange rate data and macroeconomic indicators.
   - Historical exchange rate data from USD/IDR covering Jan 2015 - Dec 2024 (Source: Bank Indonesia - https://www.bi.go.id/id/statistik/indikator/BI-Rate)
   - Inflation (Source: Bank Indonesia - https://www.bi.go.id/en/statistik/informasi-kurs/transaksi-bi/default.aspx)
   - Interest Rate (Source: Bank Indonesia - https://www.bi.go.id/en/statistik/indikator/bi-rate.aspx and Federal Reserve Economic Data - https://fred.stlouisfed.org/series/IRSTCB01IDM156N)

2. **Data Preprocessing**  
   - Data Integration - Macroeconomic variables aligned with daily exchange rate data using forward-fill (FFill) to match monthly release frequencies
   - Log transformation applied to ensure stationarity for volatility modeling in the GARCH framework
   - Scaling performed to normalize inputs for LSTM models
   - Data Splitting

3. **Model Development**  
   - GARCH(1,1) Model
     To estimate conditional volatility, which is used as an additional input feature for the LSTM models.
   - LSTM-Based Models
     - Standalone LSTM (exchange rate only)
     - LSTM with 2 features (exchange rate + GARCH volatility)
     - LSTM with 4 features (exchange rate + volatility + macroeconomic indicators)

4. **Model Evaluation**  
   Compare LSTM-based models' performance using RMSE, MAE, and R².

7. **Trading Strategy Simulation**  
   Predicted price movements are converted into trading signals and evaluated through a rule-based strategy framework. The strategy performance is tested under different holding days and profit taking configurations:
   - Configuration 1 (5D - 2.5%) Strategy
   - Configuration 2 (10D - 4%) Strategy
   - Configuration 3 (30D - 6%) Strategy
   
   These configurations are compared with a passive Buy and Hold Strategy using Total Returns, Annualized Returns, Sharpe Ratio, and Maximum Drawdown.

### 🗂 Flowchart

<p align="center">
  <img width="600" height="500" alt="image" src="https://github.com/user-attachments/assets/7ded700f-87bc-40fd-850e-53d37684455e" />
</p>

### 📈 Key Insights / Results

- **Model Performance**
  - Hyperparameter tuning significantly improved model accuracy for both LSTM and GARCH-LSTM models. The tuned GARCH-LSTM model with two features (price + volatility) achieved the best forecasting performance, improving **RMSE from 116.35 (baseline standalone LSTM) to 67.47 and increasing R² to 0.976**. This suggests that incorporating volatility information can significantly enhance exchange rate prediction.
  - Additional macroeconomic features did not consistently improve performance. While the 4-feature baseline model showed strong results, hyperparameter tuning revealed that the simpler 2-feature model generalized better, indicating that **volatility carries more predictive power for USD/IDR movements.**

- **Trading Strategy Performance**
  - Model-based trading strategies outperformed the buy-and-hold benchmark. The best configuration (10-day holding period with 4% profit-taking) achieved **7.92% total return and a Sharpe ratio of 0.87**, compared to **6.22% return and Sharpe 0.61** for buy-and-hold, indicating improved risk-adjusted performance.
  - While longer holding periods (30 days) produced slightly higher total returns, the **10-day strategy delivered the highest Sharpe ratio and more controlled drawdowns**, suggesting that moderate holding horizons better capture short-term exchange rate dynamics.


### 💡 Practical Implications

- Volatility-aware models such as GARCH-LSTM can significantly improve the USD/IDR exchange rate forecasting accuracy.
- Adding multiple macroeconomic variables for this currency pair does not necessarily improve model performance and may introduce noise.
- Medium-term trading strategies (around 10-day holding periods) may provide the best balance between return and risk, meaning that positions are closed either when the profit-taking threshold of 4% is reached or when the maximum holding period (10 days) expires.

### 🛠 Tool & Libraries
- Python
- NumPy, Pandas – EDA, Data Cleaning, Data processing
- Scikit-learn – Data preprocessing and evaluation metrics
- TensorFlow / Keras – LSTM model development
- ARCH / statsmodels – GARCH volatility modeling
- Matplotlib / Seaborn – Visualization
