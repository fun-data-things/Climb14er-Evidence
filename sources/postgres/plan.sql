SELECT  *, 
        plan.start_at::TIMESTAMP WITH TIME ZONE AT TIME ZONE 'America/Denver' AS local_ts
FROM plan
LEFT JOIN trails ON plan.trail_id = trails.id
LEFT JOIN forecast ON plan.forecast_id = forecast.id;