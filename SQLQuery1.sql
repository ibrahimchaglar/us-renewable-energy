--First, let's examine the total renewable energy consumption by year and sector
SELECT 
    [Year],
    Commercial,
    Electric_Power,
    Industrial,
    Residential,
    Transportation,
    Total_Renewable_Energy,
    (Commercial / Total_Renewable_Energy) * 100 AS Commercial_Percentage,
    (Electric_Power / Total_Renewable_Energy) * 100 AS Electric_Power_Percentage,
    (Industrial / Total_Renewable_Energy) * 100 AS Industrial_Percentage,
    (Residential / Total_Renewable_Energy) * 100 AS Residential_Percentage,
    (Transportation / Total_Renewable_Energy) * 100 AS Transportation_Percentage
FROM (
    SELECT 
        [Year],
        SUM(CASE WHEN [Sector] = 'Commerical' THEN [Total Renewable Energy] ELSE 0 END) AS Commercial,
        SUM(CASE WHEN [Sector] = 'Electric Power' THEN [Total Renewable Energy] ELSE 0 END) AS Electric_Power,
        SUM(CASE WHEN [Sector] = 'Industrial' THEN [Total Renewable Energy] ELSE 0 END) AS Industrial,
        SUM(CASE WHEN [Sector] = 'Residential' THEN [Total Renewable Energy] ELSE 0 END) AS Residential,
        SUM(CASE WHEN [Sector] = 'Transportation' THEN [Total Renewable Energy] ELSE 0 END) AS Transportation,
        SUM([Total Renewable Energy]) AS Total_Renewable_Energy
    FROM 
        dbo.Renewable_Energy
    GROUP BY 
        [Year]
) AS SubQuery
ORDER BY 
    [Year];

--Then, let's examine the electric power consumption by source
SELECT
		[Year],
		SUM([Hydroelectric Power]) AS Hydroelectric,
		SUM([Conventional Hydroelectric Power]) AS Conv_Hydroelectric,
		SUM([Geothermal Energy]) AS Geothermal,
		SUM([Solar Energy]) AS Solar,
		SUM([Wind Energy]) AS Wind,
		SUM([Biomass Energy]) AS Biomass,
		SUM([Total Renewable Energy]) AS Total_Renewable_Energy
FROM dbo.Renewable_Energy
WHERE Sector = 'Electric Power'
GROUP BY [Year]


--Let's make analysis for Solar and Wind (ELECTRIC POWER sector) from 2013 to 2023, in order to see whether there is seasonality or not
SELECT
    Month,
    AVG([Solar Energy]) AS Average_SolarEnergy,
	AVG([Wind Energy]) AS Average_WindEnergy
FROM
    dbo.Renewable_Energy
WHERE
    Sector = 'Electric Power'
    AND Year BETWEEN 2013 AND 2023
GROUP BY
    Month


--Let's make Industrial analysis by energy source
SELECT 
		[Year], 
		SUM([Hydroelectric Power]) AS Hydroelectric,
		SUM([Conventional Hydroelectric Power]) AS ConvHydroelectric,
		SUM([Geothermal Energy]) AS Geothermal,
		SUM([Solar Energy]) AS Solar,
		SUM([Wind Energy]) AS Wind,
		SUM([Biomass Energy]) AS Biomass,
		SUM([Total Renewable Energy]) AS TotalRenewable
FROM dbo.Renewable_Energy 
WHERE Sector = 'Industrial'
GROUP BY [Year] 


--Let's make Biomass Analysis for Industrial sector 
SELECT [Year],
		SUM([Biomass Energy]) AS Total_Biomass,
		SUM([Wood Energy]) AS Wood,
		SUM([Waste Energy]) AS Waste,
		SUM([Fuel Ethanol, Excluding Denaturant]) AS Fuel_Ethanol,
		SUM([Biomass Losses and Co-products]) AS Biomass_Losses_and_Coproducts,
		SUM([Renewable Diesel Fuel]) AS Renewable_diesel_fuel,
		SUM([Other Biofuels]) AS Other,
		SUM([Biodiesel]) AS Biodiesel
FROM dbo.Renewable_Energy
WHERE Sector = 'Industrial'
GROUP BY [Year]


--Let's make analysis about Transportation sector and find the biomass energy over years and its subbranches
SELECT [Year],
		SUM([Biomass Energy]) AS Total_Biomass,
		SUM([Renewable Diesel Fuel]) AS Renewable_diesel_fuel,
		SUM([Fuel Ethanol, Excluding Denaturant]) AS Fuel_Ethanol,
		SUM([Other Biofuels]) AS Other,
		SUM([Biodiesel]) AS Biodiesel
FROM dbo.Renewable_Energy
WHERE Sector = 'Transportation'
GROUP BY [Year]