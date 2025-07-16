-- 04_helpers.sql
-- Utility and support tables

-- Weekday/weekend flag based on calendar
CREATE TABLE calendar_days AS
SELECT service_id,
  CASE WHEN monday = 1 OR tuesday = 1 OR wednesday = 1 OR thursday = 1 THEN 1 ELSE 0 END AS weekday,
  CASE WHEN friday = 1 OR saturday = 1 OR sunday = 1 THEN 1 ELSE 0 END AS weekend
FROM ptv.calendar;

-- Enriched stop_routes with calendar and vehicle type
DROP TABLE IF EXISTS stops_routes;

CREATE TABLE stops_routes AS
SELECT s.*, r.route_short_name, r.route_long_name,
  CASE WHEN r.route_type = '0' THEN 'tram'
       WHEN r.route_type = '2' THEN 'train'
       WHEN r.route_type = '3' THEN 'bus'
       ELSE 'unknown' END AS vehicle_type,
  CASE WHEN c.monday = 1 OR c.tuesday = 1 OR c.wednesday = 1 OR c.thursday = 1 THEN 1 ELSE 0 END AS weekday,
  CASE WHEN c.friday = 1 OR c.saturday = 1 OR c.sunday = 1 THEN 1 ELSE 0 END AS weekend
FROM ptv.stops s
JOIN ptv.stop_times st ON s.stop_id = st.stop_id
JOIN ptv.trips t ON st.trip_id = t.trip_id
JOIN ptv.routes r ON t.route_id = r.route_id
JOIN ptv.calendar c ON c.service_id = t.service_id;
