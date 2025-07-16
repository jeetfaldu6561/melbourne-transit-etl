-- 02_preprocessing.sql
-- Preprocessing: Filtering for Greater Melbourne, geometry creation

-- Create subset of mesh blocks for Greater Melbourne
CREATE TABLE ptv.mb2021_mel AS
SELECT * FROM mb_2021
WHERE gcc_name21 = 'Greater Melbourne';

-- Add geometry to stops
SELECT AddGeometryColumn('ptv.stops', 'geom', 7844, 'POINT', 2);

UPDATE ptv.stops
SET geom = ST_SetSRID(ST_MakePoint(stop_lon, stop_lat), 7844);

-- Join mesh blocks to LGA and SAL tables
DROP TABLE IF EXISTS lga_2021_mel_geom;
CREATE TABLE lga_2021_mel_geom AS
SELECT l.*, m.wkb_geometry
FROM ptv.mb2021_mel m
JOIN ptv.lga_2021 l ON m.mb_code21 = l.mb_code_2021;

CREATE TABLE sal_2021_mel_geom AS
SELECT s.*, m.wkb_geometry
FROM ptv.mb2021_mel m
JOIN ptv.sal_2021 s ON m.mb_code21 = s.mb_code_2021;

-- Union mesh block shapes to form overall metro shape
CREATE TABLE Melbourne_Metropolitan AS
SELECT ST_Union(wkb_geometry) AS melbourne_metropolitan_boundary
FROM ptv.mb2021_mel;

-- Create spatial boundaries for LGA and SAL
CREATE TABLE lga_geom AS
SELECT lga_name_2021, ST_Union(wkb_geometry) AS melbourne_metropolitan_boundary
FROM ptv.lga_2021_mel_geom
GROUP BY lga_name_2021;

CREATE TABLE sal_geom AS
SELECT sal_name_2021, ST_Union(wkb_geometry) AS melbourne_metropolitan_boundary
FROM ptv.sal_2021_mel_geom
GROUP BY sal_name_2021;
