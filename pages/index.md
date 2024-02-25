---
title: Climb14er Analytics
---

Product analytics for the Climb14er web app.

```sql most_popular_routes
    SELECT name AS "trail name", COUNT(*) as value
    FROM plan
    GROUP BY 1
    LIMIT 10
```

```sql traffic_by_date
    SELECT local_ts::DATE AS "date", COUNT(*) as value
    FROM plan
    GROUP BY 1
```

```sql traffic_by_range
    SELECT 
        local_ts::DATE as "date",
        "range",
        COUNT(*) AS value
    FROM plan
    GROUP BY 1, 2
```

```sql popular_days
    SELECT  EXTRACT(dow FROM local_ts) AS dow_idx,
            CASE 
                WHEN EXTRACT(dow FROM local_ts) = 0 THEN 'Sunday'
                WHEN EXTRACT(dow FROM local_ts) = 1 THEN 'Monday'
                WHEN EXTRACT(dow FROM local_ts) = 2 THEN 'Tuesday'
                WHEN EXTRACT(dow FROM local_ts) = 3 THEN 'Wednesday'
                WHEN EXTRACT(dow FROM local_ts) = 4 THEN 'Thursday'
                WHEN EXTRACT(dow FROM local_ts) = 5 THEN 'Friday'
                WHEN EXTRACT(dow FROM local_ts) = 6 THEN 'Saturday'
            END AS "day of week", 
            COUNT(*) AS "Count of hikes"
    FROM plan
    GROUP BY 1
    ORDER BY 3 DESC
```

```sql risk_levels
    SELECT
        risk_label,
        AVG(risk_score) as avg_risk,
        COUNT(*) as value
    FROM plan
    WHERE start_at::DATE > (NOW()::TIMESTAMP WITHOUT TIME ZONE - INTERVAL '30 days')
    GROUP BY 1
```


## Top-10 Most Popular Routes
<BarChart
    data={most_popular_routes}
    x="trail name"
    y=value
    xAxisTitle="Trail Name"
    colorPalette={
        [
            '#104b0e'
        ]
    }
/>

## 14er Hiking Traffic
<Tabs>
    <Tab label="Total Traffic by Date">
        <LineChart
            data={traffic_by_date}
            x="date"
            y=value
            xAxisTitle="Date"
            yAxisTitle="Planned Hikes"
            colorPalette={
                [
                    '#104b0e'
                ]
            }
        />
    </Tab>
    <Tab label="Traffic by Mountain Range">
        <BarChart
            data={traffic_by_range}
            x="date"
            y=value
            series="range"
            colorPalette={
                [
                    '#104b0e',
                    '#004D2C',
                    '#004E43',
                    '#004D53',
                    '#0B4B59',
                    '#2F4858'
                ]
            }
        />
    </Tab>
    <Tab label="Traffic by Day of Week">
        <BarChart
        data={popular_days}
        x="day of week"
        y="Count of hikes"
        colorPalette={
                [
                    '#104b0e'
                ]
            }
/>
    </Tab>
</Tabs>

## Risk Levels
In the last 30 days the most common risk level was: <b><Value
    data={risk_levels}
    column=risk_label
/> </b>

The Average Risk Score was: <b><Value
    data={risk_levels}
    column=avg_risk
/> </b>

