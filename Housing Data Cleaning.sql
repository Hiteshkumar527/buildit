CREATE DATABASE housings;
USE HOUSINGS;
CREATE TABLE housing
( UniqueID 	VARCHAR(15),
  ParcelID	VARCHAR(25),
  LandUse VARCHAR(60),
  PropertyAddress VARCHAR(255),
  SaleDate datetime,
  SalePrice	INT,
  LegalReference VARCHAR(30),
  SoldAsVacant VARCHAR(10),
  OwnerName	VARCHAR(355),
  OwnerAddress VARCHAR(355),	
  Acreage DECIMAL(3,2),
  TaxDistrict VARCHAR(255),
  LandValue	INT,
  BuildingValue	INT,
  TotalValue INT,
  YearBuilt	YEAR,
  Bedrooms INT,
  FullBath INT,
  HalfBath	INT);

LOAD DATA INFILE 'Nashville Housing Data for DataCleaning.csv' INTO TABLE housing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@UniqueID, @ParcelID, @LandUse, @PropertyAddress, @SaleDate, @SalePrice, @LegalReference, @SoldAsVacant, @OwnerName, @OwnerAddress, @Acreage, @TaxDistrict, @LandValue,
@BuildingValue, @TotalValue, @YearBuilt, @Bedrooms, @FullBath, @HalfBath)

SET
 UniqueID = NULLIF(@UniqueID, ''),	
 ParcelID = NULLIF(@ParcelID, ''),
 LandUse = NULLIF(@LandUse, ''),
 PropertyAddress = NULLIF(@PropertyAddress, ''),
 SaleDate = NULLIF(@SaleDate, ''),
 SalePrice = NULLIF(@SalePrice, ''),
 LegalReference = NULLIF(@LegalReference, ''),
 SoldAsVacant = NULLIF(@SoldAsVacant, ''),
 OwnerName = NULLIF(@OwnerName, ''),
 OwnerAddress = NULLIF(@OwnerAddress, ''),
 Acreage = NULLIF(@Acreage, ''),
 TaxDistrict = NULLIF(@TaxDistrict, ''),
 LandValue = NULLIF(@LandValue, ''),
 BuildingValue = NULLIF(@BuildingValue, ''),
 TotalValue = NULLIF(@TotalValue, ''),
 YearBuilt = NULLIF(@YearBuilt, ''),
 Bedrooms = NULLIF(@Bedrooms, ''),
 FullBath = NULLIF(@FullBath, ''),	
 HalfBath = NULLIF(@HalfBath, '')

;


ALTER TABLE housing
MODIFY COLUMN SaleDate DATETIME;

ALTER TABLE housing
MODIFY COLUMN YearBuilt INT;

ALTER TABLE housing
MODIFY COLUMN Acreage DECIMAL(5,2);

SELECT * FROM housing;
COMMIT;

-- Standardize date format:

select converted_saledate, CONVERT(Saledate, date) from housing;
SELECT SALEDATE FROM HOUSING;

TRUNCATE HOUSING;

UPDATE HOUSING
SET converted_saledate = CONVERT(Saledate, date);

ALTER TABLE housing
ADD converted_saledate DATE;

-- Populate Property address data

select PropertyAddress from housing
where PropertyAddress is null ;

select * from housing
where PropertyAddress is null 
order by parcelid;
-- we can observe that data having same parcelid is having same property address

SELECT H1.PARCELID, H1.PROPERTYADDRESS, H2.PARCELID, H2.PROPERTYADDRESS, IFNULL(H1.PROPERTYADDRESS, H2.PROPERTYADDRESS) FROM HOUSING H1
JOIN HOUSING H2 ON H1.PARCELID = H2.PARCELID AND H1.UNIQUEID != H2.UNIQUEID
WHERE H1.PROPERTYADDRESS IS NULL;

UPDATE housing h1
JOIN HOUSING H2 ON H1.PARCELID = H2.PARCELID AND H1.UNIQUEID != H2.UNIQUEID
SET h1.PROPERTYADDRESS = IFNULL(H1.PROPERTYADDRESS, H2.PROPERTYADDRESS)
WHERE H1.PROPERTYADDRESS IS NULL;

-- breaking out addresses into individual columns (Address, City, State)
select propertyaddress from housing;

select propertyaddress, substring(propertyaddress, 1, locate(',', propertyaddress)-1) AS ADDRESS, substring(propertyaddress, locate(',', propertyaddress)+1) as City FROM housing;

ALTER TABLE HOUSING 
ADD ADDRESS VARCHAR(255);

ALTER TABLE housing
ADD CITY VARCHAR(75);

UPDATE HOUSING
SET ADDRESS = substring(propertyaddress, 1, locate(',', propertyaddress)-1);

UPDATE housing
SET CITY = substring(propertyaddress, locate(',', propertyaddress)+1);

SELECT PROPERTYADDRESS, ADDRESS, CITY FROM housing;


SELECT owneraddress, substring(owneraddress, 1, locate( ',', owneraddress)-1) as split_owneraddress, 
substring(owneraddress, locate(',', owneraddress)+1) as splitadd from housing;

alter table housing
add split_owneraddress varchar(255);
alter table housing
add ownercity varchar(255);
alter table housing
add ownerstate varchar(255);

update housing 
set split_owneraddress = substring(owneraddress, 1, locate( ',', owneraddress)-1);

(select substring(owneraddress, locate(',', owneraddress)+1) 
as splitadd, uniqueid from housing)

;select owneraddress from housing;

select substring(owneraddress, locate(',', owneraddress)+2) 
as splitadd from housing;

update housing 
set ownercity = substring(owneraddress, locate(',', owneraddress)+2)

;select ownercity from housing;
select substring(ownercity, locate(',',ownercity)+2) from housing;
update housing
set ownerstate = substring(ownercity, locate(',',ownercity)+2);
update housing
set ownercity = substring(ownercity, 1, locate(',', ownercity)-1);
select * from housing;

-- Convert Y and N to Yes and No
select Distinct(soldasvacant), count(soldasvacant) from housing
group by soldasvacant
order by 2;

UPDATE housing 
SET 
    Soldasvacant = CASE
        WHEN SOLDASVACANT = 'Y' THEN 'Yes'
        WHEN SOLDASVACANT = 'N' THEN 'No'
        ELSE SOLDASVACANT
    END;
                        
-- Remove Duplicates... (it's not a standard practice to delete the data that's in the database)

with rcte as (select * , row_number() over (partition by parcelid, propertyaddress, saleprice, saledate, legalreference
                              order by uniqueid) row_num
from housing
order by parcelid)
select * from rcte
where row_num > 1;

delete from housing
where uniqueid in 
(select uniqueid from (select uniqueid , row_number() over (partition by parcelid, propertyaddress, saleprice, saledate, legalreference
                              order by uniqueid) row_num
from housing) t
where row_num>1);

-- Delete unused columns ( dont use this for raw data in the professional space)
select * from housing; 

ALTER TABLE housing
DROP COLUMN Propertyaddress,
DROP COLUMN saledate,
DROP COLUMN owneraddress,
DROP COLUMN taxdistrict;
