CREATE DATABASE monitoring;

\c monitoring

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
