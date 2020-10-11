# ---------------------------------------------------
#                 OPEN DATASETS  
#                   Wikipedia
# ----------------------------------------------------

# Top 10 Paginas mas vistas en Español.
SELECT 
  title, 
  SUM(views) AS total_views
FROM 
  `bigquery-public-data.wikipedia.pageviews_2020` 
WHERE 
  wiki IN ('es', 'es.m') AND datehour>='2020-01-01'
GROUP BY title
ORDER BY 2 DESC
LIMIT 10;

# Visitas por meses a la pagina en Wikipedia de la Universidad Nacional de Colombia
 SELECT
  title, 
  EXTRACT(MONTH FROM datehour) AS month_number,
  FORMAT_DATE('%B',EXTRACT(DATE FROM datehour)) AS month,
  SUM(views) AS total_views
FROM 
  `bigquery-public-data.wikipedia.pageviews_2020` 
WHERE 
  title = "Universidad_Nacional_de_Colombia"
  AND datehour>='2020-01-01' 
  GROUP BY title, month_number, month
  ORDER BY month_number ASC;

# ---------------------------------------------------
#             EXTERNAL DATASETS  
#                   Fligths 
# ----------------------------------------------------

# Demanda por dias 
SELECT 
FL_DATE,
COUNT(FL_NUM) fligths
FROM 
`bda-demo-292118.bda_dataset.fligths`
GROUP BY FL_DATE
ORDER BY FL_DATE ASC; 

# Porcentaje de cancelacion por aerolinea
SELECT 
UNIQUE_CARRIER,
ROUND((SUM(CAST(CANCELLED AS FLOAT64))/COUNT(FL_NUM))*100,4) AS percentage_cancelled
FROM 
`bda-demo-292118.bda_dataset.fligths`
GROUP BY UNIQUE_CARRIER
ORDER BY percentage_cancelled DESC; 

# Cual es el dia mas popular para viajar?.
SELECT 
  CASE 
    WHEN day_of_week = 1 THEN 'Domingo'
    WHEN day_of_week = 2 THEN 'Lunes'
    WHEN day_of_week = 3 THEN 'Martes'
    WHEN day_of_week = 4 THEN 'Miercoles'
    WHEN day_of_week = 5 THEN 'Jueves'
    WHEN day_of_week = 6 THEN 'Viernes'
    WHEN day_of_week = 7 THEN 'Sabado'
  END Weekday,
  number_flights
FROM
(
  SELECT
  EXTRACT(DAYOFWEEK FROM FL_DATE) as day_of_week,
  COUNT(FL_NUM) AS number_flights
  FROM 
  `bda-demo-292118.bda_dataset.fligths` 
  GROUP BY day_of_week
  ORDER BY number_flights DESC
);