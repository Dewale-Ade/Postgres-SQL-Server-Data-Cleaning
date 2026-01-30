# Postgres-SQL-Server-Data-Cleaning
Nashville Housing Data Cleaning.sql

View Data

SELECT *
FROM nashvillehousing;


Standardize Date Format

SELECT saledate, saledate::date
FROM nashvillehousing;

ALTER TABLE nashvillehousing
ADD COLUMN saledate_converted DATE;

UPDATE nashvillehousing
SET saledate_converted = saledate::date;

SELECT saledate, saledate_converted
FROM nashvillehousing;


Populate Missing PropertyAddress


SELECT a.parcelid, a.propertyaddress,
       b.parcelid, b.propertyaddress
FROM nashvillehousing a
JOIN nashvillehousing b
  ON a.parcelid = b.parcelid
 AND a."UniqueID" <> b."UniqueID"
WHERE a.propertyaddress IS NULL;

UPDATE nashvillehousing a
SET propertyaddress = b.propertyaddress
FROM nashvillehousing b
WHERE a.parcelid = b.parcelid
  AND a."UniqueID" <> b."UniqueID"
  AND a.propertyaddress IS NULL;


Split PropertyAddress (Address, City)

SELECT propertyaddress
FROM nashvillehousing;

SELECT
  TRIM(SPLIT_PART(propertyaddress, ',', 1)) AS street_address,
  TRIM(SPLIT_PART(propertyaddress, ',', 2)) AS city
FROM nashvillehousing;

ALTER TABLE nashvillehousing
ADD COLUMN property_split_address VARCHAR(255),
ADD COLUMN property_split_city VARCHAR(255);

UPDATE nashvillehousing
SET property_split_address = TRIM(SPLIT_PART(propertyaddress, ',', 1)),
    property_split_city = TRIM(SPLIT_PART(propertyaddress, ',', 2));
    

Split OwnerAddress (Address, City, State)

SELECT owneraddress
FROM nashvillehousing;

SELECT
  TRIM(SPLIT_PART(owneraddress, ',', 1)) AS owner_address,
  TRIM(SPLIT_PART(owneraddress, ',', 2)) AS owner_city,
  TRIM(SPLIT_PART(owneraddress, ',', 3)) AS owner_state
FROM nashvillehousing;

ALTER TABLE nashvillehousing
ADD COLUMN owner_split_address VARCHAR(255),
ADD COLUMN owner_split_city VARCHAR(255),
ADD COLUMN owner_split_state VARCHAR(255);

UPDATE nashvillehousing
SET owner_split_address = TRIM(SPLIT_PART(owneraddress, ',', 1)),
    owner_split_city = TRIM(SPLIT_PART(owneraddress, ',', 2)),
    owner_split_state = TRIM(SPLIT_PART(owneraddress, ',', 3));


Normalize SoldAsVacant (Y/N → Yes/No)

SELECT soldasvacant, COUNT(*)
FROM nashvillehousing
GROUP BY soldasvacant;

UPDATE nashvillehousing
SET soldasvacant =
    CASE
        WHEN soldasvacant = 'Y' THEN 'Yes'
        WHEN soldasvacant = 'N' THEN 'No'
        ELSE soldasvacant
    END;


Remove Duplicates

WITH rownum_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   parcelid,
                   propertyaddress,
                   saleprice,
                   saledate,
                   legalreference
               ORDER BY "UniqueID"
           ) AS row_num
    FROM nashvillehousing
)
SELECT *
FROM rownum_cte
WHERE row_num > 1;

WITH rownum_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY
                   parcelid,
                   propertyaddress,
                   saleprice,
                   saledate,
                   legalreference
               ORDER BY "UniqueID"
           ) AS row_num
    FROM nashvillehousing
)
DELETE
FROM nashvillehousing
USING rownum_cte
WHERE nashvillehousing."UniqueID" = rownum_cte."UniqueID"
  AND rownum_cte.row_num > 1;


Drop Unused Columns

ALTER TABLE nashvillehousing
DROP COLUMN owneraddress,
DROP COLUMN propertyaddress,
DROP COLUMN saledate;
