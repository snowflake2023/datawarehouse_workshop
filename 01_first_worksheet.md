show databases;
show schemas IN ACCOUNT;

## CREATE TABLES

CREATE OR REPLACE TABLE GARDEN_PLANTS.VEGGIES.ROOT_DEPTH (
 ROOT_DEPTH_ID number(1),
 ROOT_DEPTH_CODE text(1),
 ROOT_DEPTH_NAME text(7),
 UNIT_OF_MEASURE text(2),
 RANGE_MIN number(2),
 RANGE_MAX number(2)
);

INSERT INTO VEGGIES.ROOT_DEPTH(
	ROOT_DEPTH_ID ,
	ROOT_DEPTH_CODE ,
	ROOT_DEPTH_NAME ,
	UNIT_OF_MEASURE ,
	RANGE_MIN ,
	RANGE_MAX 
)
VALUES
(
    3,
    'D',
    'Deep',
    'cm',
    60,
    90
)
;

SELECT * FROM VEGGIES.ROOT_DEPTH;

create table garden_plants.veggies.vegetable_details
(
plant_name varchar(25)
, root_depth_code varchar(1)    
);

## CREATE FILE FORMATS
create file format garden_plants.veggies.PIPECOLSEP_ONEHEADROW 
    TYPE = 'CSV'--csv is used for any flat file (tsv, pipe-separated, etc)
    FIELD_DELIMITER = '|' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
    ;

create file format garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW 
    TYPE = 'CSV'--csv for comma separated files
    SKIP_HEADER = 1 --one header row  
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' --this means that some values will be wrapped in double-quotes bc they have commas in them
    ;

## CREATE A STAGING PATH

CREATE STAGE like_a_window_into_an_s3_bucket
  STORAGE_INTEGRATION = s3_int
  URL = 's3://uni-lab-files'
  FILE_FORMAT = PIPECOLSEP_ONEHEADROW;
  
## READ FILE FROM A STAGED S3 PATH

select $1, $2, $3
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv
(file_format => garden_plants.veggies.L8_CHALLENGE_FF );
 
## LOAD INTO SNOWFLAKE TABLES USING COPY INTO
 
create or replace table vegetable_details_soil_type
( plant_name varchar(25)
 ,soil_type number(1,0)
);

copy into vegetable_details_soil_type
from @util_db.public.like_a_window_into_an_s3_bucket
files = ( 'VEG_NAME_TO_SOIL_TYPE_PIPE.txt')
file_format = ( format_name=PIPECOLSEP_ONEHEADROW );
