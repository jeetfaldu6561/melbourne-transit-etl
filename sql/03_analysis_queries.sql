-- 03_analysis_queries.sql
-- Queries for gap analysis, coverage, and density ratio

-- Create stop_vehicle table with one-hot encoding
DROP TABLE IF EXISTS stop_vehicle;
CREATE TABLE stop_vehicle AS
SELECT DISTINCT stop_id, geom,
  CASE WHEN vehicle_type = 'bus' THEN 1 ELSE 0 END AS bus,
  CASE WHEN vehicle_type = 'train' THEN 1 ELSE 0 END AS train,
  CASE WHEN vehicle_type = 'tram' THEN 1 ELSE 0 END AS tram
FROM stops_routes;

-- Create table for stops by LGA
CREATE TABLE lga_stop AS
SELECT lga_name_2021, melbourne_metropolitan_boundary,
  COUNT(DISTINCT stop_id) AS stop_count
FROM ptv.lga_geom, ptv.stops
WHERE ST_Within(geom, melbourne_metropolitan_boundary)
GROUP BY lga_name_2021, melbourne_metropolitan_boundary;

-- Identify LGA and SAL gaps
CREATE TABLE lga_gap AS
SELECT * FROM lga_geom
WHERE lga_name_2021 NOT IN (SELECT DISTINCT lga_name_2021 FROM lga_stop);

CREATE TABLE sal_gap AS
SELECT * FROM sal_geom
WHERE sal_name_2021 NOT IN (SELECT DISTINCT sal_name_2021 FROM sal_stop);

-- Create table for LGA-level vehicle count and ratio
DROP TABLE IF EXISTS lga_vehicle_stop;
CREATE TABLE lga_vehicle_stop AS
SELECT t1.*, t2.area_sqkm FROM
(
  SELECT lga_name_2021, melbourne_metropolitan_boundary,
    SUM(bus) AS bus, SUM(train) AS train, SUM(tram) AS tram
  FROM ptv.lga_geom, ptv.stop_vehicle
  WHERE ST_Within(geom, melbourne_metropolitan_boundary)
  GROUP BY lga_name_2021, melbourne_metropolitan_boundary
) t1
JOIN (
  SELECT lga_name_2021, SUM(CAST(area_albers_sqkm AS FLOAT)) AS area_sqkm
  FROM lga_2021_mel_geom
  GROUP BY lga_name_2021
) t2 ON t1.lga_name_2021 = t2.lga_name_2021;

-- Create top 5 LGA tables by vehicle density
CREATE TABLE lga_bus AS
SELECT * FROM (
  SELECT lga_name_2021, melbourne_metropolitan_boundary, bus, area_sqkm, bus/area_sqkm AS bus_ratio
  FROM lga_vehicle_stop
  ORDER BY bus_ratio DESC
  LIMIT 5
) t;

-- Repeat for train and tram
CREATE TABLE lga_train AS
SELECT * FROM (
  SELECT lga_name_2021, melbourne_metropolitan_boundary, train, area_sqkm, train/area_sqkm AS train_ratio
  FROM lga_vehicle_stop
  ORDER BY train_ratio DESC
  LIMIT 5
) t;

CREATE TABLE lga_tram AS
SELECT * FROM (
  SELECT lga_name_2021, melbourne_metropolitan_boundary, tram, area_sqkm, tram/area_sqkm AS tram_ratio
  FROM lga_vehicle_stop
  ORDER BY tram_ratio DESC
  LIMIT 5
) t;
