--DATA CLEANING

--Removing the unwanted empty columns (Returns, ind1, ind2)
--ALTER TABLE DataAnalysis..SalesDataGlobalStore
--DROP COLUMN Returns, ind1, ind2;

--Selecting all Rows and Columns from Global Store Sales Data
SELECT *
FROM DataAnalysis..SalesDataGlobalStore
ORDER BY Order_Date;

--Removing unnecessary Time associated with Dates
SELECT Row_ID, Order_ID, Order_Date, CONVERT(Date, Order_Date) AS Order_Date_, Ship_Date, CONVERT(Date, Ship_Date) AS Ship_Date_, Customer_ID, Segment, Country,
City, State, Region, Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Profit, Payment_Mode
FROM DataAnalysis..SalesDataGlobalStore
ORDER BY Order_Date;

--Selecting some important Columns to analyse further
SELECT Order_ID, CONVERT(Date, Order_Date) AS Order_Date_, CONVERT(Date, Ship_Date) AS Ship_Date_, Ship_Mode, Customer_ID, Customer_Name,
Segment, City, State, Region, Product_ID, Category, Sub_Category, Product_name, Sales, Quantity, Profit, Payment_Mode
FROM DataAnalysis..SalesDataGlobalStore
ORDER BY Order_Date;

--Calculating Total Profit of Sales
SELECT SUM(Profit) AS PROFIT_SUM
FROM DataAnalysis..SalesDataGlobalStore

--Grouping according to States and Calculating their Total Profits
SELECT SUM(Profit) AS Total_Profit, State
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY State
ORDER BY Total_Profit DESC
--According to observation California is the State with maximum Total Profit and some states have loss too (So, Here extreme care should be taken for further sales)
--Texas is having minimum Profit
--There are 49 States in total

--Calculating Total Profit Region-wise
SELECT SUM(Profit) AS Total_Profit, Region
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Region
ORDER BY Total_Profit DESC;
--Highest Profit can be seen in West Region, then East Region, then Central Region, then South Region

--Searching for City in State Calfornia having Highest Profit
SELECT SUM(Profit) AS Total_Profit, City
FROM DataAnalysis..SalesDataGlobalStore
WHERE State = 'California'
GROUP BY City
ORDER BY Total_Profit DESC;
--Therefore, Los Angeles City is having Highest Profit

--Now Displaying Total number of Sales by Category of Product
SELECT SUM(Sales) AS Total_Sales, Category
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Category
ORDER BY Total_Sales DESC;
--Number of Sales are highest for Office Supplies, then for Furniture, and lowest for Technology

--Now Displaying Total number of Sales by Sub_Category of Product
SELECT SUM(Sales) AS Total_Sales, Sub_Category
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;
--In Sub_Category Highest Sales can be seen for Phones followed by Chairs, Binders due to 2nd, 3rd Sub_Category Sales is highest for Office Supplies

--Sorting according to Segment 
SELECT SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit, Segment, (SUM(Profit)/SUM(Sales-Profit))*100 AS Ratio
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Segment
ORDER BY Total_Sales DESC;
--Highest Sales are for Consumer, then Corporate, then Home Office but Percentage Profit is Highest for Home Office, then Corporate, then Consumer

--Calculating Time of Delivery or Shipping
SELECT CONVERT(Date, Order_Date) AS Order_Date_, CONVERT(Date, Ship_Date) AS Ship_Date_, DAY(Ship_Date-Order_Date) AS Delivery_Time, State
FROM DataAnalysis..SalesDataGlobalStore
ORDER BY Delivery_Time;
--Minimum Delivery Time is 1 Day and Maximum Delivery Time is 9 Days

--Calculating Average_Delivery_Time
SELECT AVG(DAY(Ship_Date-Order_Date)) AS Average_Delivery_Time
FROM DataAnalysis..SalesDataGlobalStore;
--Average_Delivery_Time is 4 Days

--Sorting according to Ship_Mode
SELECT COUNT(Order_ID) AS Total_Ship_Mode, Ship_Mode
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Ship_Mode
ORDER BY Total_ship_Mode DESC;
--Maximum used Ship_Mode is Standard Class, then Second Class, then First Class, then Same Day

--Finding Quantity of a Particular Type of Product
SELECT SUM(Quantity) AS Total_Quantity, Product_Name
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Product_Name
ORDER BY Total_Quantity DESC;
--From this Query it can be observed that Maximum Quantity is of Staples

--Sorting according to Product_Name
SELECT SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit, Product_Name, (SUM(Profit)/SUM(Sales-Profit))*100 AS Ratio
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Product_Name
ORDER BY Ratio DESC;
--Maximum Profit_Percentage is for Product HP Designjet T520 Inkjet Large Format Printer - 24" Color
--By looking into this query products producing loss can be removed 

--Sorting according to Payment Mode
SELECT COUNT(Order_ID) AS Total_Payment_Mode, Payment_Mode
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Payment_Mode
ORDER BY Total_Payment_Mode DESC;
--Mostly people prefer Cash on Delivery, then Online Payment, then Cards

--Finding Most Frequent Customer 
SELECT COUNT(Order_ID) AS Number_Of_Times_Visited, Customer_Name
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Customer_Name
ORDER BY Number_Of_Times_Visited DESC;
--Therefore, Emily Phan is the Most Frequent Customer (Some benefits can be provided to Top 10 Customers)

--Selecting Top 10 Customers Names
SELECT TOP 10 COUNT(Order_ID) AS Number_Of_Times_Visited, Customer_Name
FROM DataAnalysis..SalesDataGlobalStore
GROUP BY Customer_Name
ORDER BY Number_Of_Times_Visited DESC;
--Top 10 Customers are : Emily Phan, Edward Hooks, Paul Prost, Seth Vernon, Pete Kriz, Lena Cacioppo, Sally Hughsby, William Brown, Dean percer, Mick Hernandez
