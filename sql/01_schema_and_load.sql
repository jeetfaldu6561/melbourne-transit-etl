-- 01_schema_and_load.sql

-- Create schema
CREATE SCHEMA ptv;

-- GTFS: Create and load tables using COPY
CREATE TABLE ptv.agency (
  agency_id NUMERIC,
  agency_name VARCHAR,
  agency_url VARCHAR,
  agency_timezone VARCHAR,
  agency_lang VARCHAR
);

COPY ptv.agency FROM '/data/adata/gtfs/agency.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.calendar (
  service_id VARCHAR PRIMARY KEY,
  monday NUMERIC,
  tuesday NUMERIC,
  wednesday NUMERIC,
  thursday NUMERIC,
  friday NUMERIC,
  saturday NUMERIC,
  sunday NUMERIC,
  start_date DATE,
  end_date DATE
);

COPY ptv.calendar FROM '/data/adata/gtfs/calendar.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.calendar_dates (
  service_id VARCHAR,
  date DATE,
  exception_type NUMERIC
);

COPY ptv.calendar_dates FROM '/data/adata/gtfs/calendar_dates.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.routes (
  route_id VARCHAR,
  agency_id VARCHAR,
  route_short_name VARCHAR,
  route_long_name VARCHAR,
  route_type VARCHAR,
  route_color VARCHAR,
  route_text_color VARCHAR
);

COPY ptv.routes FROM '/data/adata/gtfs/routes.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.stops (
  stop_id VARCHAR,
  stop_name VARCHAR,
  stop_lat FLOAT,
  stop_lon FLOAT
);

COPY ptv.stops FROM '/data/adata/gtfs/stops.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.trips (
  route_id VARCHAR,
  service_id VARCHAR,
  trip_id VARCHAR,
  shape_id VARCHAR,
  trip_headsign VARCHAR,
  direction_id NUMERIC
);

COPY ptv.trips FROM '/data/adata/gtfs/trips.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.shapes (
  shape_id VARCHAR,
  shape_pt_lat FLOAT,
  shape_pt_lon FLOAT,
  shape_pt_sequence NUMERIC,
  shape_dist_traveled FLOAT
);

COPY ptv.shapes FROM '/data/adata/gtfs/shapes.txt' DELIMITER ',' CSV HEADER;

CREATE TABLE ptv.stop_times (
  trip_id VARCHAR,
  arrival_time VARCHAR,
  departure_time VARCHAR,
  stop_id VARCHAR,
  stop_sequence NUMERIC,
  stop_headsign VARCHAR,
  pickup_type NUMERIC,
  drop_off_type NUMERIC,
  shape_dist_traveled VARCHAR
);

COPY ptv.stop_times FROM '/data/adata/gtfs/stop_times.txt' DELIMITER ',' CSV HEADER;
