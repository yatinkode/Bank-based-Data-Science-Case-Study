# Bank-based-Data-Science-Case-Study
 A small dataset has been provided along with some business problems to solve. Lets have a look at the data structure:
 
### Dataset : Data Science Case Study.xlsx

#### Sheet1: X Bank
                                                         
| __Column name__    | __Detail__                                                 |
|--------------------|------------------------------------------------------------|
| CustomerID         |  Unique ID for each customer(row)                          |
| Name               |  Customer's Name                                           |
| Surname            |  Customer's Surname                                        |
| Gender             |  Customer's Gender (Male/Female)                           |
| Age                |  Customer's Age                                            |
| Region             |  Region from where Customer belongs                        |
| Job Classification |  Job profile of Customer (White Collar/Blue Collar/Other)  |
| Date Joined        |  Account opening date of Customer                          |
| Balance            |  Account Balance of Customer                               |

#### Sheet2: Bank Balance
                                                         
| __Column name__    | __Detail__                                                 |
|--------------------|------------------------------------------------------------|
| Year               |  Year from 1980 - 2005                                     |
| Balance            |  Overall Balance                                           |
 
 
 ### Business problems to be solved
 1. Describe Banks' Customer profile
 2. Is there a factor influencing customer Balance
 3. What could possibly be the balance of a new customer male 28 age joining from Wales ?
 4. What will be  Bank's Opening Balance Projection for 2006 till 2012(Data in "Bank Balance" Sheet)

### Solution:
 #### 1. Describe Banks' Customer profile

For this I have prepared a Shiny App in R. The code is present in app.R file attached in the repository. Click on image below to see the complete working of the app.

[![Watch the app](https://github.com/yatinkode/Bank-based-Data-Science-Case-Study/blob/master/images/shinycustprof.JPG)](https://yatinkode.shinyapps.io/jltapp/)

 #### 2. Is there a factor influencing customer Balance
 
For this I have prepared various plots against Balance for other independent variables where I have found that there is no much correlation between these variables and Balance. So there is no particular factor influencing customer Balance.


 #### 3. What could possibly be the balance of a new customer male 28 age joining from Wales ?
 
 For this I have used python and Linear Regression to calculate the value of Balance which comes out to be 101018.5
 The code for the reression can be found in the file regression.py
 
 
 #### 4. What will be  Bank's Opening Balance Projection for 2006 till 2012(Data in "Bank Balance" Sheet) ?
 
For this I have used time series algorithm in Python the forecasts are given below. I have given code for the same in timeseries.py file
| __2006 __ | __2007 __ | __2008 __ |__2009 __ | __2010__  | __2011 __| __2012 __|
|-----------|-----------|-----------|----------|-----------|----------|----------|
| 6717.506  | 36328.72  |  -2196.60 | 60946.32 | 21200.24  | 11539.20 | 12098.58 |

