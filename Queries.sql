

# Find the total number of accidents, a cyclist met with, also including the description of accident severity.

SELECT ase.accident_severity_description , ct.casualty_type_description, count(*) as Number_of_Accidents
FROM accident_accident_severity ase , casualty_casualty_type ct, casualties c , accidents a
where a.Accident_Index = c.Accident_Index AND a.Accident_Severity=ase.accident_severity_code AND c.casualty_type=ct.casualty_type_code
GROUP BY ase.accident_severity_description , ct.casualty_type_description , ct.casualty_type_code
HAVING ct.casualty_type_code= 1


# Find the number of casualties in the Urban area including the type of casualty severity and the urban or rural area description.

SELECT ua.urban_or_rural_area_description , cs.casualty_severity_description, count(*) as Number_of_casualties_in_Urban
FROM accidents a , accident_urban_or_rural_area ua, casualties c , casualty_casualty_severity cs
WHERE a.Accident_Index=c.Accident_Index AND cs.casualty_severity_code=c.Casualty_Severity
GROUP BY ua.urban_or_rural_area_description , cs.casualty_severity_description , ua.urban_or_rural_area_code
HAVING ua.urban_or_rural_area_code=1

# Finding the count of pedestrian movement at the junction location when leaving the main road and ordering by the count. [Uncorrelated Subquery]

select pm.pedestrian_movement_description,count(pm.pedestrian_movement_description) as count
from vehicles v, casualties c, vehicle_junction_location jl, casualty_pedestrian_movement pm
where v.Accident_Index = c.Accident_Index AND v.Junction_Location=jl.junction_location_code AND pm.pedestrian_movement_code = c.Pedestrian_Movement
and junction_location_code=(select junction_location_code from vehicle_junction_location where junction_location_description='Leaving main road')
group by pm.pedestrian_movement_description
order by count


