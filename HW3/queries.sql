CREATE EXTENSION postgis;

CREATE TABLE my_points (
    id SERIAL PRIMARY KEY,
    long FLOAT,
    lat FLOAT
);

INSERT INTO my_points (long, lat) VALUES
    (117.8251847,30.9293659),
    (117.8264124,30.9308217),
    (117.8250197,30.9308991),
    (117.8235877,30.9311375),
    (117.8206287,30.9294298),
    (117.8181531,30.9296119),
    (117.8179032,30.9294488),
    (117.8170142,30.926907),
    (117.8192175,30.9275877),
    (117.8169507,30.9274439),
    (117.8187303,30.9271229),
    (117.8223145,30.9277855);

CREATE TABLE my_home (
    id SERIAL PRIMARY KEY,
    long FLOAT,
    lat FLOAT
);

INSERT INTO my_home (long, lat) VALUES (117.8240267,30.9279862);

-- compute convex hull
SELECT ST_AsText(ST_ConvexHull(ST_Collect(ST_MakePoint(long, lat)))) AS convex_hull
FROM my_points;

-- compute four nearest neighbor
SELECT my_points.long, my_points.lat, ST_Distance(ST_MakePoint(my_points.lat, my_points.long), ST_MakePoint(my_home.lat, my_home.long))
FROM my_points, my_home
ORDER BY ST_Distance(ST_MakePoint(my_points.lat, my_points.long), ST_MakePoint(my_home.lat, my_home.long))
LIMIT 4;
