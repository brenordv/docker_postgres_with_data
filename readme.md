# Pre-loaded Postgres Docker image demo
This is a simple demo of how to create a Postgres docker image pre-loaded with data.


# Dockerfile
```Docker
FROM postgres:latest

COPY ./setup.sql /docker-entrypoint-initdb.d/
```

This is very simple. Just copy every script to the ```/docker-entrypoint-initdb.d/``` folder. (In this case, we have just setup.sql file.)


# Building
```shell
sudo docker build -t post:latest .
```


# Running the image
```shell
sudo docker run -d --env-file ./postgres.env.list -p 5432:5432 -p 5433:5433 --restart=unless-stopped --hostname local_postgres.local --name=postgres -it post
```

The hostname, name and restart parameters are optional, but I like them.


# Settings file
```env
POSTGRES_USER=root
POSTGRES_PASSWORD=secret
```

You should definitely change those settings.


# The SQL script.
First we create the database
```sql 
CREATE DATABASE monitoring;
```

Then we change to that database:
```sql 
\c monitoring
```


and then we create the table...
```sql
CREATE TABLE IF NOT EXISTS measurements
(
	_id serial
		constraint measurements_pk
			primary key,
	correlation_id varchar(36) not null,
	unit varchar(15) not null,
	tag_value numeric(20,6) not null,
	tag_code varchar(50) not null,
	measure_type varchar(20) not null,
	reading_time timestamptz not null
);
```