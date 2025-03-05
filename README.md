Site do desafio: https://mystery.knightlab.com/

Contexto do desafio: 

![Captura de tela 2025-03-04 170004](https://github.com/user-attachments/assets/6333d48c-18f5-4d59-83a0-b8b45123c15a)

"Um crime ocorreu e o detetive precisa da sua ajuda. O detetive lhe deu o relatório da cena do crime, mas de alguma forma você o perdeu. Você vagamente se lembra que o crime foi um assassinato que ocorreu em algum momento em 15 de janeiro de 2018 e que ocorreu em SQL City . Comece recuperando o relatório da cena do crime correspondente do banco de dados do departamento de polícia."

Modelagem do banco de dados:

![image](https://github.com/user-attachments/assets/a369e2ce-2411-4c81-a8e3-a1f86f208137)


1º Passo: Procurar informoções sobre o assasinato do dia 15 de janeiro de 2018 na tabela crime_scene_report

```sql
SELECT * FROM crime_scene_report 
WHERE date= 20180115 AND type = "murder" AND city = "SQL City"
```

![image](https://github.com/user-attachments/assets/83763cab-3123-4645-a73a-d7d210154a3c)

"Imagens de segurança mostram que havia 2 testemunhas. A primeira testemunha mora na última casa na "Northwestern Dr". A segunda testemunha, chamada Annabel, mora em algum lugar na "Franklin Ave". 

2° Passo: Procurar informações das duas testemunhas

Testemunha 1: 
```sql
SELECT * FROM person
WHERE address_street_name = "Northwestern Dr"
ORDER BY address_number DESC
LIMIT 1
```

![image](https://github.com/user-attachments/assets/b016ef4f-7bd8-4a66-8b17-3279cd9de776)

Testemunha 2:
```sql
SELECT * FROM person
WHERE name LIKE "Annabel%" AND address_street_name = "Franklin Ave"
```

![image](https://github.com/user-attachments/assets/aa5e6fa1-d04b-42d2-8609-eafd8bf1c334)

3º Passo: Procurar seus testemunhos na tabela interview
```sql
SELECT p.id, p.name, i.transcript FROM person p
JOIN interview i
ON p.id = i.person_id
WHERE p.id = 16371 OR p.id = 14887
```

![image](https://github.com/user-attachments/assets/a4fe36d8-064f-4420-b378-8a8cf71a7593)

 "Ouvi um tiro e então vi um homem correndo para fora. Ele tinha uma sacola "Get Fit Now Gym". O número de membro na sacola começava com "48Z". Somente membros Gold têm essas sacolas. O homem entrou em um carro com uma placa que incluía "H42W"."

 "Eu vi o assassinato acontecer e reconheci o assassino da minha academia quando estava malhando na semana passada, dia 9 de janeiro."

 4° Passo: Procurar na tabela get_fit_now_member informações sobre "48Z"
 ```sql
SELECT *
FROM get_fit_now_member
WHERE id LIKE '48Z%' AND membership_status = 'gold'
```
![image](https://github.com/user-attachments/assets/00f7ced4-e07b-4796-9bdb-80721a4c790e)

5º Passo: Procurar junto com a tabela drivers_license qual dos dois tem algum ligamento com esses caracteres da placa
```sql
SELECT p.name, d.plate_number FROM person p
JOIN drivers_license d
ON p.license_id = d.id
WHERE p.name = "Joe Germuska" OR p.name = "Jeremy Bowers"
```

![image](https://github.com/user-attachments/assets/afbb674f-70c6-4474-bc31-94cd3467988d)

6° Solução:
```sql
INSERT INTO solution VALUES (1, 'Jeremy Bowers')
SELECT value
FROM solution
```
![image](https://github.com/user-attachments/assets/eba1e327-5fd7-49d4-89f1-ffdd66801104)

"Parabéns, você encontrou o assassino! Mas espere, tem mais... Se você acha que está pronto para um desafio, tente consultar a transcrição da entrevista do assassino para encontrar o verdadeiro vilão por trás deste crime. Se você se sente especialmente confiante em suas habilidades de SQL, tente completar esta etapa final com no máximo 2 consultas. Use esta mesma instrução INSERT com seu novo suspeito para verificar sua resposta"

7º Passo: Depoimento do assassino

```sql
SELECT *
FROM interview
WHERE person_id = 67318
```
![image](https://github.com/user-attachments/assets/4d69af95-5eba-48e6-b729-42986a8db7b5)

"Fui contratado por uma mulher com muito dinheiro. Não sei o nome dela, mas sei que ela tem cerca de 5'5" (65") ou 5'7" (67"). Ela tem cabelo ruivo e dirige um Tesla Model S. Sei que ela foi ao SQL Symphony Concert 3 vezes em dezembro de 2017."

8º Passo: Procurar sobre a mulher juntando as tabelas person, facebook_event_checkin e drivers_license
```sql
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
```

![image](https://github.com/user-attachments/assets/3b6cdb27-e35b-4178-abb1-27458c79ef39)

9° Passo: Solução
```sql
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;
```

![image](https://github.com/user-attachments/assets/68f644ca-264e-4bd4-b708-e5c3cd168120)
