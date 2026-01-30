---------  Project Overview

This project focuses on cleaning, transforming, and preparing Nashville housing data for analysis using PostgreSQL.

The dataset contained inconsistencies such as missing addresses, duplicate records, and unstandardized date formats.
The goal was to create a clean, structured, and analysis-ready dataset by applying real-world SQL data cleaning techniques.

---------  Dataset Description

The dataset contains housing transaction records with the following key fields:

Parcel ID

Property Address

Owner Address

Sale Date

Sale Price

Legal Reference

Sold As Vacant

Unique ID

---------  Project Objectives

Standardize date formats

Handle missing property address values

Remove duplicate records

Normalize categorical values

Split address fields into usable components

Improve data quality for downstream analysis and visualization

---------  Data Cleaning Steps

1️ Standardizing Date Formats

Converted raw sale date timestamps into a proper DATE format

Created a new column to store the cleaned sale date

2️ Handling Missing Property Addresses

Identified records with NULL property addresses

Used ParcelID to populate missing addresses from matching records

3️ Address Parsing

Split address fields into individual components:

Property Address → Street Address & City

Owner Address → Street Address, City & State

This makes filtering, grouping, and analysis more efficient.

4️ Normalizing Categorical Values

Converted Y / N values in Sold As Vacant to Yes / No

5️ Duplicate Removal

Identified duplicates using:

Parcel ID

Property Address

Sale Price

Sale Date

Legal Reference

Removed duplicates using ROW_NUMBER() while preserving the original record

6️ Dropping Unused Columns

Removed redundant columns after creating cleaned replacements

---------  Skills & Techniques Used

SQL Data Cleaning

Common Table Expressions (CTEs)

Window Functions (ROW_NUMBER)

String Functions

Conditional Logic (CASE)

Data Type Conversion

Joins & Self-Joins

Table Alterations

---------  Tools & Technologies

Database: PostgreSQL

Language: SQL

------- Data source

The original data file is downloaded from https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/Nashville%20Housing%20Data%20for%20Data%20Cleaning%20(reuploaded).xlsx

There is only one SQL file in the directory for showcases of my Postgre SQL query writing ability only.

Credits give to https://www.youtube.com/@AlexTheAnalyst


--------- Outcome

Cleaned and standardized housing data

Improved data consistency and usability

Dataset ready for exploratory analysis, reporting, or visualization tools

---------  Future Enhancements

Add exploratory data analysis (EDA)

Create housing price trend dashboards

Perform location-based insights

Add indexing for performance optimization
