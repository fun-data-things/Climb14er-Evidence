---
title: Climb14er Analytics
---

Product analytics for the Climb14er web app.

```sql most_popular_routes
    SELECT name AS "trail name", COUNT(*) as value
    FROM plan
    GROUP BY 1
```

```sql traffic_by_date
    SELECT start_at::DATE AS "date", COUNT(*) as value
    FROM plan
    GROUP BY 1
```

```sql traffic_by_range
    SELECT 
        start_at::DATE as "date",
        "range",
        COUNT(*) AS value
    FROM plan
    GROUP BY 1, 2
```

```sql risk_levels
    SELECT
        risk_label,
        AVG(risk_score) as avg_risk,
        COUNT(*) as n
    FROM plan
    GROUP BY 1
    ORDER BY 3 DESC
```

## Most Popular Routes
<BarChart
    data={most_popular_routes}
    x="trail name"
    y=value
    xAxisTitle="Trail Name"
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
        />
    </Tab>
    <Tab label="Traffic by Range">
        <BarChart
            data={traffic_by_range}
            x="date"
            y=value
            series="range"
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

