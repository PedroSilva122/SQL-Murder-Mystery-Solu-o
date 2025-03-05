--Procurando informações sobre o dia 15 de janeiro de 2018

SELECT * FROM crime_scene_report 
WHERE date= 20180115 AND type = "murder" AND city = "SQL City"

--Procurando as testemunhas
--Testemunha 1
  
SELECT * FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 1

--Testemunha 2

SELECT * FROM person
WHERE name LIKE "Annabel%" AND address_street_name = "Franklin Ave"

--Procurar seus testemunhos na tabela interview

SELECT p.id, p.name, i.transcript FROM person p
JOIN interview i
ON p.id = i.person_id
WHERE p.id = 16371 OR p.id = 14887

--Procurar na tabela get_fit_now_member informações sobre "48Z"

SELECT *
FROM get_fit_now_member
WHERE id LIKE '48Z%' AND membership_status = 'gold'

--Procurar junto com a tabela drivers_license qual dos dois tem algum ligamento com esses caracteres da placa

SELECT p.name, d.plate_number FROM person p
JOIN drivers_license d
ON p.license_id = d.id
WHERE p.name = "Joe Germuska" OR p.name = "Jeremy Bowers"

--Solução

INSERT INTO solution VALUES (1, 'Jeremy Bowers')
SELECT value
FROM solution

--Depoimento do assassino

SELECT *
FROM interview
WHERE person_id = 67318

--Procurar sobre a mulher juntando as tabelas person, facebook_event_checkin e drivers_license

SELECT p.id, 
p.name, 
d.height, 
d.hair_color, 
d.gender, 
d.car_make, 
d.car_model  
FROM person p
JOIN drivers_license d
ON p.license_id = d.id
JOIN facebook_event_checkin f
ON p.id = f.person_id
WHERE gender = "female" AND car_make = "Tesla" AND car_model = "Model S"
AND hair_color = "red"
AND height BETWEEN 65 AND 67
LIMIT 1

--Solução

INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;
