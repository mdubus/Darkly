# Whatever

## Trouver la faille :

Aller sur `[adresse_ip]/robots.txt` On trouve 2 informations importantes :

```
Disallow: /whatever
Disallow: /.hidden
```

En allant sur `[adresse_ip]/whatever`, on trouve un fichier htpasswd contenant un login et un mot de passe :
`root:8621ffdbc5698829397d97767ac13db3`
On essaye de se connecter sur le site avec ces identifiants mais cela ne fonctionne pas.

Lorsque l'on rentre le mot de passe hashé dans `https://md5hashing.net/` on obtient 'dragon'. Néanmoins, on ne peut pas se loger sur le site (ni sur l'iso) en tant que root avec dragon comme mot de passe.

Mais lorsque l'on va sur l'url '[adresse_ip]/admin', on est redirigé vers leur Secure Area, on entre alors root comme identifiant et dragon comme mot de passe: Et Voilà !! 🎉

```
The flag is : d19b4823e0d5600ceed56d5e896ef328d7a2b9e7ac7e80f4fcdb9b10bcb3e7ff
```

## S'en prémunir :

Sur un site internet, on a souvent envie de bloquer l'utilisation de certaines pages aux utilisateurs, comme la page admin par exemple.

Plusieurs solutions pour s'en prémunir:

**1 - .htaccess**

Afin d'empêcher que n'importe qui accède à des pages on peut très facilement créer une protection par login/mot de passe qui empêche l'accès à tous les fichiers du dossier.

C'est le fichier .htaccess qui permet de dire au serveur qui a le droit d'y accéder ou non.

**2 - Vérifier le role de l'utilisateur**

En effet, au travers des roles définis, des tokens ou des sessions il est facile d'identifier si un utilisateur a accès ou non à une page.
