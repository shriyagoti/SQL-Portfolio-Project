

# Find the total number of accidents, a cyclist met with, also including the description of accident severity.

SELECT ase.accident_severity_description , ct.casualty_type_description, count(*) as Number_of_Accidents
FROM accident_accident_severity ase , casualty_casualty_type ct, casualties c , accidents a
where a.Accident_Index = c.Accident_Index AND a.Accident_Severity=ase.accident_severity_code AND c.casualty_type=ct.casualty_type_code
GROUP BY ase.accident_severity_description , ct.casualty_type_description , ct.casualty_type_code
HAVING ct.casualty_type_code= 1
