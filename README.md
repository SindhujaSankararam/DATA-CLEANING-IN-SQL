Project Title: Nashville Housing Data Cleaning in SQL
Introduction:
The Nashville Housing Data Cleaning project aims to clean and standardize the data in the NashvilleHousing table using SQL queries. The project focuses on tasks such as standardizing the sale date format, populating missing property address data, breaking out the address into individual columns, changing values in a specific field, and removing duplicates from the dataset. By performing these data cleaning operations, the project ensures that the Nashville housing data is accurate, consistent, and ready for further analysis.

Objectives:
Standardize Sale Date: Convert the SaleDate column to the date format and create a new column named SaleDateConverted to store the standardized dates.

Populating Properties Address Data: Retrieve property records with missing PropertyAddress and populate them using available records with the same ParcelID.

Breaking out Address into Individual Column Names: Split the PropertyAddress column into separate columns for Address and City. Similarly, split the OwnerAddress column into separate columns for Address, City, and State using appropriate SQL functions.

Change 'Y' and 'N' to 'Yes' and 'No' in the 'SoldAsVacant' field: Update the 'SoldAsVacant' field to replace 'Y' with 'Yes' and 'N' with 'No' to improve clarity.

Removing Duplicates: Identify and remove duplicate records from the dataset based on specific columns, such as ParcelID, PropertyAddress, SalePrice, SaleDate, and LegalReference.

Deleting Unused Columns: Remove unnecessary columns, such as OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate, from the NashvilleHousing table to streamline the data structure.

Project Workflow:


Standardize Sale Date:
Query the NashvilleHousing table to view the SaleDate column and its converted format using the CONVERT function.
Update the SaleDate column in the NashvilleHousing table to store the converted dates.
Add a new column named SaleDateConverted to the NashvilleHousing table and update it with the converted dates.


Populating Properties Address Data:
Query the NashvilleHousing table to identify records with missing PropertyAddress, ordered by ParcelID.
Join the NashvilleHousing table with itself on the ParcelID column to find records with the same ParcelID but different UniqueID values.
Filter the joined records to select those where PropertyAddress is null.
Update the null PropertyAddress records with the available PropertyAddress from the joined records.


Breaking out Address into Individual Column Names:
Query the PropertyAddress column from the NashvilleHousing table to preview the address values.
Use the SUBSTRING function to split the PropertyAddress into two parts: Address and City.
Add two new columns, PropertySplitAddress and PropertySplitCity, to the NashvilleHousing table.
Update the new columns with the respective address parts using the SUBSTRING function.


Breaking out Owner Address into Individual Column Names:
Query the OwnerAddress column from the NashvilleHousing table to preview the owner address values.
Use the PARSENAME and REPLACE functions to split the OwnerAddress into three parts: Address, City, and State.
Add three new columns, OwnerSplitAddress, OwnerSplitCity, and OwnerSplitState, to the NashvilleHousing table.
Update the new columns with the respective address parts using the PARSENAME and REPLACE functions.
Change 'Y' and 'N' to 'Yes' and 'No' in the 'SoldAsVacant' field:
Query the SoldAsVacant field to view the distinct values and their counts.
Use a CASE statement to update the SoldAsVacant field, replacing 'Y' with 'Yes' and 'N' with 'No'.


Removing Duplicates:
Use the ROW_NUMBER function with the PARTITION BY clause to identify duplicate records based on specific columns.
Put the above query into a common table expression (CTE) named Row_NumCTE.
Select the records from the CTE where the row number is greater than 1 to identify duplicate records.
Delete the duplicate records from the Row_NumCTE.


Deleting Unused Columns:
Query the NashvilleHousing table to view all columns.
Use the ALTER TABLE statement to drop unnecessary columns such as OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate.
Conclusion:
The Nashville Housing Data Cleaning in SQL project demonstrates the ability to perform data cleaning tasks using SQL queries. By executing a series of SQL statements, to standardize the sale date format, populate missing address data, split address information into separate columns, change field values, remove duplicates, and delete unnecessary columns. These data cleaning operations ensure the dataset's integrity, enhance data quality, and prepare the Nashville housing data for further analysis.
