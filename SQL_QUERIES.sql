/*Nashville Housing Data Cleanining in SQL*/

select * 
from PortFolioProjects..NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Standardize Sale Date

select SaleDate, convert(Date,Saledate)
from PortFolioProjects..NashvilleHousing 

update NashvilleHousing
set SaleDate = convert(Date,Saledate)

alter table NashvilleHousing
Add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted = convert(Date,Saledate)

--To check:
select SaleDateConverted
from PortFolioProjects..NashvilleHousing

-----------------------------------------------------------------------------------------------------------------------------------------------------------

--Populating Properties Address Data

select *
from PortFolioProjects..NashvilleHousing 
--where PropertyAddress is null 
order by ParcelID

select *
from PortFolioProjects..NashvilleHousing a
join PortFolioProjects..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
from PortFolioProjects..NashvilleHousing a
join PortFolioProjects..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress)
from PortFolioProjects..NashvilleHousing a
join PortFolioProjects..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from PortFolioProjects..NashvilleHousing a
join PortFolioProjects..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Breaking out Address into Individual Column names

select PropertyAddress
from PortFolioProjects..NashvilleHousing 
--where PropertyAddress is null 
--order by ParcelID

select 
SUBSTRING( PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address
, SUBSTRING( PropertyAddress, CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress)) as Address
from PortFolioProjects..NashvilleHousing

--create two new columns and add the value above
alter table NashvilleHousing
Add PropertySplitAddress nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = SUBSTRING( PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

alter table NashvilleHousing
Add PropertySplitCity nvarchar(255);

update NashvilleHousing
set PropertySplitCity = SUBSTRING( PropertyAddress, CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress))

select * 
from PortFolioProjects..NashvilleHousing

--similar task done on the owner address not using SUBSTRINGS but using PARSENAME which works on periods

select OwnerAddress
from PortFolioProjects..NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress,',','.') , 3)
, PARSENAME(REPLACE(OwnerAddress,',','.') , 2)
, PARSENAME(REPLACE(OwnerAddress,',','.') , 1)
from PortFolioProjects..NashvilleHousing

alter table NashvilleHousing
add OwnerSplitAddress nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

alter table NashvilleHousing 
add OwnerSplitCity nvarchar(255);

update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

alter table NashvilleHousing
add OwnerSplitState nvarchar(255);

update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--select * from PortFolioProjects..NashvilleHousing

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Change Y and N to Yes and No in 'Sold as Vacant' field

select Distinct(SoldasVacant), count(SoldAsVacant)
from PortFolioProjects..NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case 
	when SoldasVacant = 'Y' then 'Yes'
	when SoldasVacant = 'N' then 'No'
	else SoldasVacant
end
from PortFolioProjects..NashvilleHousing

update NashvilleHousing
set SoldAsVacant =
case 
	when SoldasVacant = 'Y' then 'Yes'
	when SoldasVacant = 'N' then 'No'
	else SoldasVacant
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Removing Duplicates 

select * ,
	row_number() over (
	partition by ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				order by UniqueID
				) row_num
from PortFolioProjects..NashvilleHousing
order by ParcelID

--put the above in the a CTE
WITH Row_NumCTE as (
select * ,
	row_number() over (
	partition by ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				order by UniqueID
				) row_num
from PortFolioProjects..NashvilleHousing
--order by ParcelID
)
select * 
from Row_NumCTE
where row_num > 1
order by PropertyAddress

--Deleting the Duplicates 
WITH Row_NumCTE as (
select * ,
	row_number() over (
	partition by ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				order by UniqueID
				) row_num
from PortFolioProjects..NashvilleHousing
--order by ParcelID
)
Delete 
from Row_NumCTE
where row_num > 1
--order by PropertyAddress

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--Deleting unused columns

select *
from PortFolioProjects..NashvilleHousing

Alter Table PortFolioProjects..NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table PortFolioProjects..NashvilleHousing
Drop Column SaleDate
