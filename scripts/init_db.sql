-- Connect to postgres first
\c postgres

DROP DATABASE IF EXISTS "DataWarehouse";
CREATE DATABASE "DataWarehouse";

\c "DataWarehouse"

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;