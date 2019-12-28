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
