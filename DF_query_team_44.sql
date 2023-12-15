SELECT r0991100.evaluatie.leerling_nummer,
r0991100.leerling.voornaam,
r0991100.leerling.achternaam,
r0991100.evaluatie.praktijkles_id,
r0991100.evaluatie.opmerking,
r0991100.evaluatie.score
FROM r0991100.evaluatie
INNER JOIN r0991100.leerling
ON leerling.leerling_nummer = evaluatie.leerling_nummer
INNER JOIN r0991100.praktijkles
ON praktijkles.praktijkles_id = evaluatie.praktijkles_id
WHERE CAST(evaluatie.score AS INTEGER) > 40
ORDER BY evaluatie.score DESC


SELECT r0991100.lesgever.medewerker_nummer,
r0991100.medewerker.voornaam,
r0991100.medewerker.achternaam,
r0991100.medewerker.emailadres,
r0991100.rijbewijs.type_rijbewijs
FROM r0991100.lesgever
INNER JOIN r0991100.rijbewijs
ON rijbewijs.rijbewijs_id = lesgever.rijbewijs_id
INNER JOIN r0991100.medewerker
ON medewerker.medewerker_nummer = lesgever.medewerker_nummer
GROUP BY lesgever.rijbewijs_id,
lesgever.medewerker_nummer,
medewerker.voornaam,
medewerker.achternaam,
medewerker.emailadres,
rijbewijs.type_rijbewijs
HAVING rijbewijs.type_rijbewijs = 'AM'
LIMIT 10

SELECT 
r0991100.praktijkles.praktijkles_id,
r0991100.praktijkles.les_nummer,
r0991100.praktijkles.voertuig_kenteken,
r0991100.les.datum,
r0991100.les.begin_tijd
FROM r0991100.praktijkles
FULL OUTER JOIN r0991100.voertuig
ON voertuig.voertuig_kenteken = praktijkles.voertuig_kenteken
INNER JOIN r0991100.les
ON les.les_nummer = praktijkles.les_nummer
WHERE praktijkles.voertuig_kenteken = 'AAD-004'

SELECT r0991100.administrator.medewerker_nummer,
r0991100.administrator.administrator_id,
r0991100.medewerker.voornaam,
r0991100.medewerker.achternaam,
r0991100.medewerker.emailadres,
r0991100.vestiging.locatie,
r0991100.vestiging.adres
FROM r0991100.administrator
INNER JOIN r0991100.vestiging
ON vestiging.vestiging_id = administrator.vestiging_id
FULL OUTER JOIN r0991100.medewerker
ON medewerker.medewerker_nummer = administrator.medewerker_nummer
WHERE vestiging.locatie != 'NULL'
GROUP BY
administrator.administrator_id,
vestiging.locatie,
administrator.medewerker_nummer,
vestiging.adres,
medewerker.voornaam,
medewerker.achternaam,
medewerker.emailadres
ORDER BY
administrator.administrator_id

SELECT 
r0991100.theorieles.les_nummer,
r0991100.theorieles.les_lokaal,
r0991100.theorieles.leerling_capaciteit,
r0991100.les.datum,
r0991100.lestopic.topic,
r0991100.lestopic.boek,
r0991100.lestopic.prijs
FROM r0991100.theorieles
INNER JOIN r0991100.les
ON les.les_nummer = theorieles.les_nummer
FULL OUTER JOIN r0991100.lestopic
ON lestopic.lestopic_id = les.lestopic_id
GROUP BY
theorieles.les_nummer,
theorieles.les_lokaal,
theorieles.leerling_capaciteit,
les.datum,
lestopic.topic,
lestopic.boek,
lestopic.prijs
HAVING CAST(theorieles.leerling_capaciteit AS INTEGER) < 20
ORDER BY les.datum