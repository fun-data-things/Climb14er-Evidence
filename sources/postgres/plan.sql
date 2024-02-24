SELECT * 
FROM plan
LEFT JOIN trails ON plan.trail_id = trails.id
LEFT JOIN forecast ON plan.forecast_id = forecast.id;