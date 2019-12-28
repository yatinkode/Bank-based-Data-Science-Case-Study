#import libraries
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
import numpy as np

#read file
df = pd.read_excel (r'C:\Users\kode surendra aba\Desktop\Data science\case study for jlt\Data Science Case Study.xlsx', sheet_name='X Bank')

#extract exact data that we need
df = df[df.columns[1:9]]

#observe the data
df.head()

df.shape #(4014, 9)

#Removing duplicates
df.drop_duplicates(inplace = True)

df.shape #There are no duplicates in the data

#extract month from Date Joined
df['Month'] = df['Date Joined'].str[3:6]

df.Month.value_counts()

#extract day from Date Joined
df['Day'] = df['Date Joined'].str[0:2]

df['Day'] = df['Day'].astype(int)

df.Day.value_counts()


X = df[['Gender','Region','Job Classification','Month']]

X = pd.get_dummies(data=X, drop_first=True)

X2 = df[['Age','Day']]

#Scaling Age and Day
mms=MinMaxScaler()
X2 =mms.fit_transform(X2)
X2 = pd.DataFrame(X2)
X2.rename(columns = {0:'Age',1:'Day'}, inplace = True)

X = pd.concat([X.reset_index(drop=True), X2], axis=1)

Y = df[['Balance']]

from sklearn.linear_model import LinearRegression

model = LinearRegression().fit(X, Y)
r_sq = model.score(X, Y)
print('coefficient of determination:', r_sq)


coefficients=pd.DataFrame({'name':list(X),'value':model_1.coef_})

list(X)

print("Mean squared error:", np.mean((model_1.predict(X)-Y) ** 2))
print("R²:",model_1.score(X, Y))


X_new = X[['Age','Region_Wales','Gender_Male']]

########## OLS
model = sm.OLS(Y, X_new).fit()
predictions = model.predict(X_new)
model.summary()
