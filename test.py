import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm

# ---- Step 1: Simulate data ----
np.random.seed(42)
n_days = 180
base_price = 10.0
base_demand = 500
elasticity_true = -1.5  # true price elasticity
seasonality = np.sin(np.linspace(0, 4*np.pi, n_days)) * 0.2
noise = np.random.normal(0, 0.05, n_days)

prices = base_price + np.random.uniform(-2, 2, n_days)
demand = base_demand * (prices / base_price) ** elasticity_true
demand = demand * (1 + seasonality + noise)
revenue = prices * demand

df = pd.DataFrame({
    'day': np.arange(n_days),
    'price': prices,
    'quantity': demand,
    'revenue': revenue
})

# ---- Step 2: Fit elasticity model (log-linear regression) ----
df['log_q'] = np.log(df['quantity'])
df['log_p'] = np.log(df['price'])
X = sm.add_constant(df['log_p'])
model = sm.OLS(df['log_q'], X).fit()
elasticity_est = model.params['log_p']
print(f"Estimated price elasticity: {elasticity_est:.3f}")

# ---- Step 3: Compute optimal price for max revenue ----
# For log-linear: optimal price = MC * elasticity / (1 + elasticity)
# Assuming marginal cost = 5.0
mc = 5.0
p_opt = mc * elasticity_est / (1 + elasticity_est)
print(f"Optimal price (max revenue): ${p_opt:.2f}")

# ---- Step 4: Plot demand curve ----
price_range = np.linspace(min(df['price']), max(df['price']), 100)
predicted_q = np.exp(model.params['const']) * price_range ** elasticity_est
plt.figure(figsize=(8,5))
plt.plot(price_range, predicted_q, label="Predicted demand")
plt.axvline(p_opt, color='red', linestyle='--', label=f"Optimal price ${p_opt:.2f}")
plt.scatter(df['price'], df['quantity'], alpha=0.5, label="Observed data")
plt.xlabel("Price")
plt.ylabel("Quantity sold")
plt.legend()
plt.title("Price–Demand Relationship & Optimal Price")
plt.show()
