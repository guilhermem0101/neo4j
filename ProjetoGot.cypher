//Adicionando meu pesonagem na casa Lannister
MATCH (p:Personagen), (c:Casa)
WHERE c.nome_casa =~ 'Lannister'
AND p.nome =~ 'Guilherme Lannister'
MERGE (p)-[:Pertence]->(c)

// Adicionando sobrenomes por casa
MATCH (c:Casa)<-[per:Pertence]-(p:Personagen)
WHERE c.nome_casa =~ 'Stark'
SET p.nome = coalesce(p.nome, '') + ' Stark'
RETURN *



//Casa Stark
CREATE (c:Casa {nome_casa: 'Stark', membros: ['Arya', 'Bran', 'Brandon', 'Rickard Stark', 'Sansa','Robb', 'Ned']})


//Cnsulta-iii
MATCH (c:Casa)<-[per:Pertence]-(p1:Personagen)-[i:Interage]->(p2:Personagen)
WHERE c.nome_casa =~ 'Stark'
RETURN *


//Colocando meu personagem em uma casas
MATCH (c:Casa {nome_casa: 'Lannister'})
SET c.membros = c.membros + 'Guilherme Lannister'


//Consulta das interações
MATCH (p1) -[i:Interage]->(p2)
RETURN *

//Consulta-i
MATCH (p)-[per:Pertence]->(c) 
RETURN c.nome_casa AS Casa, COUNT(per) AS Quantidade
ORDER BY Quantidade DESC

// Consulta-ii
MATCH (p1)-[i:Interage]-(p2)
RETURN i.parentesco AS Casa, COUNT(i.parentesco) AS Quantidade
ORDER BY Quantidade DESC

//Consulta-iv
MATCH (p1)-[i:Interage]-(p2)
WHERE p1.nome =~ 'Guilherme Lannister'
RETURN *

// Consulta-ix
MATCH (p1)-[i1:Interage]-(p2)-[i2:Interage]-(p3)
WHERE p1.nome =~ 'Tyrion Lannister'
AND p1<>p3
AND NOT (p1)-[:Interage]-(p3)
RETURN p3.nome AS SegundoGrau,p2.nome AS PrimeiroGrua, MAX(i1.peso) AS Peso
ORDER BY Peso DESC

//Consulta-v
MATCH (p1:Personagen {nome: "Jon Snow"}), (p2:Personagen {nome: "Daenerys Targaryen"})
MATCH c=shortestPath((p1)-[:Interage*]-(p2))
RETURN c;


//Consulta-vi
MATCH (p1) -[i:Interage]->(p2)
WHERE i.peso > 50
RETURN *

// Consulta-vii
MATCH (p1)-[i:Interage]-(p2)
WHERE p1.nome =~ 'Tyrion Lannister'
RETURN *

// Consulta-viii
MATCH (p1)-[i1:Interage]-(p2)-[i2:Interage]-(p3)
WHERE p1.nome =~ 'Tyrion Lannister'
AND p1<>p3
AND NOT (p1)-[:Interage]-(p3)
RETURN p3.nome AS SegundoGrau, COLLECT(p2.nome) AS Intermediarios

//Consulta-x
MATCH (p1)-[i1:Interage]-(p2)
WHERE p1.nome = 'Petyr'
AND NOT ((p2)-[:Pertence]->(:Casa {nome_casa:'Stark'}))
AND NOT ((p2)-[:Pertence]->(:Casa {nome_casa:'Lannister'}))
RETURN *


//Consulta-xii
MATCH (p:Personagen)-[i:Interage]-()
WITH p, count(i) AS numIter
RETURN p.nome AS Nome, numIter
ORDER BY numIter DESC


//Criação de conexões
MATCH (p1:Personagen),(r:Relação),(p2:Personagen)
WHERE p1.id_personagem = r.origem
AND p2.id_personagem =  r.alvo
MERGE (p1)-[i:Interage {peso: r.peso }]->(p2)
WITH COUNT(*) AS AFFECTED
RETURN *

//Criando arestas para meu personagem
MATCH (p1:Personagen), (p2:Personagen)
WHERE p1.nome =~ 'Guilherme Lannister' AND p2.nome =~ 'Tywin Lannister'
CREATE (p1)-[i:Interage {peso: 1}]->(p2)


// Criando meu personagem
CREATE (:Personagen {id_personagem: 'GUI', nome: 'Guilherme Lannister'})