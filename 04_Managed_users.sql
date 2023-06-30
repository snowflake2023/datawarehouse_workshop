/*
With a managed account, your business partners can receive direct share data 
and run queries on it without even becoming a Snowflake customer. 
Managed Account? Reader Account? Sub-Account? All means the same
*/

-- DROP and Create a managed reader account
SHOW MANAGED ACCOUNTS; 
DROP MANAGED ACCOUNT MANAGED_ACCOUNT_FOR_ACME; 
CREATE MANAGED ACCOUNT MANAGED_READER_ADMIN 
ADMIN_NAME = MANAGED_READER_ADMIN , 
ADMIN_PASSWORD = 'Temp12345',
TYPE = READER;

--Share a DB share to a manged/reader/sub account?
--Create new users for manged/reader/sub account
--Set up a Warehouse as Reader Admin
--Set up Resource monitors as Reader Admin
--As reader user, create new DB and new Warehouse


USE ROLE ACCOUNTADMIN;
SHOW RESOURCE MONITORS;
