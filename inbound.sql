
alter database SFC_SAMPLES_SAMPLE_DATA
rename to snowflake_sample_data;

--run with ACCOUNTADMIN role
GRANT IMPORTED PRIVILEGES
ON DATABASE SNOWFLAKE_SAMPLE_DATA
TO ROLE SYSADMIN;

SELECT count(N_NAME)
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION;

--Check the range of values in the Market Segment Column
SELECT DISTINCT c_mktsegment
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER;

--Find out which Market Segments have the most customers
SELECT c_mktsegment, COUNT(*)
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER
GROUP BY c_mktsegment
ORDER BY COUNT(*);

--Check the range of values in the Market Segment Column
SELECT DISTINCT c_mktsegment
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER;

--Find out which Market Segments have the most customers
SELECT c_mktsegment, COUNT(*)
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER
GROUP BY c_mktsegment
ORDER BY COUNT(*);
