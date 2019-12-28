#import libraries
from datetime import datetime

import warnings
import statistics
import itertools
import numpy as np
import matplotlib.pyplot as plt
warnings.filterwarnings("ignore")
plt.style.use('fivethirtyeight')
import pandas as pd
import statsmodels.api as sm
import matplotlib

matplotlib.rcParams['axes.labelsize'] = 14
matplotlib.rcParams['xtick.labelsize'] = 12
matplotlib.rcParams['ytick.labelsize'] = 12
matplotlib.rcParams['text.color'] = 'k'

#read file
df = pd.read_excel (r'C:\Users\kode surendra aba\Desktop\Data science\case study for jlt\Data Science Case Study.xlsx', sheet_name='Bank Balance')

#We can see that the data of year 1995 is missing so we consider as mean of 1994 and 1996

#df.iloc[ 14 ,1 ]
#df.iloc[ 15 ,1 ]

#a = np.array(df.iloc[ 14 ,1 ],df.iloc[ 15 ,1 ])

#series = pd.Series([1995,np.mean(a)])

#df1995 = pd.DataFrame([series])

#df1995.columns = ['Year', 'Balance']


#dftil1994 = df.loc[:14]
#dffrom1996 = df.loc[15:]

#df_new = dftil1994.append(df1995, ignore_index=True)
#df_new = df_new.append(dffrom1996, ignore_index=True)

#df_new = df_new[['Year','Balance']]

#Convert year string to datetime object
df['Year'] =  pd.to_datetime(df['Year'], format='%Y')

df = df.set_index('Year')
df.index

#Plotting the time series
df.plot(figsize=(15, 6))




y = df['Balance'].resample('YS').mean()

decomposition = sm.tsa.seasonal_decompose(y, model='additive')
fig = decomposition.plot()

p = d = q = range(0, 2)
pdq = list(itertools.product(p, d, q))
seasonal_pdq = [(x[0], x[1], x[2], 12) for x in list(itertools.product(p, d, q))]
print('Examples of parameter combinations for Seasonal ARIMA...')
print('SARIMAX: {} x {}'.format(pdq[1], seasonal_pdq[1]))
print('SARIMAX: {} x {}'.format(pdq[1], seasonal_pdq[2]))
print('SARIMAX: {} x {}'.format(pdq[2], seasonal_pdq[3]))
print('SARIMAX: {} x {}'.format(pdq[2], seasonal_pdq[4]))

#Find best parameters for p d q
for param in pdq:
    for param_seasonal in seasonal_pdq:
        try:
            mod = sm.tsa.statespace.SARIMAX(y,
                                            order=param,
                                            seasonal_order=param_seasonal,
                                            enforce_stationarity=False,
                                            enforce_invertibility=False)
            results = mod.fit()
            print('ARIMA{}x{}12 - AIC:{}'.format(param, param_seasonal, results.aic))
        except:
            continue

#ARIMA(1, 1, 0)x(1, 1, 0, 12)12 - AIC:6.0 is Best and lowest AIC

#fitting the best ARIMA model
mod = sm.tsa.statespace.SARIMAX(y,
                                order=(1, 1, 0),
                                seasonal_order=(1, 1, 0, 12),
                                enforce_stationarity=False,
                                enforce_invertibility=False)

results = mod.fit()
print(results.summary().tables[1])

results.plot_diagnostics(figsize=(16, 8))
plt.show()

#Validating forecasts
pred = results.get_prediction(start=pd.to_datetime('2000-01-01'), dynamic=False)
pred_ci = pred.conf_int()
ax = y['1980':].plot(label='observed')
pred.predicted_mean.plot(ax=ax, label='One-step ahead Forecast', alpha=.7, figsize=(14, 7))
ax.fill_between(pred_ci.index,
                pred_ci.iloc[:, 0],
                pred_ci.iloc[:, 1], color='k', alpha=.2)
ax.set_xlabel('Year')
ax.set_ylabel('Balance')
plt.legend()
plt.show()


y_forecasted = pred.predicted_mean
y_truth = y['2000-01-01':]
mse = ((y_forecasted - y_truth) ** 2).mean()
print('The Mean Squared Error of our forecasts is {}'.format(round(mse, 2)))
#The Mean Squared Error of our forecasts is 2231222258.17

print('The Root Mean Squared Error of our forecasts is {}'.format(round(np.sqrt(mse), 2)))
#The Root Mean Squared Error of our forecasts is 47235.82

pred_uc = results.get_forecast(steps=7)
pred_ci = pred_uc.conf_int()
ax = y.plot(label='observed', figsize=(14, 7))
pred_uc.predicted_mean.plot(ax=ax, label='Forecast')
ax.fill_between(pred_ci.index,
                pred_ci.iloc[:, 0],
                pred_ci.iloc[:, 1], color='k', alpha=.25)
ax.set_xlabel('Year')
ax.set_ylabel('Balance')
plt.legend()
plt.show()

print(pred_uc.predicted_mean)
#2006-01-01     6717.506866
#2007-01-01    36328.721718
#2008-01-01    -2196.603907
#2009-01-01    60946.329446
#2010-01-01    21200.245705
#2011-01-01    11539.201724
#2012-01-01    12098.589055


